# Additional MCP Servers

## Project-Specific MCPs (add to .opencode.local.json)

### PostgreSQL
```json
"postgres": {
  "type": "local",
  "command": ["npx", "-y", "@modelcontextprotocol/server-postgres", "postgresql://user:pass@localhost:5432/db"]
}
```

### Docker
```json
"docker": {
  "type": "local", 
  "command": ["npx", "-y", "@modelcontextprotocol/server-docker"]
}
```

### Search (Code Search)
```json
"search": {
  "type": "local",
  "command": ["npx", "-y", "@modelcontextprotocol/server-search", "/", "*.php"]
}
```

### AWS (S3, etc.)
```json
"aws": {
  "type": "local",
  "command": ["npx", "-y", "@modelcontextprotocol/server-aws-kb"]
}
```

## Notes

- These require specific setup per project
- Add to `.opencode.local.json` after initialization
- Some require credentials/API keys