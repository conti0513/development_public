# 📊 Daily Sheet → Slack Notifier (Google Apps Script)

A simple automation tool that posts the **latest N rows** from a Google Spreadsheet to a **Slack channel**, triggered on a daily schedule.

---

## 🌟 Use Cases | 想定ユースケース

- 📝 Daily task updates / team reporting（毎日の業務報告）
- 🛠 Lightweight incident log sharing（軽量なインシデント報告）
- 🧑‍💻 Serverless & secure – runs fully on GAS（サーバ不要、GAS上で完結）

---

## ✅ Key Features

- ⏰ Daily scheduled Slack notifications (e.g., 09:00 JST)
- 📄 Sends the latest N rows from a Google Sheet
- 🔒 Uses Slack Incoming Webhook – no Slack app or token required
- ⚙️ Easy setup via Script Properties

---

## 🧩 Input / Output Samples

### 🔹 Google Spreadsheet (Input)

![Spreadsheet Example](assets/sample_spreadsheet_daily_report.png)

### 🔹 Slack Message (Output)

![Slack Notification Example](assets/sample_slack_notification_result.png)

---

## ⚙️ How to Set Up

### 1. Folder Structure

```
daily-sheet-to-slack/
├── main.gs                # GAS main logic
├── README.md              # Documentation (this file)
└── assets/                # Sample screenshots
```

---

### 2. Script Properties

In Apps Script Editor:  
Go to `File` → `Project Properties` → `Script Properties`  
Set the following:

| Key               | Example Value                          | Notes                         |
|------------------|----------------------------------------|-------------------------------|
| `SHEET_ID`        | `1a2b3c...`                            | Google Spreadsheet ID         |
| `SHEET_NAME`      | `DailyReport`                         | Sheet tab name                |
| `ROW_LIMIT`       | `5`                                   | Number of rows to send        |
| `SLACK_WEBHOOK_URL` | `https://hooks.slack.com/services/...` | Slack Webhook URL             |

---

### 3. Trigger Setup

1. Open Script Editor  
2. Click the ⏰ "clock" icon (Triggers)  
3. Add new trigger for `sendDailyUpdate()`  
   - Type: Time-driven → Day timer  
   - Time: e.g., 09:00 JST

---

### 4. Sample Output

```
📊 Daily Report – Last 5 Entries:
1. [2025-04-13] User A | Submit report | ✅ Done
2. [2025-04-13] User B | Review documents | ℹ️
3. [2025-04-14] User A | Update client info | 🕒 In progress
...
```

---

## 💡 Client Benefits (Why This Helps)

- ⏱ Save time: no more copy-pasting reports
- 📉 Reduce errors: automatic, consistent output
- 📲 Better communication: real-time team awareness
- 🌍 Runs in the cloud – works globally, no server setup

---

## 🤝 Why Work With Me

- 💬 Bilingual Support (EN 🇺🇸 / JP 🇯🇵)
- ⚙️ Expert in GAS, automation, Slack API
- 🏢 10+ years in corporate IT / internal tools
- 🔧 Customizable and client-friendly coding style

---

## 📄 License

MIT License – free to use, modify, and share!

---

## 👤 Author

Developed by [@conti0513](https://github.com/conti0513)  
Open to feedback, requests, or custom implementations!
```
