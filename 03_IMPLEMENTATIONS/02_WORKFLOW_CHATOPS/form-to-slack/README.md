# 📩 Google Form to Slack Notifier (Google Apps Script)

A lightweight automation that instantly sends Slack notifications when a Google Form is submitted.  
Built entirely with Google Apps Script — no server, no third-party tools required.

---

## ✅ Key Features

- 📬 Real-time Slack alerts for every new form submission
- 🔒 Uses Slack Incoming Webhooks (no Slack app or token needed)
- 🧰 Simple setup, even for non-developers
- ✍️ Clean, readable Slack message format

---

## ⚙️ Quick Setup Guide

### 1. Prepare Your Google Form

- Create a Google Form (any structure is okay)
- Ensure the first column in responses is the **timestamp** (default)

**Example fields**:
- Name
- Email
- Message

---

### 2. Add the Script to Apps Script

1. Open your Form's linked Google Sheet  
2. Go to **Extensions → Apps Script**
3. Replace the default code with:

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

  UrlFetchApp.fetch(webhookUrl, {
    method: 'post',
    contentType: 'application/json',
    payload: JSON.stringify(payload)
  });
}
```

---

### 3. Set Your Slack Webhook URL

1. Create a [Slack Incoming Webhook](https://api.slack.com/messaging/webhooks)  
2. In Apps Script Editor:  
   - Go to `File → Project Properties → Script Properties`
   - Add the following:

| Key                  | Value                     |
|----------------------|---------------------------|
| `SLACK_WEBHOOK_URL`  | your Slack webhook URL    |

---

### 4. Add the Form Trigger

1. In Apps Script, click the ⏰ Trigger icon  
2. Add a new trigger:
   - Function: `onFormSubmit`
   - Source: `From form`
   - Event type: `On form submit`

---

## 💬 Slack Message Example

```
📩 New Form Submission Received!

📝 Name: John Doe  
📧 Email: john@example.com  
🗒️ Message: Hello, this is a test!

📅 Submitted At: 2025/04/13 15:45
```

---

## 📁 Folder Structure

| File        | Description                  |
|-------------|------------------------------|
| `code.gs`   | Main Apps Script file        |
| `README.md` | Setup and usage instructions |
| `assets/`   | Optional screenshots folder  |

---

## 🧪 Use Cases

- Contact or inquiry forms
- Internal IT/helpdesk ticketing
- Event registrations
- Quick team feedback collection
- Customer onboarding flows

---

## 💡 Why This Is Useful

- 🚫 No need for Slack bots or 3rd-party apps
- 💨 Set up in minutes — works out-of-the-box
- ✅ Easy to maintain and customize
- 🔒 Built natively on Google's secure infrastructure

---

## 👋 Work With Me

If you need:
- A custom version of this tool
- Slack integrations for your internal systems
- Automation support in Google Workspace

Let’s connect on [Upwork](https://www.upwork.com/) or [GitHub](https://github.com/conti0513) 💼

---

## 📄 License

MIT License  
Free to use, modify, and share with attribution.
```

---
