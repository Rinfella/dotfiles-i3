# SIKSIL IoT Cloud & Voice Assistants Platform

## Overview
- **Path**: `/home/rf/projects/siksil/iot-siksil`
- **Reverse Proxy / Ingress**: `/home/rf/projects/siksil/inpui-vps`
- **Domain**: `iot.siksil.cloud`
- **Purpose**: Unified IoT platform powering ESP32 hardware fleets with real-time shadow synchronization (MQTT/EMQX), NVS configuration management (v4), OTA firmware deployment, and cloud-to-cloud voice assistant integrations (Amazon Alexa Smart Home Skill v3 and Google Home Cloud-to-Cloud).

## Architecture & Container Topology
1. **Shared Ingress Network (`inpui_network`)**:
   - `nginx` runs in `inpui-vps` stack, terminates TLS (Cloudflare Origin CA cert at `/etc/nginx/ssl`), and proxies `iot.siksil.cloud` traffic to `iot-api:8000`.
   - Vhost template: `inpui-vps/nginx/templates/iot.siksil.cloud.conf.template`.
   - `iot-api` attaches to both internal compose network and `inpui_network` (external).
2. **Backend Stack (`iot-siksil/backend`)**:
   - `iot-api`: FastAPI Python 3.12 (uv) listening on internal port 8000.
   - `iot-postgres`: PostgreSQL 18-alpine (`host port 5434 -> container 5432`).
   - `iot-redis`: Redis 7-alpine (`host port 6381 -> container 6379`).
   - `iot-emqx`: EMQX 5.8.4 (`ports 1883, 8083, 18083`).

## Voice Assistant Integration Specifications

### 1. Multi-Client OAuth 2.0 (RFC 6749)
- **Endpoints**:
  - `GET /oauth/authorize` (HTML consent form)
  - `POST /oauth/authorize` (auth code generation)
  - `POST /oauth/token` (code exchange and refresh token rotation with RFC 6749 JSON error responses)
- **Multi-Client Config**: Configured via `OAUTH_CLIENTS_RAW` JSON string in `.env`.
  ```json
  {"siksil-alexa":{"secret":"<ALEXA_SECRET>","name":"Amazon Alexa"},"siksil-google":{"secret":"<GOOGLE_SECRET>","name":"Google Home"}}
  ```
- **Token Format**: Asymmetric RS256 JWT access tokens (15m expiry), Redis-backed opaque refresh tokens (30d expiry).

### 2. Amazon Alexa (Smart Home Skill v3)
- **Webhook Endpoint**: `POST https://iot.siksil.cloud/voice/alexa`
- **Directives Supported**:
  - `Alexa.Discovery` (`Discover`): Capability-aware endpoint discovery (Relays, Dimmers).
  - `Alexa.PowerController` (`TurnOn`, `TurnOff`): Dispatches MQTT commands and updates shadow desired state.
  - `Alexa.BrightnessController` (`SetBrightness`, `AdjustBrightness`): Clamped (0-100%) brightness control.
  - `Alexa` (`ReportState`): Returns real-time property values from device shadow.
- **AWS Infrastructure**:
  - Region: `us-east-1` (N. Virginia).
  - Edge Proxy: AWS Lambda (`SiksilAlexaProxy`, Python 3.12, 128MB, 6s timeout).
  - IAM Role: `SiksilAlexaBridgeRole` with CloudWatch logging only (`logs:CreateLogGroup`, `logs:CreateLogStream`, `logs:PutLogEvents` for `/aws/lambda/SiksilAlexaProxy:*`).
  - Trigger: Alexa Smart Home (`alexa-connectedhome.amazon.com`) bound to Skill ID (`amzn1.ask.skill.*`).

### 3. Google Home (Cloud-to-Cloud / Actions on Google)
- **Fulfillment Endpoint**: `POST https://iot.siksil.cloud/voice/google`
- **Intents Supported**:
  - `action.devices.SYNC`: Capability-aware device discovery (`types.LIGHT`, `types.SWITCH`, traits `OnOff`, `Brightness`).
  - `action.devices.QUERY`: Reports current shadow reported state.
  - `action.devices.EXECUTE`: Executes `commands.OnOff` and `commands.BrightnessAbsolute`.
  - `action.devices.DISCONNECT`: Unlinks user account, clears `google_agent_user_id` across account devices.
- **GCP Infrastructure**:
  - API: HomeGraph API (`homegraph.googleapis.com`) enabled.
  - Service Account: `siksil-homegraph@<PROJECT>.iam.gserviceaccount.com`.
  - IAM Role: Strictly `roles/homegraph.admin` (least privilege).
  - Service Key: `/app/service-account-key.json` mounted read-only into `iot-api`.
  - Proactive State Reporting: `src/voice/proactive.py` pushes device updates to HomeGraph on every MQTT reported shadow update.

## Required Environment Variables (`backend/.env`)
```ini
# Application
ENVIRONMENT=production
PORT=8000
SECRET_KEY=<SECURE_RANDOM_KEY>

# Database & Cache
DATABASE_URL=postgresql+asyncpg://siksil:<POSTGRES_PASSWORD>@postgres:5432/siksil_prod
REDIS_URL=redis://redis:6379/0

# MQTT (EMQX)
MQTT_BROKER_HOST=emqx
MQTT_BROKER_PORT=1883
MQTT_CLIENT_ID=siksil_cloud_service

# OAuth 2.0 Multi-Client (Alexa & Google)
OAUTH_CLIENTS_RAW={"siksil-alexa":{"secret":"<ALEXA_SECRET>","name":"Amazon Alexa"},"siksil-google":{"secret":"<GOOGLE_SECRET>","name":"Google Home"}}

# Google HomeGraph Service Account
GOOGLE_SERVICE_ACCOUNT_KEY=/app/service-account-key.json
```

## Key Commands
```bash
# Run test suite
cd /home/rf/projects/siksil/iot-siksil/backend
uv run pytest tests/test_flow.py -v

# Run virtual ESP32 device simulator
uv run python tests/mock_device.py

# Rebuild and start container stack
docker compose up -d --build
```
