#!/bin/bash
echo "🚀 Claude Code Starter Kit Setup..."

# 1. Install Claude Code globally
echo "📦 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# 2. Environment Variable Check
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "⚠️  Warning: ANTHROPIC_API_KEY is not set."
    echo "💡 Please add it to GitHub Codespaces Secrets for the best experience."
else
    echo "✅ ANTHROPIC_API_KEY detected from environment."
fi

echo "✅ Setup complete! Run 'claude auth' to authenticate."
