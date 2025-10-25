
**`/workspaces/development_public/devops_notes/Terraform/terraform_workflow_steps.md`**

---

# Terraform Workflow Steps — Outline

## 🎯 Purpose

This document describes the **practical workflow steps** for using the Terraform sandbox environment.
It’s a lightweight checklist-style guide — no code, only actions.

---

## 🪜 Step Outline (Simplified Flow)

1. **Open Codespaces**

   * Repository: `devops_notes/Terraform`
   * Launch Codespaces environment.

2. **Verify Environment**

   * Check that the `sandbox/` folder exists.
   * Ensure `.gitignore` excludes it completely.

3. **Install Terraform (Temporary / Portable)**

   * Use the minimal method (one-time per Codespaces session).
   * Confirm with `terraform -v`.

4. **Create Workspace**

   * Inside `sandbox/`, make a subfolder: `01_init_validate/`.
   * This is your first test layer.

5. **Run Terraform Initialization (Layer 1)**

   * Create a minimal configuration file (`main.tf`).
   * Run `terraform init` / `terraform validate`.
   * Success message = Terraform working correctly.

6. **Authenticate to GCP (Layer 2)**

   * Add `gcloud` if needed.
   * Test `gcloud auth login --update-adc`.
   * Check GCP project access (`gcloud projects list`).

7. **Terraform ↔ GCP Connection**

   * Add provider settings.
   * Confirm `terraform plan` works against your GCP project.

8. **Deploy Hello World (Layer 3)**

   * Deploy to Cloud Run (public image).
   * Verify URL returns “Hello World”.

9. **Clean Up**

   * Run `git clean -xfd devops_notes/Terraform/sandbox/`.
   * Optionally `rm -rf sandbox/*` for full reset.

10. **Update Documentation**

* Record notes or results in `terraform_gcp_minimal_design/`.

---

## 🧩 Folder Reference

```
Terraform/
 ├── terraform_gcp_minimal_design/   ← design notes
 ├── terraform_workflow_steps.md     ← this file (workflow)
 └── sandbox/                        ← all hands-on work
      ├── 01_init_validate/
      ├── 02_gcp_connect/
      └── 03_cloudrun_hello/
```

---


# Layer 1 Terraform install

Terraformルートに移動（安全）
cd /workspaces/development_public/devops_notes/Terraform

# 1. Terraformインストール
sudo apt-get update -y
sudo apt-get install -y wget unzip
wget -q https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_amd64.zip
unzip terraform_1.9.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -v

# 2. sandboxリセット
bash scripts/sandbox-reset.sh

# 3. 検証フェーズ
cd sandbox/01_init_validate
echo 'terraform { required_version = ">= 1.7.0" }' > main.tf
terraform init
terraform validate


最高です！🎉
**Layer 1（Terraform単体の動作確認）クリア** しました。ここまで完璧。

このまま **Layer 2（GCPとの接続テスト）** に進みましょう。最短・軽量でいきます。

---

## Layer 2
次にやること（Layer 2：GCP接続の最短ルート）

### 0) 片付け（任意）

```bash
# ダウンロード物を掃除（任意）
rm -f ~/terraform_1.9.6_linux_amd64.zip LICENSE.txt
```

### 1) gcloud の導入（軽量・一度だけ）

```bash
# Google Cloud CLI 公式APTを追加してインストール
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |\
  sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg |\
  sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
sudo apt-get update -y
sudo apt-get install -y google-cloud-cli
gcloud --version
```

### 2) ログイン（ADCでOK）

```bash
gcloud auth login --update-adc
```

ブラウザで認証 → 成功表示でOK。

### 3) プロジェクト設定

```bash
export PROJECT_ID="<あなたのGCPプロジェクトID>"
gcloud config set project "$PROJECT_ID"
gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)"
```

### 4) Terraform から「つながるか」だけ確認

作業場所：`sandbox/02_gcp_connect/`

```bash
cd /workspaces/development_public/devops_notes/Terraform/sandbox/02_gcp_connect
# 最小ファイル（providerのみ。リソース作らない）
cat > providers.tf <<'EOF'
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = "asia-northeast1"
}
variable "project_id" {}
EOF

terraform init
terraform validate
# planでプロバイダと認証の疎通を見る（変更は出ない想定）
terraform plan -var="project_id=$PROJECT_ID"
```

**成功サイン**：`No changes. Infrastructure is up-to-date.` のような表示 ＋ エラー無し
（= Terraform ↔ GCP が会話できています）

---

## この先（Layer 3 への予告だけ）

* `sandbox/03_cloudrun_hello/` で **Cloud Run “Hello World”** をデプロイ
  （公開イメージを使うので最小手数）

---

## ミニチェックリスト

* [x] `terraform -v` 表示
* [x] `terraform init/validate` 成功（Layer 1）
* [ ] `gcloud auth login --update-adc` 済
* [ ] `terraform plan -var project_id=...` がエラー無し（Layer 2）

ここまで通ったら、すぐ **Hello World** まで行けます。
進めてみて、出力やエラーが出たらそのまま貼ってください。サクッと対処します！
