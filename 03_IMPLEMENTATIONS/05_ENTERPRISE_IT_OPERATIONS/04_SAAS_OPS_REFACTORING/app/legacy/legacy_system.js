const { App } = require('@slack/bolt');
const { BigQuery } = require('@google-cloud/bigquery');
const bq = new BigQuery();
const app = new App({ token: "xoxb-dummy", signingSecret: "dummy" });
app.command('/task-check', async ({ command, ack, say }) => {
  await ack();
  try {
    const q = "SELECT * FROM `YOUR_PROJECT_ID.temp_ops_dataset.legacy_tickets` WHERE id = '" + command.text + "'";
    const [rows] = await bq.query(q);
    await say(rows.length > 0 ? "発見: " + JSON.stringify(rows[0]) : "なし");
  } catch (e) { console.log("error!", e); }
});
(async () => { await app.start(process.env.PORT || 3000); })();
