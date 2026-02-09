# 🌥️ Terraform Layer 3 — Cloud Run Hello Design (Final)

## 🧭 Feedback Summary from Layer 2 (GCP Connect)

**Achievements**

- Migrated Terraform state → **GCS Backend** (`backend "gcs"`)
- Linked **Billing Account** to `terraform-sandbox-lab` → Verified `billingEnabled: true`
- Created and verified both **tfstate bucket** and **validation bucket**
- Confirmed `terraform output -raw lab_bucket_name` returns a valid bucket name
- `.gitignore` excludes state and credential files → no secret exposure

> ✅ Terraform environment is now **cloud-ready**.  
> All future infrastructure (Cloud Run, VPC, Artifact Registry, etc.) will safely share the same remote state.

---

## 🎯 Objective of Layer 3 — “Hello Cloud Run”

Deploy a **minimal “Hello World” container** to **Cloud Run** via Terraform  
to verify GCP API activation, container deployment, and end-to-end IaC connectivity.

---

## 🧩 Architecture Overview

```text
+--------------------+
| Terraform CLI (IaC)|
+---------+----------+
          |
          v
+-------------------------+
| GCP Authentication (ADC)|
|  ↳ setup_auth_min.sh    |
+-------------------------+
          |
          v
+-------------------------+
| Google Cloud APIs       |
|  • run.googleapis.com    |
|  • artifactregistry...   |
+-------------------------+
          |
          v
+-------------------------+
| Cloud Run Service       |
|   name: hello-world     |
|   image: gcr.io/cloudrun/hello |
+-------------------------+
          |
          v
+-------------------------+
| Public Endpoint (HTTPS) |
| e.g. hello-world-xxxx.a.run.app |
+-------------------------+
````

---

## 🪜 Step 0 — Directory Setup




```bash
cd /workspaces/development_public/devops_notes/Terraform/sandbox
cp -a 02_gcp_connect/. 03_cloudrun_hello/
cd 03_cloudrun_hello
rm -rf .terraform terraform.tfstate .terraform.lock.hcl
```

> Create a clean copy from Layer 2 to initialize the Cloud Run environment.

---

## 🪜 Step 1 — Re-authenticate (using helper script)

```bash
setup_auth_min.sh
```

> This script:
>
> * Refreshes both `gcloud` and ADC authentication
> * Sets the correct quota project
> * Validates both tokens

---

## 🪜 Step 2 — Enable Required APIs

```bash
gcloud services enable run.googleapis.com \
  --project=terraform-sandbox-lab
```

> Enables Cloud Run API (Artifact Registry will be used later in Layer 4).

---

## 🪜 Step 3 — Terraform Configuration Overview

| File               | Description                                |
| ------------------ | ------------------------------------------ |
| `backend.tf`       | GCS backend configuration (shared with L2) |
| `providers.tf`     | Google provider setup                      |
| `services.tf`      | Enable required GCP services               |
| `cloudrun.tf`      | Cloud Run service definition               |
| `terraform.tfvars` | Project, region, and variable definitions  |
| `versions.tf`      | Provider version lock (google ≥ 5.0.0)     |

---

## 🪜 Step 4 — Define Cloud Run Resources (Minimal)

```hcl
resource "google_project_service" "run" {
  project            = var.project
  service            = "run.googleapis.com"
  disable_on_destroy = false
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
  depends_on = [google_project_service.run]
}

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

---

## 🧪 Step 5 — Apply and Verify Deployment

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

Check output:

```bash
terraform output -raw cloud_run_url
curl "$(terraform output -raw cloud_run_url)"
```

Expected Result:

```
Hello World!
```

---

## 💡 Troubleshooting Tips

| Issue                 | Solution                                              |
| --------------------- | ----------------------------------------------------- |
| 403 Permission denied | Ensure `roles/editor` or `roles/run.admin`            |
| API Disabled error    | Run `gcloud services enable run.googleapis.com` again |
| Expired credentials   | Re-run `setup_auth_min.sh` to refresh tokens          |

---

## ✅ Layer 3 Summary

**Achievements:**

* Verified GCS remote state (Layer 2)
* Created new Cloud Run environment via Terraform
* Authenticated using minimal shell (`setup_auth_min.sh`)
* Deployed “Hello World” container successfully
* Validated URL access and HTTPS endpoint response

> 🎉 Cloud Run via Terraform is now working end-to-end.
> This marks the completion of a minimal IaC deployment pipeline on GCP.

---

## 🧱 Next Layer (Preview: L4)

* Add **Artifact Registry** and push a **custom container**
* Reference the image from Terraform
* Introduce CI/CD automation (GitHub Actions or Cloud Build)

---

**Document version:** `v1.0`
**Author:** @conti0513
**Date:** 2025-10-30
**Project:** Terraform Sandbox Series (L1–L10)


