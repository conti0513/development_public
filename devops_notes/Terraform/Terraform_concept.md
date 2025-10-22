
**TA-003の合格＋GCP無料枠でのTerraformハンズオン（Hello World環境）＋MOCテンプレ化**


## 🧭 全体設計（4週間集中プラン）

| 週 | フェーズ          | 内容                                                      | 成果物                                   |
| - | ------------- | ------------------------------------------------------- | ------------------------------------- |
| 1 | **概念理解フェーズ**  | Terraformの仕組みを再確認（宣言的、状態管理、provider構造、変数、モジュール）         | `Terraform_concept.md`（あなたの既存ノートを補強）  |
| 2 | **ハンズオンフェーズ** | GCP無料枠で`Hello World` Webサーバー構築 → `terraform destroy`で破棄 | `/hands-on/hello-world-gcp/` ディレクトリ   |
| 3 | **問題演習フェーズ**  | UdemyやExamTopicsの模擬問題を集中演習。間違えた問題をコード化して確認。             | `TIL-terraform-quiz.md`（問題と再現コードのセット） |
| 4 | **受験直前フェーズ**  | 公式模試＋弱点補強 → 認定試験受験（TA-003）                              | 合格＋「Terraform MOC v1.0」リリース           |

---

## ☁️ ハンズオン設計（GCP無料枠）

### 目的

Terraformの流れ（init → plan → apply → destroy）を「1インスタンス構築」で理解する。

### 環境

* **GCPプロバイダ**
* **Cloud Storage**（state保存）
* **Compute Engine**（VM1台）
* **Firewall + HTTP(80)許可**

### 構成例

```
/terraform-gcp-hello/
  ├ main.tf
  ├ variables.tf
  ├ outputs.tf
  └ README.md
```

### main.tf (概要)

```hcl
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "hello" {
  name         = "hello-world"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "<h1>Hello, Terraform!</h1>" > /var/www/html/index.html
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
  EOT
}
```

### コマンド手順

```bash
terraform init
terraform plan
terraform apply
# → Hello, Terraform! がブラウザに表示される
terraform destroy
```

これで
✅ IaCの基本フロー
✅ GCP Provider の扱い
✅ ステートとリソースの対応
が完全に体で理解できます。

---

## 📘 試験対策（TA-003）

### 方針

* **概念 → 模擬問題 → 試験** の3ステップ。
* 学者型ではなく「使えるTerraform設計者」としての思考を鍛える。

### 推奨教材（英語・日本語混在）

| 種類       | 内容                                                            |
| -------- | ------------------------------------------------------------- |
| 🧠 概念復習  | HashiCorp公式「Study Guide 003」＋あなたの `Terraform_concept.md` を補強。 |
| 🧩 模擬試験  | Udemy: *“Terraform Associate 003 Practice Tests”*（満点目標80％以上）  |
| 🎯 実戦解説  | YouTube “Exam Prep Terraform 003” 系（英語聴き取り練習も兼ねる）             |
| 🗂 自作ノート | 問題と同じ構成を Terraform で再現 → `/mock_question_reproduce/` に保存。     |

---

## 🧩 次ステップ（MOC展開）

1. 今回のハンズオン（Hello World）を **テンプレート化**。
   → `MOC-01_HelloWorldGCP`
2. 同じ流れで

   * MOC-02: AWS版
   * MOC-03: VPC＋LB
   * MOC-04: Cloud Run＋NAT構成
     を量産。
3. それらを**教材ポートフォリオ**としてGitHubに公開し、
   外貨案件のサンプルリポジトリとして活用。

---

## ⏰ 学習スケジュール（目安）

| フェーズ   | 学習時間              | 内容                  |
| ------ | ----------------- | ------------------- |
| 概念理解   | 6h                | 試験範囲＋Terraform構文再整理 |
| ハンズオン  | 8h                | GCP構築＋破棄＋修正の反復      |
| 模擬試験   | 10h               | 2周（間違えた問題をコードで再現）   |
| 試験直前   | 6h                | 再演習＋用語確認            |
| **合計** | **30h前後（約3〜4週間）** | 短期集中型に最適            |

---
