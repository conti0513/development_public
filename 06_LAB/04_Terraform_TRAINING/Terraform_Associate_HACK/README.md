# Terraform Associate (003) 試験範囲：全体俯瞰チートシート

## 📌 試験概要

* **試験名:** HashiCorp Certified: Terraform Associate (003)
* **形式:** 選択式・複数選択・穴埋め
* **合格ライン:** 約70%以上
* **特徴:** コマンド操作だけでなく「なぜその機能を使うのか」「チーム開発でどう管理するか」という**運用の作法**が問われます。

---

## 🗺️ セクション別・学習ポイント

### 範囲 1: Infrastructure as Code (IaC) の概念

* **IaCの利点:** 再現性、自動化、バージョン管理。
* **命令型 vs 宣言型:** Terraformは「あるべき姿」を書く**宣言型**。
* **ドリフト（Drift）:** 実環境とコードの乖離。

### 範囲 2: Terraformの基本用語と仕組み

* **Provider:** GCP, AWS, AzureなどのAPIを叩くプラグイン。
* **Resource & Data Source:** 作るもの（Resource）と、情報を参照するもの（Data）。
* **Terraform Core vs Plugins:** 本体とProviderの関係。

### 範囲 3: Terraform CLI（主要コマンド）

* `init`: 初期化、Providerのダウンロード。
* `plan`: 実行計画の確認（dry-run）。
* `apply`: 構築の実行。
* `destroy`: リソースの全削除。
* `fmt`: コードの整形。
* `validate`: 構文チェック。

### 範囲 4: 変数と言語（HCL: HashiCorp Configuration Language）

* **Variables:** `variable`（入力）、`output`（出力）、`local`（一時変数）。
* **型:** string, number, bool, list, map, object。
* **演算:** 三項演算子、`for_each`、`count`、動的な設定。

### 範囲 5: 状態管理 (State Management)

* **tfstateファイル:** 現在のインフラの状態を記録した台帳。
* **Backend:** stateファイルを共有するための場所（GCS, S3, Terraform Cloud）。
* **State Locking:** 同時編集を防ぐロック機能。
* **Import:** 既存リソースを管理下に入れる（※最重要）。

### 範囲 6: モジュール (Modules)

* **Module:** コードの部品化と再利用。
* **Input/Output:** 親から子へ渡し、子から親へ戻す。
* **Registry:** 公開されたモジュールの利用。

### 範囲 7: Terraform Cloud & Enterprise (チーム運用)

* **Sentinel:** Policy as Code（「この設定は禁止」というルール化）。
* **Workspace:** 環境（本番/開発）ごとのStateの切り分け。
* **Remote Execution:** クラウド上でTerraformを実行する。

---
