# AI Agent Architecture（OpenGemini-Lite）: 2026 Revised

本リポジトリは、Slack を起点とした**イベント駆動型 AI エージェント基盤**の設計・実装プロジェクトです。
2026年2月の実稼働を経て、最新モデルへの**「動的追従（Alias Strategy）」**と、GitHub Actions への**「タスク委任（Dispatch）」**を両立した、持続可能な自動化パイプラインを構築しました。

---

## 1. システム構成（Latest Architecture）

現在、Phase 2.5 に到達。Gemini 2.0/3.0 世代の機能を活用し、Slack と GitHub Actions を結ぶ疎結合なワークフローが安定稼働しています。

### 構成のポイント

* **リージョン最適化**: `asia-northeast1`（東京）への集約による低レイテンシな実行。
* **モデル・エイリアス運用**: `gemini-flash-latest` を採用。Google 側のモデル更新（1.5 → 2.0 → 3.0）に伴うエンドポイント消失リスク（404エラー）を最小化し、メンテナンスフリーな推論環境を維持。
* **構造化レスポンスの強制**: JSON Mode を活用し、Slack の非構造な入力を GitHub 側が解釈可能なペイロードへ確実に変換。

---

## 2. 設計思想と Lessons Learned（学んだ教訓）

### ① 思考と実行の分離（Decoupling）

Cloud Run（Go）を「思考（脳）」、GitHub Actions を「実行（筋肉）」と定義。Go 側は Git 操作の複雑さを知らず、ただ Dispatch することに専念。

### ② Slack 3秒ルールの克服

* **課題**: Slack API の「3秒以内レスポンス」制約。AI の推論には時間がかかるため、単純な逐次処理では多重投稿やタイムアウトが発生する。
* **解決**: Go の **Goroutine（非同期処理）** を活用。リクエスト受信直後に `200 OK` を返し、推論と Dispatch はバックグラウンドで実行する「非同期ハンドリング」を徹底。

### ③ モデル名の抽象化（Model Abstraction）

* **課題**: `gemini-1.5-flash` 等の特定バージョン固定による突然の 404 エラー。
* **解決**: モデル名をエイリアス化（`latest`）し、インフラ側の更新に左右されない**「長寿命なコード」**を確立。これが AI 運用における安定性の鍵となる。

---

## 3. 現在の進捗（Development Status）

### ✅ Phase 1 & 2：統合と安定化（Completed）

* **Google AI SDK への移行**: `google.golang.org/api/genai` によるネイティブ実装。
* **デバッグ・プロトコルの確立**: API キーの有効性とモデルリストを事前に検証する手順のルーチン化。
* **疎通の完遂**: `repository_dispatch` による Pull Request 生成（#13 にて実証）。

### 🚀 Phase 3：拡張（Next Steps）

* **双方向フィードバック**: GitHub Actions の結果を Slack へ通知する逆流ラインの構築。
* **マルチエージェント化**: モデル特性に応じた動的なエンジン切り替えロジックの導入。

---

## 🛠️ 運用・メンテナンス

### 1. API キーの可視化

デプロイ前には、キーが認識しているモデルを以下のコマンドで確認し、権限の不整合を未然に防ぐ。

```bash
curl -s "https://generativelanguage.googleapis.com/v1beta/models?key=${GEMINI_API_KEY}" | grep "name"

```

### 2. ログによる導通確認

`gcloud beta logging tail` を通じて、`GitHub Dispatched: 204` を確認する。これがシステムが健全に連動している最小単位の証左となる。

---

## 4. 実装の記録（Go Logic Highlights）

実行環境の安定性を優先し、モデル指定はエイリアスを継続使用する。

```go
model := client.GenerativeModel("gemini-flash-latest")

```

---
