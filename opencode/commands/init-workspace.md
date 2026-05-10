---
description: Initializes complete AI workspace in the current project with shared knowledge base and per-agent configs.
---

This command sets up the project with:
1. Shared knowledge base at `.ai/`
2. Agent-specific configs for OpenCode, Gemini, Codex
3. GNU Stow symlinks for each agent

## Prerequisites
- GNU Stow must be installed: `brew install stow` or `sudo apt install stow`

## Steps:
1. Ensure you are in the project root directory.
2. Run the bootstrap script below.
3. Update `.ai/context/architecture.md` with project details.
4. Update agent configs (`.opencode.json`, `.gemini.json`, `.codex.json`) as needed.

## Bootstrap Script

```bash
#!/usr/bin/zsh

KB_SOURCE="$HOME/.config/opencode/kb"
TARGET_KB=".ai"
AGENTS="opencode gemini codex"

echo "🚀 Initializing AI Workspace..."

# 1. Setup Shared Knowledge Base
if [ ! -d "$TARGET_KB" ]; then
    echo "📦 Copying knowledge base..."
    cp -r "$KB_SOURCE/project/*" "$TARGET_KB/"
    echo "✅ Knowledge base initialized at .ai/"
else
    echo "⚠️ .ai/ already exists. Skipping."
fi

# 2. Generate Agent Configs
for agent in $AGENTS; do
    config_file=".$agent.json"
    if [ ! -f "$config_file" ]; then
        cat << EOF > "$config_file"
{
  "\$schema": "https://opencode.ai/config.json",
  "instructions": [
    ".ai/rules/00-global-directives.md",
    ".ai/rules/01-tall-stack.md",
    ".ai/context/architecture.md"
  ]
}
EOF
        echo "✅ Created $config_file"
    else
        echo "⚠️ $config_file exists. Skipping."
    fi
done

# 3. Generate Stow Symlinks
mkdir -p .stow
for agent in $AGENTS; do
    if [ ! -L ".stow/$agent" ]; then
        ln -s ../.ai .stow/$agent
        echo "✅ Stow link: .stow/$agent -> .ai/"
    fi
done

# 4. Gitignore
if ! grep -q "^\.ai$" .gitignore 2>/dev/null; then
    echo ".ai" >> .gitignore
    echo "🔒 Added .ai/ to .gitignore"
fi

if ! grep -q "^\.opencode\.json$" .gitignore 2>/dev/null; then
    echo ".opencode.json" >> .gitignore
    echo ".gemini.json" >> .gitignore
    echo ".codex.json" >> .gitignore
    echo "🔒 Added agent configs to .gitignore"
fi

# 5. Optional Project-Specific MCP
if [ ! -f ".opencode.local.json" ]; then
    cat << 'EOF' > .opencode.local.json
{
  "mcp": {
    "mariadb-local": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-mysql", "mysql://root:password@localhost:3306/DATABASE"]
    },
    "git": {
      "type": "local",
      "command": ["uvx", "mcp-server-git", "--repository", "WORKDIR"]
    }
  }
}
EOF
    echo "✅ Created .opencode.local.json (modify for your DB)"
fi

echo ""
echo "🎉 Workspace initialized!"
echo "Next steps:"
echo "1. Edit .ai/context/architecture.md with project details"
echo "2. Edit .opencode.json, .gemini.json with your API keys"
echo "3. Run 'stow -S .stow/opencode' to activate OpenCode"
echo "4. Run 'opencode' to start coding"
