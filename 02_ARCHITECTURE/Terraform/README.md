# Terraform Sandbox — Minimal & Portable Setup

## 🎯 Concept

> **“Thunderbird Portable のように、消せば環境も跡形なく消える Terraform 学習環境。”**

ローカル環境を汚さず、GitHubへのコミットも最小限。  
**`sandbox/` と `design_docs/` の2階層構成**で、  
実験コードと設計図を完全に分離した、ポータブルなTerraform学習テンプレートです。

---

## 🧩 Folder Structure

```

/workspaces/development_public/
└── devops_notes/
        └── Terraform/
            ├── LICENSE.txt
            ├── README.md
            ├── design_docs/                   # 設計図・設計思想を保存
            │   ├── 00_foundation_design.md    # Layer0 構造設計（本リポ構成の思想）
            │   ├── 01_init_validate_design.md # Layer1 init/validate 設計図
            │   ├── 02_gcp_connect_design.md   # Layer2 GCP接続設計図
            │   └── 03_cloudrun_hello_design.md# Layer3 Cloud Run設計図
            ├── scripts/                       # 自動化スクリプト
            │   ├── sandbox-reset.sh           # sandbox全消去→再生成
            │   └── sandbox-clean.sh           # sandbox内の中身を掃除
            └── sandbox/                       # 実験用コード領域（非コミット）
                ├── 01_init_validate/
                │   └── main.tf
                ├── 02_gcp_connect/
                └── 03_cloudrun_hello/

```

---

## 🧱 Architecture Overview

```

[You @ GitHub Codespaces]
├─ Edit / Test inside sandbox/
├─ Run Terraform locally (init / plan / apply)
├─ Use scripts/ to reset sandbox
└─ Document design inside design_docs/

```

(Optional future extension)
```

[GitHub Actions] --(OIDC token)--> [GCP Workload Identity Federation]
├─ [Service Account: tf-cicd]
├─ [GCS bucket: tfstate backend]
└─ [Cloud Run: hello-world]

````

---

## 💡 Concept Summary

| 項目 | 目的 |
|------|------|
| **sandbox/** | 実際のTerraformコード・実験場。削除可。 |
| **design_docs/** | 設計思想・設計メモを保存。教材化・再利用可。 |
| **scripts/** | 環境リセットや初期化を自動化。 |
| **README.md** | 全体のナビゲーション兼教材トップページ。 |

> コードとドキュメントを完全分離し、  
> 「壊せる学習環境 × 再現できる設計図」を両立。

---

## ⚙️ .gitignore（Terraform直下）

```bash
# sandboxを完全除外
sandbox/**
!sandbox/.gitkeep

# Terraform生成物を無視
**/.terraform/
**/*.tfstate
**/*.tfstate.*
**/crash.log
**/*.tfvars
**/*.tfvars.json
.terraform.lock.hcl
````

---

## 🪜 Workflow Overview

1️⃣ **Codespacesを起動**
　→ `/devops_notes/Terraform/` を開く

2️⃣ **Layer1: Terraform動作確認**
　→ `sandbox/01_init_validate/` にて
　　`terraform init && terraform validate`

3️⃣ **Layer2: GCP接続**
　→ `gcloud auth login --update-adc`
　　`terraform plan -var="project_id=..."`

4️⃣ **Layer3: Cloud Runデプロイ**
　→ 公開イメージで “Hello World” を表示

5️⃣ **Reset / Clean**

```bash
bash scripts/sandbox-reset.sh   # sandbox再生成
bash scripts/sandbox-clean.sh   # sandbox内掃除
```

---

## 🚀 Future Vision

この構成はそのまま **Zenn / Udemy教材・Upworkモック案件** に展開可能です。

| Chapter | 内容                      | 対応フォルダ                        |
| ------- | ----------------------- | ----------------------------- |
| 0       | 構造設計 (Foundation)       | `00_foundation_design.md`     |
| 1       | Terraform init/validate | `01_init_validate_design.md`  |
| 2       | GCP接続                   | `02_gcp_connect_design.md`    |
| 3       | Cloud Runデプロイ           | `03_cloudrun_hello_design.md` |

> すべての成果物は sandbox で完結。
> “消せば終わる” = 再現性と軽量性を両立。

---

## ✅ Key Principles

* **Sandbox-first:** 実験は常に `sandbox/` 内で完結
* **Design-docs driven:** 思考・設計は `design_docs/` に記録
* **Scripts automation:** `scripts/` で初期化自動化
* **No heavy commits:** stateや生成物を残さない
* **Portable:** すべて削除・再生成できる設計

---

## ☁️ Minimal Example (GCP Hello World)

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
    initialize_params { image = "debian-cloud/debian-11" }
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

---

## 🧠 Reflection

* Terraformは「コードでインフラを理解する」学習ツール
* GCP無料枠は「壊して学ぶ」ための安全な実験環境
* **Sandbox × Design-docs 構成**で
  学習 → 試験 → 実務 → 教材化 までシームレスに展開可能

---

## 🪶 Final Goal

> ✅ Terraform works in Codespaces
> ✅ GCP Provider connection verified
> ✅ Cloud Run returns “Hello, Terraform!”
> ✅ `design_docs/` が教材兼ポートフォリオとして完成

---

**Licensed under the MIT License — see LICENSE.txt for details.**

```

---


