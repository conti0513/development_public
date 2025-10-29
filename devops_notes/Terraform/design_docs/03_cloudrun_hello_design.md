# 🌥️ Terraform Layer 3 — Cloud Run Hello Design

## 🧭 Feedback from Layer 2 (GCP Connect)
**Summary of Achievements**
- Migrated Terraform state → **GCS Backend** (`backend "gcs"`)
- Linked **Billing Account** to `terraform-sandbox-lab` → Verified `billingEnabled: true`
- Created and verified both **tfstate bucket** and **validation bucket**
- Confirmed `terraform output -raw lab_bucket_name` returns valid bucket name
- `.gitignore` excludes state and credential files → no secret exposure

> ✅ Terraform is now cloud-ready.  
> Future infrastructure (Cloud Run, VPC, etc.) can safely share the same remote state.

---

## 🎯 Objective of Layer 3
Deploy a **minimal “Hello World” container** to **Cloud Run** via Terraform  
to validate API activation, container deployment, and end-to-end connectivity.

---

## 🪜 Step 0 — Directory Setup
```bash
cd /workspaces/development_public/devops_notes/Terraform/sandbox
cp -a 02_gcp_connect/. 03_cloudrun_hello/
cd 03_cloudrun_hello
rm -rf .terraform terraform.tfstate .terraform.lock.hcl
````

> Create a clean copy from L2 to initialize Layer 3 environment.

---

## 🪜 Step 1 — Re-authenticate (use script)

```bash
setup_auth_min.sh
```

> This script refreshes both gcloud & ADC authentication,
> sets quota project, and validates access tokens.

---

## 🪜 Step 2 — Enable Required APIs

```bash
gcloud services enable run.googleapis.com artifactregistry.googleapis.com \
  --project=terraform-sandbox-lab
```

> Enables Cloud Run and Artifact Registry APIs required for container deployment.

---

## 🪜 Step 3 — Terraform Configuration Overview

| File               | Description                                      |
| ------------------ | ------------------------------------------------ |
| `backend.tf`       | GCS backend configuration (reuse from L2)        |
| `providers.tf`     | Google provider setup                            |
| `main.tf`          | Artifact Registry + Cloud Run service definition |
| `terraform.tfvars` | Project, region, and other variables             |
| `versions.tf`      | Provider versions (google ≥ 5.0.0)               |

---

## 🪜 Step 4 — Define Cloud Run Resources (Outline)

```hcl
resource "google_project_service" "run" {
  project = var.project
  service = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifact_registry" {
  project = var.project
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "hello-repo"
  format        = "DOCKER"
}

resource "google_cloud_run_service" "hello" {
  name     = "hello-world"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
  depends_on = [
    google_project_service.run,
    google_project_service.artifact_registry
  ]
}

output "cloud_run_url" {
  value = google_cloud_run_service.hello.status[0].url
}
```

---

## 🧪 Step 5 — Apply and Verify

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

Validate output:

```bash
terraform output -raw cloud_run_url
curl $(terraform output -raw cloud_run_url)
```

Expected Result:

```
Hello World!
```

---

## 💡 Notes & Troubleshooting

| Issue          | Solution                                              |
| -------------- | ----------------------------------------------------- |
| 403 Permission | Ensure `roles/editor` or `roles/run.admin`            |
| API Disabled   | Run `gcloud services enable run.googleapis.com` again |
| Auth Expired   | Re-run `setup_auth_min.sh`                            |

---

## ✅ Today’s Progress Summary

* Verified L2 results (remote state, billing, bucket)
* Created L3 directory & design skeleton
* Implemented minimal auth shell (`setup_auth_min.sh`)
* Prepared Cloud Run deployment outline

Next:

> Deploy “Hello World” container via Terraform
> and confirm Cloud Run endpoint works successfully 🌍

---

**Document version:** `v0.1`
**Author:** @conti0513
**Date:** 2025-10-29
**Project:** Terraform Sandbox Series (L1–L10)

```

---




いい流れです。次は**ステップ2（API有効化）**から入ればOK。
そのあと、**最小構成（レジストリ無し・公開イメージ使用）**で Cloud Run “Hello” を出します。休憩後の30分スプリント用に、手順を**コンパクト**に置いておきます（時間の約束はしませんが、タイトめに切ってあります）。

---

# 休憩後スプリント用チェックリスト

## 0) 再認証（必要なら）

```bash
setup_auth_min.sh
```

## 1) 必要APIを有効化（最小）

```bash
gcloud services enable run.googleapis.com \
  --project=terraform-sandbox-lab
```

> まずは **Artifact Registry なし** で進めます（公開イメージ利用）。

## 2) Terraform 追記（03_cloudrun_hello/）

### services.tf（追記）

```hcl
resource "google_project_service" "run" {
  project            = var.project
  service            = "run.googleapis.com"
  disable_on_destroy = false
}
```

### cloudrun.tf（新規）

```hcl
# 最小の Cloud Run（公開イメージを直接使用）
resource "google_cloud_run_service" "hello" {
  name     = "hello-world"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true

  depends_on = [google_project_service.run]
}

# 非認証アクセスを許可
resource "google_cloud_run_service_iam_member" "invoker_all" {
  location = google_cloud_run_service.hello.location
  service  = google_cloud_run_service.hello.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "cloud_run_url" {
  value = google_cloud_run_service.hello.status[0].url
}
```

> これで「API有効化 → Cloud Run作成 → 公開URL出力 → 誰でもアクセス可」まで最短ルート。

## 3) 実行

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## 4) 動作確認

```bash
terraform output -raw cloud_run_url
curl "$(terraform output -raw cloud_run_url)"
```

> `Hello World!` が返ればOK。

---

## 片付け（任意・破棄）

```bash
terraform destroy -auto-approve
```

---

## 次の拡張（後で）

* Artifact Registry を Terraformで作成 → 自前のイメージをデプロイ
* `google_cloud_run_v2_service` への移行（必要に応じて）
* Cloud Runの環境変数、CPU/メモリ、最小/最大インスタンスなどの調整

休憩ゆっくりどうぞ。戻ったら上の順で進めれば、Cloud Run “Hello” まで一直線です。

