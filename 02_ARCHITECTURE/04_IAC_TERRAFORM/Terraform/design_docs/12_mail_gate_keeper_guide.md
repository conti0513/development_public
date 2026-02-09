# 🛡️ Mail Gate Keeper 運用・デプロイガイド

## 1. 概要
本ツールは、メール送信ドメイン認証（SPF/DMARC）の健全性を「受信サーバー側の審判視点」で診断する、Go 言語製の軽量バリデーターです。
特に、人間が手動で追うことが困難な **SPF 10-Lookup 制限（RFC 7208）** の再帰的な検証を自動化し、不達リスクを可視化します。

## 2. クイックスタート（利用者向け）
移行期間中、検証用として以下の URL を開放しています。
- **URL:** `https://mail-gate-keeper-841765922679.asia-northeast1.run.app/`（実際の URL に置換）
- **使い方:** 診断したいドメイン（例: `example.com`）を入力して実行。
- **判定基準:** - 🟢 **Pass**: 10回未満。本番投入可能な状態です。
    - 🟡 **Warn**: 8〜9回。今後のサービス追加時に注意が必要です。
    - 🔴 **Critical**: 11回以上（RFC違反）。受信側で恒久的なエラー（PermError）となります。

## 3. セルフホスト手順（管理者・A様向け）
私が環境をクローズした後、貴社環境で継続利用される場合は、以下の手順で Cloud Run へ再構築可能です。

### ステップ 1: コンテナイメージのビルド
```bash
# プロジェクトIDは適宜置換
gcloud builds submit --tag gcr.io/[PROJECT_ID]/mail-gate-keeper .

```

### ステップ 2: Terraform によるインフラ構築

`/mail-gate-keeper/terraform` ディレクトリにて実行します。

```bash
cd terraform
terraform init
terraform apply

```

## 4. 技術的仕様

* **SPF 再帰スキャナー:** `net.LookupTXT` を使用し、`include` 先のレコードを再帰的に解析します。
* **DMARC チェック:** `_dmarc` サブドメインを自動参照し、現在のポリシーを表示します。
* **UI:** Tailwind CSS を採用し、Go の `html/template` を用いて単一バイナリで Web インターフェースを提供します。
* **コスト:** Google Cloud Run の無料枠内でほぼ完結するため、常時デプロイしても維持費はほぼ発生しません。
