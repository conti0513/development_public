````markdown
# 🧱 Terraform Layer 2 — GCP Connect Design (Execution Summary)

## 🎯 Objective
In this layer, we **migrate Terraform state management from local to GCS**  
and **enable billing for the GCP project**, preparing the environment so Terraform can manage Google Cloud resources securely.

---

## 🪜 Workflow (Fast, Safe, and Copy-Paste Ready)

### 0️⃣ Preparation — Clone from Layer 1 (Clean Copy)
```bash
cd /workspaces/development_public/devops_notes/Terraform/sandbox
cp -a 01_init_validate/. 02_gcp_connect/
cd 02_gcp_connect
rm -rf .terraform terraform.tfstate .terraform.lock.hcl
````

> Clean copy from Layer 1 (local state) and initialize a fresh environment for Layer 2 (GCS backend).

---

### 1️⃣ Re-authenticate & Set Environment Variables

```bash
export PROJECT_ID="terraform-sandbox-lab"
export TFSTATE_BUCKET="${PROJECT_ID}-tfstate"
gcloud auth login --update-adc --no-launch-browser
gcloud config set project "$PROJECT_ID"
gcloud auth application-default set-quota-project "$PROJECT_ID"
gcloud auth print-access-token >/dev/null && echo "gcloud OK"
gcloud auth application-default print-access-token >/dev/null && echo "ADC OK"
```

---

### 2️⃣ Enable Billing (first-time setup)

If billing is disabled, GCS bucket creation will fail with **HTTP 403**.

```bash
gcloud beta billing projects describe terraform-sandbox-lab
gcloud beta billing accounts list
```

Link your project with a billing account using the retrieved `ACCOUNT_ID`:

```bash
gcloud beta billing projects link terraform-sandbox-lab \
  --billing-account=01AACC-E66176-43BBDC
```

Confirm:

```bash
gcloud beta billing projects describe terraform-sandbox-lab
# billingEnabled: true
```

---

### 3️⃣ Create the tfstate Bucket (gcloud)

```bash
gcloud storage buckets create gs://$TFSTATE_BUCKET \
  --project="$PROJECT_ID" --location=asia-northeast1 \
  --uniform-bucket-level-access
```

> Creates a dedicated GCS bucket to store Terraform state files.

---

### 4️⃣ Add `backend.tf` (GCS Backend Configuration)

```bash
cat > backend.tf <<'EOF'
terraform {
  backend "gcs" {
    bucket = "terraform-sandbox-lab-tfstate"
    prefix = "envs/sandbox"
  }
}
EOF

terraform init -migrate-state
```

> Migrates `.tfstate` from local storage to GCS,
> enabling secure state sharing across teams and CI/CD pipelines.

---

### 5️⃣ Add Terraform-Managed Resources (API + Validation Bucket)

```bash
# services.tf
cat > services.tf <<'EOF'
resource "google_project_service" "storage" {
  project            = var.project
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}
EOF

# versions.tf (add random provider)
cat > versions.tf <<'EOF'
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
  }
}
EOF

# bucket.tf
cat > bucket.tf <<'EOF'
resource "random_id" "suffix" { byte_length = 2 }

resource "google_storage_bucket" "lab" {
  name                        = "${var.project}-tf-lab-${random_id.suffix.hex}"
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = true
  depends_on                  = [google_project_service.storage]
}

output "lab_bucket_name" { value = google_storage_bucket.lab.name }
EOF
```

---

### 6️⃣ Apply Changes

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

> On success, a validation bucket will be created
> (e.g., `terraform-sandbox-lab-tf-lab-8876`).

---

### 7️⃣ Verification

```bash
# Verify state is stored in GCS
gcloud storage ls gs://$TFSTATE_BUCKET/envs/sandbox

# Check the Terraform-created validation bucket
terraform output -raw lab_bucket_name
gcloud storage ls gs://$(terraform output -raw lab_bucket_name)
```

---

## 💡 Troubleshooting

| Issue                  | Resolution                                                   |
| ---------------------- | ------------------------------------------------------------ |
| Authentication expired | `gcloud auth application-default login`                      |
| Permission denied      | Assign yourself the `Storage Admin` role                     |
| API not enabled        | Verify `storage.googleapis.com` is included in `services.tf` |

---

## ✅ Results Achieved

* [x] Billing enabled for the project
* [x] GCS buckets created (tfstate & validation)
* [x] Terraform state migrated to GCS
* [x] Managed API resources via Terraform
* [x] Secure and minimal GCP integration confirmed

---

## 💰 Cost Summary

Only a few KB of GCS usage for state files.
**Monthly cost: ¥0 (within Always Free tier).**

---

## 🚀 Next Step (Layer 3)

In **Layer 3**, we’ll enable **Cloud Run** and **Artifact Registry APIs** via Terraform
and deploy a **“Hello World” Cloud Run service** for validation.

```
```
