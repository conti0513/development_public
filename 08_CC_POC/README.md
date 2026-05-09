# 08_CC_POC: AI Agent Driven Development Kit

## Overview
This directory is a research POC for AI-assisted development workflows using Claude Code (CC).
It serves as a structured workspace for building and experimenting with multiple projects efficiently.

## Folder Structure Policy

```
08_CC_POC/
  CLAUDE.md              # Global CC rules (applied to all projects)
  README.md              # This file — overview and policy
  setup.sh               # Environment setup
  │
  ├── _templates/        # Reusable starter templates for new projects
  │     └── nextjs-starter/
  │
  └── {project-name}/    # One folder per project
        ├── CLAUDE.md    # Project-specific CC instructions
        ├── README.md    # How to run this project
        └── src/
```

### Rules
- **One folder per project.** Each project is self-contained with its own `CLAUDE.md` and `README.md`.
- **Two-layer CLAUDE.md.** Global rules live at the root; project-specific rules live inside each project folder.
- **Use `_templates/` as the starting point** when creating a new project.
- **No loose files at root.** All work lives inside a named project folder.

## Security
- API keys are managed via GitHub Codespaces Secrets, not `.env` files.
- Set `ANTHROPIC_API_KEY` in GitHub Settings > Codespaces > Secrets.

## How to Start
1. Register `ANTHROPIC_API_KEY` in GitHub Settings > Codespaces > Secrets.
2. Run `sh setup.sh`.
3. Launch `claude`.

---
*This workspace prioritizes clean structure, reusability, and secure AI integration.*
