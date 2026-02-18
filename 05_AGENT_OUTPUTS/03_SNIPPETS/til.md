# Cloud Run 稼働監視スクリプト: monitor-agent.sh

## 1. 概要
本スクリプトは、Google Cloud Run 上で稼働する AI エージェント（opengemini-lite）の運用保守を効率化するために作成されました。`gcloud logging` を活用し、サービスの健全性、Gemini API の推論状況、GitHub PR 作成、Slack 受信イベントをワンコマンドで可視化します。

## 2. スクリプト実装

```bash
#!/bin/bash
# monitor-agent.sh

PROJECT_ID="terraform-sandbox-lab"
SERVICE_NAME="opengemini-lite"
REGION="asia-northeast1"

echo "=================================================="
echo "🔍 [1/4] Cloud Run サービス稼働状態 (Health)"
gcloud run services describe $SERVICE_NAME --region $REGION --format="value(status.conditions)"

echo -e "\n🤖 [2/4] Gemini API 思考ログ (エラー・クォータ)"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND (textPayload:\"Error\" OR textPayload:\":x:\" OR textPayload:\"Gemini\")" \
  --limit 10 --format="table(timestamp,textPayload)"

echo -e "\n🐙 [3/4] GitHub 連携・PR作成状況"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND (textPayload:\"GitHub\" OR textPayload:\"PR\" OR textPayload:\"RefError\")" \
  --limit 10 --format="table(timestamp,textPayload)"

echo -e "\n📡 [4/4] Slack 受信イベント (通信疎通)"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:\"Slack\"" \
  --limit 5 --format="table(timestamp,textPayload)"

echo -e "\n💡 [リアルタイム監視したい場合]"
echo "gcloud logging tail --project $PROJECT_ID"
echo "=================================================="
```

## 3. 実行結果の分析（ログトレース）

現在の実行ログから、以下のシステム状態が確認されています。

### A. サービスの健全性
- **ステータス**: `Ready: True` / `ConfigurationsReady: True` / `RoutesReady: True` 
- **判断**: インフラ構成およびデプロイメントは正常に完了しており、トラフィックを受け入れ可能な状態です。

### B. 検出された主なエラー
1. **API Key 認証エラー (`API_KEY_INVALID`)**
   - `2026-02-17T22:54:10Z`: `API key not valid` が発生。Secret Manager または環境変数の設定不備の可能性があります。
2. **タイムアウトエラー (`context deadline exceeded`)**
   - `2026-02-18T21:47:59Z`: Gemini API 呼び出し時に発生。モデルの応答遅延、または Cloud Run のリクエストタイムアウト設定の検討が必要です。

### C. 外部連携状況
- **Slack**: `Slack event received` が記録されており、ペイロードの受信に成功しています。
- **GitHub**: 「PRを出してください」という依頼に基づき、Gemini が Markdown をパースしている形跡が確認できます。

## 4. 推奨アクション

1. **Secret の確認**: `API_KEY_INVALID` が再発する場合、Terraform 側の Secret 定義と実値の整合性を確認してください。
2. **タイムアウト値の調整**: 重い推論処理を行う場合、Cloud Run の `timeout` 設定を 300s 程度まで引き上げることを検討してください。
3. **監視の継続**: 異常検知を自動化する場合、本スクリプトの条件をベースに Cloud Monitoring の Log-based Metrics を作成し、アラート設定を行うのがベストプラクティスです。