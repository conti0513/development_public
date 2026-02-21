const { App } = require('@slack/bolt');
const { BigQuery } = require('@google-cloud/bigquery');

const bq = new BigQuery();

// Bolt Appを直接インスタンス化（これが一番確実です）
const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET,
  // Cloud Runのポートを直接受け取る
  port: process.env.PORT || 8080,
  // URL検証（Challenge）に自動で対応する設定
  customRoutes: [
    {
      path: '/slack/events',
      method: ['GET'],
      handler: (req, res) => {
        res.writeHead(200);
        res.end('Ops-Query-Assistant is Online');
      },
    }
  ]
});

// スラッシュコマンドの実装
app.command('/task-check-lab', async ({ command, ack, say }) => {
  await ack();
  try {
    const ticketId = command.text.trim() || 'ASIS-BOMB';
    const q = `SELECT * FROM \`terraform-sandbox-lab.temp_ops_dataset.legacy_tickets\` WHERE id = '${ticketId}'`;
    const [rows] = await bq.query(q);
    
    if (rows.length > 0) {
      await say(`✅ 【Ops-Assistant】チケット照会結果:\n\`\`\`${JSON.stringify(rows[0], null, 2)}\`\`\``);
    } else {
      await say(`❌ チケットID '${ticketId}' は見つかりませんでした。`);
    }
  } catch (e) {
    await say(`⚠️ BigQueryエラー: ${e.message}`);
  }
});

(async () => {
  await app.start();
  console.log(`⚡️ Bolt app is running on port ${process.env.PORT || 8080}`);
})();