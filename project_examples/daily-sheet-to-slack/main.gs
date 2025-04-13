// === Configuration constants (edit in setProperties) ===
const CONFIG = {
  SHEET_ID: '<<< YOUR_SPREADSHEET_ID >>>',
  SHEET_NAME: 'DailyReport',
  ROW_LIMIT: '5',
  SLACK_WEBHOOK_URL: '<<< YOUR_SLACK_WEBHOOK_URL >>>',
};

// === Trigger setup constants ===
const TRIGGER_FUNCTION_NAME = 'sendDailyUpdate';
const TRIGGER_HOUR_JST = 9; // 9:00 AM JST

/**
 * Store script properties (set this manually once).
 */
function setProperties() {
  const props = PropertiesService.getScriptProperties();
  props.setProperties(CONFIG);
}

/**
 * Send the latest rows from the spreadsheet to Slack.
 */
function sendDailyUpdate() {
  const props = PropertiesService.getScriptProperties();
  const sheetId = props.getProperty('SHEET_ID');
  const sheetName = props.getProperty('SHEET_NAME');
  const rowLimit = Number(props.getProperty('ROW_LIMIT') || 5);
  const webhookUrl = props.getProperty('SLACK_WEBHOOK_URL');

  const sheet = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName);
  const data = sheet.getDataRange().getValues();
  const latestRows = data.slice(-rowLimit);

  let message = `📊 *Daily Report – Last ${rowLimit} Entries:*\n`;
  latestRows.forEach((row, i) => {
    const formattedDate = new Date(row[0]).toISOString().slice(0, 10); // YYYY-MM-DD
    message += `${i + 1}. [${formattedDate}] ${row[1]} | ${row[2]} | ${row[3] || ''}\n`;
  });

  const payload = JSON.stringify({ text: message });
  UrlFetchApp.fetch(webhookUrl, {
    method: 'post',
    contentType: 'application/json',
    payload: payload,
  });
}

/**
 * Create daily trigger at 9:00 AM JST.
 */
function createDailyTrigger() {
  ScriptApp.newTrigger(TRIGGER_FUNCTION_NAME)
    .timeBased()
    .everyDays(1)
    .atHour(TRIGGER_HOUR_JST)
    .create();
}

/**
 * Delete all existing triggers for sendDailyUpdate().
 */
function deleteDailyTriggers() {
  const triggers = ScriptApp.getProjectTriggers();
  triggers.forEach(trigger => {
    if (trigger.getHandlerFunction() === TRIGGER_FUNCTION_NAME) {
      ScriptApp.deleteTrigger(trigger);
    }
  });
}

/**
 * Reset the daily trigger (delete + recreate).
 */
function resetDailyTrigger() {
  deleteDailyTriggers();
  createDailyTrigger();
}
