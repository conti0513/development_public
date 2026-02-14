# AI Agent Architecture（OpenGemini-Lite）: 2026 Revised

本リポジトリは、Slack を起点とした**イベント駆動型 AI エージェント基盤**の設計・実装プロジェクトです。
2026年2月の実戦投入を経て、**「最新AIモデルの動的追従（Alias）」**と**「GitHub Actions への完全委任」**を両立した、メンテフリーな自動化パイプラインを確立しました。

---

## 1. システム構成（Latest Architecture）

現在、Phase 2.5 に到達。Gemini 2.0/3.0 世代の能力をフルに活用し、GitHub Actions へのタスク委任が安定稼働しています。

### 構成のポイント

* **東京リージョン（asia-northeast1）集約**: 低レイテンシな実行環境。
* **エイリアス駆動型 AI 推論**: モデル名を `gemini-flash-latest` に固定。Google側のモデル更新（1.5 → 2.0 → 3.0）に伴う「404: Not Found」を回避し、常に最高効率のエンジンを自動採用。
* **知能の構造化**: JSON Mode を強制し、曖昧な Slack 入力を確実に GitHub 側の YAML が解釈可能なペイロードへ変換。
* **セキュアな環境変数管理**: `GEMINI_API_KEY` と `GITHUB_PAT` を Cloud Run 上で隔離。APIキーの有効性は `curl` によるモデルリスト取得で事前検証を行う運用を確立。

---

## 2. 設計思想（The Philosophy）

### ① 思考と実行の分離（Decoupling of Thinking & Acting）

Cloud Run（Go）を「思考（脳）」、GitHub Actions を「実行（筋肉）」と明確に分離。Go側は GitHub の内部実装（Git操作）を知らず、ただ `repository_dispatch` を送ることに専念。

### ② モデル・アブストラクション（Model Abstraction）

AIモデルを「固定名」ではなく「エイリアス」で呼ぶことで、インフラ側の更新に左右されない**「長寿命なコード」**を実現。これが 2026 年における AI 運用のベストプラクティスである。

### ③ 堅牢なデータパイプライン

Slack の 3 秒制限を回避するため、Go 側の処理を非同期化。Payload 欠損に備えた YAML 側でのガードレール（デフォルト値）により、パイプラインの完走率を最大化。

---

## 3. 現在の進捗（Development Status）

### ✅ Phase 1 & 2：基盤と知能の統合（完了）

* **Google AI SDK 統合**: `google.golang.org/api/genai` への完全移行。
* **疎通確認のテンプレ化**: 404 エラーを即座に特定する「検品ワンライナー」の確立。
* **GitHub 連携**: Dispatch による PR 自動生成（#13 にて実証）。

### 🚀 Phase 3：フィードバック & 拡張（Next Steps）

* **双方向通信**: GitHub Actions の完了結果を Slack へ逆流させる通知機能の追加。
* **マルチエージェント化**: `latest` エイリアスを活用し、異なるモデル（Pro/Flash）をタスクに応じて動的に使い分ける。

---

## 🛠️ OpenGemini-Lite 運用・トラブルシューティング

### 1. API キーの「生存確認」

不定期に発生するモデル未検出（404）を防ぐため、デプロイ前には必ず以下のコマンドでキーの権限を可視化する。

```bash
curl -s "https://generativelanguage.googleapis.com/v1beta/models?key=${GEMINI_API_KEY}" | grep "name"

```

### 2. デプロイ & 検品プロセス

モデル名をハードコードせず、Go 側で `gemini-flash-latest` を指定。

```bash
go build -o server main.go && \
gcloud run deploy opengemini-lite \
  --source . \
  --region asia-northeast1 \
  --set-env-vars "GEMINI_API_KEY=${GEMINI_API_KEY},GITHUB_PAT=${GITHUB_PAT}"

```

### 3. ログによる勝利の確認

`gcloud beta logging tail` を使用し、`GitHub Dispatched: 204` の着弾を確認すること。これが「脳」から「筋肉」へ指令が渡った証左となる。

---

## 6. 実装の記録（Go Logic Highlights）

現在、モデル指定を以下に固定し、運用の安定化を図っている。

```go
model := client.GenerativeModel("gemini-flash-latest")
