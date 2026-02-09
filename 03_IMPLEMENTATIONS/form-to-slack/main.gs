const WEBHOOK_KEY = "Your-Slack-Webhook-URL";

function onFormSubmit(e) {
  const responses = e.values;
  const name = responses[1];
  const email = responses[2];
  const message = responses[3];
  const timestamp = responses[0];

  const webhookUrl = PropertiesService.getScriptProperties().getProperty(WEBHOOK_KEY);

  const payload = {
    text: `📩 *New Form Submission Received!*\n\n📝 *Name*: ${name}\n📧 *Email*: ${email}\n🗒️ *Message*: ${message}\n\n📅 *Submitted At*: ${timestamp}`
  };

  const options = {
    method: 'post',
    contentType: 'application/json',
    payload: JSON.stringify(payload)
  };

  UrlFetchApp.fetch(webhookUrl, options);
}
