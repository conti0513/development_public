# Terraform Sandbox — Minimal & Portable Setup

## 🎯 Concept

> **“Thunderbird Portable のように、消せば環境も跡形なく消える Terraform 学習環境。”**
>
> ローカル環境を汚さず、GitHubへのコミットも最小限。  
> **`sandbox/` フォルダ1つ**で完結する、最小構成の Terraform モック環境。

---

## 🧩 What You’ll Build

```

/workspaces/development_public/
└── devops_notes/
└── Terraform/
├── Terraform_concept.md              ← 概念整理ノート
├── terraform_gcp_minimal_design/     ← 設計図・構成計画（各プロジェクト）
│   ├── 01_hello_world/               ← 最小構成（今回）
│   ├── 02_sftp_transfer/             ← SFTP/GCS転送構成（予定）
│   ├── 03_cloudrun_api/              ← Cloud Run構成（予定）
│   ├── 04_iac_pipeline/              ← IaCパイプライン（予定）
│   ├── 05_security_monitoring/       ← セキュリティ監視（予定）
│   └── 10_final_portfolio/           ← 総合演習（予定）
├── scripts/                          ← sandbox操作スクリプト群
│   ├── sandbox-reset.sh
│   └── sandbox-clean.sh
├── .gitignore                        ← ※Terraform直下に配置（sandbox完全除外）
└── sandbox/                          ← 実験用作業フォルダ（非コミット）
├── .gitkeep
├── 01_init_validate/
├── 02_gcp_connect/
└── 03_cloudrun_hello/

```

> ※ 各 `xx_project/` フォルダは「将来の設計計画」。必要になった時点で空ディレクトリ＋READMEを追加します。

---

## 🧱 Overall Architecture (Concept)

```

[You @ GitHub Codespaces]
├─ Edit / Test inside sandbox/
├─ Run Terraform locally (init / plan / apply)
├─ Use scripts/ to reset sandbox
└─ Delete sandbox anytime to reset (portable)

```
    │ (optional)
    v
```

[GitHub Actions] --(OIDC token)--> [GCP Workload Identity Federation]
│
├─ [Service Account: tf-cicd]
├─ [GCS bucket: tfstate backend]
└─ [Cloud Run: hello-world]

```

---

## 💡 Sandbox Concept

```

Terraform/
├── terraform_gcp_minimal_design/   ← 設計・構成図をコミット
├── scripts/                        ← 環境リセット用の軽量シェル
└── sandbox/                        ← 実験・検証用フォルダ（非コミット）
├── .gitkeep
├── 01_init_validate/
├── 02_gcp_connect/
└── 03_cloudrun_hello/

````

* `sandbox/` の中では自由に実験OK  
* `.gitignore` で生成物（`.terraform/`, `tfstate` など）を**完全除外**  
* **スクリプト1発で初期化可能**  
* 消すだけで環境を**即リセット**

---

## ⚙️ .gitignore (Terraform直下)

```bash
# sandboxを丸ごと無視
sandbox/**
!sandbox/.gitkeep

# Terraform生成物をグローバル無視
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
　→ `/devops_notes/Terraform/` を開く。

2️⃣ **Terraformの動作確認（Layer 1）**
　→ `sandbox/01_init_validate/` にて `terraform init / validate`。

3️⃣ **GCP接続（Layer 2）**
　→ `gcloud auth login` or WIFでプロバイダ接続テスト。

4️⃣ **Cloud Runデプロイ（Layer 3）**
　→ “Hello World”レスポンスを確認。

5️⃣ **リセット**

```bash
bash scripts/sandbox-reset.sh   # 全消し→再生成
# または
bash scripts/sandbox-clean.sh   # 中身のみ一掃
```

---

## 🚀 Future Vision

このリポジトリ構成はそのまま **Zenn / Udemy 講座** に展開可能です。

| Chapter | 内容                | 対応フォルダ                   |
| ------- | ----------------- | ------------------------ |
| 1       | Terraformを動かしてみる  | `01_hello_world`         |
| 2       | SFTP転送をTerraform化 | `02_sftp_transfer`       |
| 3       | Cloud RunでAPI公開   | `03_cloudrun_api`        |
| 4       | IaCパイプライン構築       | `04_iac_pipeline`        |
| 5       | セキュリティ監視をIaC化     | `05_security_monitoring` |
| 10      | 総合演習・ポートフォリオ構築    | `10_final_portfolio`     |

> 成果物を残さず、sandboxで完結。
> “消せば終わる” = 再現性が高い教材環境。

---

## ✅ Key Points Summary

* **Sandbox-first:** 実験はすべて `sandbox/` に閉じる
* **Scripts-driven:** `scripts/` で環境初期化を自動化
* **Project-based:** `terraform_gcp_minimal_design/` に各テーマを追加
* **No heavy commits:** 構成図と設計のみをコミット
* **Portable:** `bash scripts/sandbox-reset.sh` で完全リセット
* **Layered Learning:** Layer1 → Layer3 で段階的に理解

---

### 💬 Final Goal

> ✅ Terraform works in Codespaces
> ✅ GCP connection succeeds (OIDC or ADC)
> ✅ Cloud Run returns “Hello World”

---

## 📚 Upcoming Curriculum Roadmap (for future expansion)

| Project                    | Theme           | Goal                           |
| -------------------------- | --------------- | ------------------------------ |
| **01_hello_world**         | 基本のTerraform操作  | GCPリソース構築の流れを理解                |
| **02_sftp_transfer**       | GCS ↔ SFTP連携    | ネットワーク構成とTerraform連携を学ぶ        |
| **03_cloudrun_api**        | Cloud Run API構築 | コンテナデプロイと公開の自動化                |
| **04_iac_pipeline**        | CI/CDパイプライン     | GitHub ActionsでIaCを自動適用        |
| **05_security_monitoring** | セキュリティ監視        | IAM・Secret・LoggingをTerraform管理 |
| **10_final_portfolio**     | 総合ポートフォリオ       | 全構成を統合し教材として公開                 |

> これらのプロジェクトは順次追加予定。
> すべて sandbox を基盤として構築・破棄を自動化できるようにする。

---

```

---

