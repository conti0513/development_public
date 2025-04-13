# Google Form + Zapier + GAS Logger

A hybrid automation setup that uses Zapier to handle Google Form submissions, notifies Slack, and logs the data into a Google Spreadsheet via Google Apps Script (GAS).

---

## ✅ Features

- ✉️ Google Form responses trigger automation
- 🔔 Slack notifications via Zapier
- 📄 Log each submission into Google Spreadsheet using custom GAS webhook
- 💡 No database needed / lightweight / easy to deploy

---

## ⚙️ Architecture Overview

```text
[Google Form] → (Zapier) → [Slack notification]
                              ↓
                          [Webhook to GAS] → [Google Spreadsheet logging]
```

---

## 🛠️ Setup Guide

### 1. Prepare Google Form & Spreadsheet

- Create a Google Form with 3 fields:
  - Name
  - Email
  - Message
- Link the Form to a Google Spreadsheet (Form response sheet)
- Create a second sheet called `"log"` inside the same spreadsheet

---

### 2. Deploy GAS Webhook

1. Open **Apps Script Editor** from the linked spreadsheet  
2. Paste this script into `main.gs`:

```javascript
function doPost(e) {
  const data = JSON.parse(e.postData.contents);
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("log");

  sheet.appendRow([
    new Date(),
    data.name,
    data.email,
    data.message
  ]);

  return ContentService.createTextOutput("OK");
}
```

3. Deploy as Web App:
   - Click `Deploy → Manage deployments`
   - Select "Web App"
   - Set access as **Anyone**
   - Copy the **Web App URL** (you’ll need this for Zapier)

---

### 3. Configure Zapier

#### Trigger
- App: Google Forms (via Google Sheets)
- Event: New Spreadsheet Row
- Spreadsheet: Link the one used above

#### Action 1 (optional)
- App: Slack
- Action: Send Channel Message
- Customize message with form fields

#### Action 2
- App: Webhooks by Zapier
- Action: POST
- URL: Paste the Web App URL from step 2
- Payload type: `json`
- Data:
  - `name`: `{{form name field}}`
  - `email`: `{{form email field}}`
  - `message`: `{{form message field}}`

---

## 💬 Slack Example Output

```
📩 New Form Submission!
Name: Jane Doe
Email: jane@example.com
Message: Looking forward to your reply!
```

---

## 📂 Folder Structure

```bash
zapier_form_notify_logger/
├── main.gs
├── README.md
├── assets/
│   ├── zapier_setup.png
│   ├── form_sample.png
│   └── trigger_test.png
└── notes/
    └── implementation_notes.md
```

---

## 💡 Use Cases

- Lead capture forms
- Internal IT helpdesk (pre-triage)
- Lightweight contact or support bots
- ChatOps starter for SMEs

---

## 🪪 License

MIT – Free to use, share, and customize.

---

*Built by [Your Name], ready for Zapier x GAS integrations.*
```

---
