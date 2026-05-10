# Task CLI

A lightweight PowerShell-based task manager for teams working in constrained enterprise environments.

## Problem

Information arrives through multiple channels — chat, email, verbal, shared drives.
Without a fast capture method, tasks get missed. Spreadsheet-based tracking fails because update cost is too high.

## Solution

A single `.ps1` script. No install. No external services. One-line input.

## Features

- **Zero dependencies** — `.ps1` file only. No npm, no DB.
- **Download and run** — PowerShell is built into Windows.
- **No IT approval needed** — fully local, no external SaaS.
- **One-line input** — capture tasks the moment they arrive.

## Commands

```powershell
# Add a task
add-task -title "Review firewall config" -keyword "network,fw" -deadline 2026-05-15

# List all open tasks
list-tasks

# Filter by keyword
list-tasks -keyword "network"

# Tasks due within N days
list-tasks -soon 3

# Tasks blocked by incomplete dependencies
list-tasks -blocked

# Mark complete
done 003

# Open saved URL in browser
open 003
```

## Data Fields

| Field | Description |
|-------|-------------|
| title | Task name |
| keywords | Related tags (multiple allowed) |
| url | Link to related chat or document |
| filePath | Path to related file or folder |
| deadline | Due date |
| dependsOn | Prerequisite task IDs |
| status | open / done |

## Requirements

- PowerShell 5.1+ (Windows built-in)
- No additional installs required

## Why Not SaaS

| Factor | SaaS Tools | Task CLI |
|--------|-----------|----------|
| Setup | Browser, login, org approval | Copy `.ps1`, run |
| Input speed | Open browser → create card → fill fields | 1 line |
| Enterprise restrictions | Often blocked | Not applicable — local only |
| Offline | No | Yes |
| Customization | Plan-limited | Edit the script |

## Status

Design phase. See [DESIGN_MEMO.md](./DESIGN_MEMO.md) for architecture details.
