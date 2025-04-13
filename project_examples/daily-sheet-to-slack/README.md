## ✅ `README.md` for `daily-sheet-to-slack`

# 📊 Daily Sheet Summary Notifier (Google Apps Script → Slack)

This script automatically sends the **latest entries** from a Google Sheet to a specified Slack channel on a **daily schedule**.

Ideal for:
- 📝 Daily task or incident reports
- ✅ Status sharing across teams
- 🧑‍💻 Simple automations without external servers

---

## ✅ Features

- 📅 Daily Slack notification at scheduled time (e.g., 09:00 JST)
- 🔍 Sends the latest **N rows** from a specified sheet
- 🔒 Uses Slack Incoming Webhooks (no bot token required)
- 🛠 Configurable via script properties

---

## ⚙️ Configuration

### 1. Setup Script Properties

Open **Apps Script Editor** → `File → Project Properties → Script Properties`  
Add the following:

| Key | Value | Description |
|-----|-------|-------------|
| `SLACK_WEBHOOK_URL` | `https://hooks.slack.com/services/xxxx/yyyy/zzzz` | Slack Incoming Webhook |
| `SHEET_ID` | `xxxxxxxxxxxxxxxxxxxx` | Google Sheet ID |
| `SHEET_NAME` | `Sheet1` (or your custom name) | Target sheet name |
| `ROW_LIMIT` | `5` | Number of rows to notify (default is 5) |

---

### 2. Paste the Script

Paste the script into `main.gs`:

```javascript
const SLACK_WEBHOOK_KEY = "SLACK_WEBHOOK_URL";
const SHEET_ID_KEY = "SHEET_ID";
const SHEET_NAME_KEY = "SHEET_NAME";
const ROW_LIMIT_KEY = "ROW_LIMIT";

// main function (to be implemented)
function sendDailySheetSummary() {
  // Read config & send data
}
```

> ⚠ You will implement the actual logic in `sendDailySheetSummary()` later.

---

### 3. Set Up Trigger

- Go to Apps Script Editor → Triggers (⏰ icon)
- Add new trigger:
  - Function: `sendDailySheetSummary`
  - Event source: `Time-driven`
  - Type: `Day timer` → Select time (e.g., 09:00)

---

## 🧪 Expected Slack Message Example

```
📊 Daily Report (last 5 entries):

1. [2025-04-13] John Doe | Task A | ✅
2. [2025-04-13] Jane Smith | Task B | 🕒
3. ...
```

---

## 🗂 Project Structure

```
daily-sheet-to-slack/
├── main.gs                # GAS main script
├── README.md              # This guide
├── assets/                # Setup screenshots

---

## 📄 License

MIT License — feel free to fork, reuse, or customize this!

---
