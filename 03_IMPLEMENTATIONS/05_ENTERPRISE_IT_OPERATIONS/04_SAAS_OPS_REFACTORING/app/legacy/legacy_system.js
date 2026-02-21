const { App } = require('@slack/bolt');
const { BigQuery } = require('@google-cloud/bigquery');
const http = require('http');
const bq = new BigQuery();

// Boltは定義だけ残す（負債の証拠として）
const app = new App({ token: "xoxb-dummy", signingSecret: "dummy" });

// Cloud Runが期待するポートで、確実にHTTPサーバーを立てる
const server = http.createServer(async (req, res) => {
  // 裏口：direct-debug
  if (req.url.includes('/direct-debug') && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', async () => {
      try {
        const ticketId = body.includes('text=') ? decodeURIComponent(body.split('text=')[1].split('&')[0]) : 'ASIS-BOMB';
        const q = `SELECT * FROM \`terraform-sandbox-lab.temp_ops_dataset.legacy_tickets\` WHERE id = '${ticketId}'`;
        const [rows] = await bq.query(q);
        res.writeHead(200, {'Content-Type': 'application/json'});
        res.end(JSON.stringify(rows[0] || { status: 'NO_DATA', query: q }));
      } catch (err) {
        res.writeHead(500, {'Content-Type': 'application/json'});
        res.end(JSON.stringify({ status: 'BQ_ERROR', error: err.message }));
      }
    });
  } else {
    // ヘルスチェック用レスポンス
    res.writeHead(200);
    res.end('System Alive (Raw Mode)');
  }
});

const port = process.env.PORT || 8080;
server.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
// deploy-timestamp: Sat Feb 21 08:57:23 JST 2026
// deploy-timestamp: Sat Feb 21 09:00:15 JST 2026
