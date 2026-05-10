# Task CLI — Design Memo

## Problem

Information scattered across multiple channels — chat, email, verbal, shared storage.
Spreadsheet-based tracking fails because update cost is too high → tasks get missed.

---

## Data Flow

```
[ Input Sources ]
  Chat ─────────┐
  Email ─────────┼──► PS CLI (add-task / update-task / done)
  Verbal ───────┘         │
  Shared storage ──────────┘
                           │
                           ▼
                    [ tasks.json ]
            (local file, 1 file per project)

            {
              id, title, keywords[],
              url, filePath,
              deadline, dependsOn[],
              status: "open|done"
            }

                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
       list-tasks     filter-tasks    done <id>
     (all open)      (keyword/date)  (mark complete)
            │
            ▼
       console output or CSV export
```

---

## CLI Interface

```powershell
# Add task
add-task -title "Review firewall config" -keyword "network,fw" -deadline 2026-05-15

# List all
list-tasks

# Filter by keyword
list-tasks -keyword "network"

# Due soon
list-tasks -soon 3   # within 3 days

# Mark complete
done 003

# Check dependencies
list-tasks -blocked   # dependsOn not yet complete

# Open saved URL
open 003
```

---

## Interactive Mode

On launch, displays a banner and waits for commands.

```
========================================
  Task CLI v1.0
========================================
  add     : add task
  list    : list all
  find    : keyword search
  soon    : due within N days
  blocked : waiting on dependencies
  done    : mark complete
  open    : open saved URL in browser
  exit    : quit
========================================
>
```

Example session:

```
> add Review firewall config network,fw 2026-05-15
> list
> find network
> soon 3
> done 003
> open 003
```

---

## URL Handling

Long URLs are stored and launched without manual copy-paste:

- **Storage:** full string in JSON (no length limit)
- **Display:** truncated with `...` in list view
- **Launch:** `open <id>` calls `Start-Process` → opens in browser

```
[003] Review firewall config | due:05-15 | network,fw
      URL: https://example.com/chat/thread/abc123... (truncated)

> open 003
→ URL opens in browser
```

---

## Daily Workflow

```
Morning: list-tasks -soon 3 → confirm today's priorities
         │
New info → add-task immediately (including verbal)
         │
Done → done <id>
         │
Evening: list-tasks → review remaining items
```

---

## Trello vs Task CLI

| Factor | Trello | Task CLI |
|--------|--------|----------|
| Setup | Browser + login | Copy `.ps1`, run |
| Input speed | Open browser → card → fill fields | 1 line |
| Enterprise restrictions | May be blocked | Not applicable — local only |
| URL/link management | Manual paste | Stored as structured field |
| Dependency tracking | Power-Up (paid) | dependsOn field |
| Search | GUI | keyword filter |
| Update cost | GUI clicks | 1 command |
| Offline | No | Yes |
| Customization | Plan-limited | Edit the script |

**Conclusion:** In restricted enterprise environments, local PS script outperforms SaaS for speed and availability.

---

## Error Design

**Principle: never crash. Show error code. Let the user recover.**

- Missing required field → use default, continue
- Corrupted JSON → restore from backup
- Unexpected error → show error code, do not throw

### Error Codes

| Code | Cause | Recovery |
|------|-------|----------|
| E001 | tasks.json not found | Create new file, continue |
| E002 | tasks.json parse failed | Restore from backup |
| E003 | Task ID not found | Show message, continue |
| E004 | Invalid deadline format | Register without deadline, warn |
| E005 | Unknown ID in dependsOn | Warn only, register anyway |
| E006 | URL cannot be opened | Print URL to console for manual use |
| E007 | Backup restore failed | Initialize with empty tasks.json |

### Implementation Pattern

```powershell
try {
    $tasks = Get-Content tasks.json | ConvertFrom-Json
} catch {
    Write-Host "[E002] Failed to load tasks.json. Restoring from backup."
    # restore logic
}
```

---

## Status

Design phase. Not yet implemented.
