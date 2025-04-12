## ✅ `README.md` (for `form-to-slack` project)

```markdown
# 📩 Google Form to Slack Notifier (GAS)

This script automatically sends Slack notifications whenever a Google Form is submitted.  
It’s built with Google Apps Script and requires no external services beyond Slack and Google Workspace.

---

## ✅ Features

- 📬 Instantly notifies a Slack channel when a form is submitted
- 🔒 Uses Slack Incoming Webhooks (no bot setup required)
- 🧰 Easy setup for non-engineers
- ✍️ Clear, readable Slack message format

---

## ⚙️ Setup Instructions

### 1. Prepare the Google Form

Create a Google Form with any number of fields.  
Make sure the first response column is the **timestamp** (default).

> Example fields:
> - Your Name
> - Email Address
> - Message

---

### 2. Paste the Script into Apps Script Editor

1. Go to **Extensions → Apps Script** from your Form or linked Sheet
2. Replace the default `Code.gs` with this script:

```javascript
function onFormSubmit(e) {
  const responses = e.values;
  const name = responses[1];
  const email = responses[2];
  const message = responses[3];
  const timestamp = responses[0];

  const payload = {
    text: `📩 *New Form Submission Received!*\n\n📝 *Name*: ${name}\n📧 *Email*: ${email}\n🗒️ *Message*: ${message}\n\n📅 *Submitted At*: ${timestamp}`
  };

  const webhookUrl = PropertiesService.getScriptProperties().getProperty("SLACK_WEBHOOK_URL");

  const options = {
    method: 'post',
    contentType: 'application/json',
    payload: JSON.stringify(payload)
  };

  UrlFetchApp.fetch(webhookUrl, options);
}
```

---

### 3. Set the Slack Webhook URL

1. Create a [Slack Incoming Webhook](https://api.slack.com/messaging/webhooks)
2. In the Script Editor:  
   - Click **File → Project Properties → Script Properties**
   - Add:
     - **Key**: `SLACK_WEBHOOK_URL`
     - **Value**: *(your Slack webhook URL)*

---

### 4. Add a Trigger

1. In Apps Script Editor, click the ⏰ **Trigger icon**
2. Add a new trigger:
   - Function: `onFormSubmit`
   - Event source: `From form`
   - Event type: `On form submit`

---

## 💬 Slack Notification Example

```
📩 New Form Submission Received!

📝 Name: John Doe  
📧 Email: john@example.com  
🗒️ Message: Hello, this is a test!

📅 Submitted At: 2025/04/13 15:45
```

---

## 📦 Folder Contents

| File | Description |
|------|-------------|
| `code.gs` | Main Apps Script file |
| `README.md` | This guide |
| `assets/` | Screenshots for setup (optional) |

---

## 🧪 Use Cases

- Contact forms
- Internal IT support requests
- Event registrations
- Quick team feedback collection

---

## 📄 License

MIT License.  
Use it, modify it, and build your own workflows.

---

Feel free to fork and adapt this project for your team or clients 🚀  
Need a customized version? Contact me via [Upwork/GitHub]!
```

---
