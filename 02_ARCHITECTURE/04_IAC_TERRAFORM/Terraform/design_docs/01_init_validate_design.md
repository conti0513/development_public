# Layer 1 — Terraform Init & Validate Design

## 🎯 Purpose
Verify that Terraform can run successfully inside **GitHub Codespaces** and connect to **Google Cloud Platform (GCP)** using Application Default Credentials (ADC).  
This layer confirms the local runtime is stable before creating any actual resources.

---

## 🧩 Design Outline

| Item | Description |
|------|--------------|
| Location | `sandbox/01_init_validate/` |
| Files | `versions.tf`, `providers.tf`, `main.tf`, `terraform.tfvars` |
| Terraform Commands | `terraform init`, `terraform validate`, `terraform plan`, `terraform apply` |
| Expected Result | Terraform initializes, validates, and outputs project metadata without creating resources. |

---

## 🪜 Steps

### 1. Prepare GCP project and authentication
```bash
gcloud auth login --update-adc --no-launch-browser
export PROJECT_ID="terraform-sandbox-lab"
gcloud config set project "$PROJECT_ID"
gcloud auth application-default set-quota-project "$PROJECT_ID"
gcloud services enable cloudresourcemanager.googleapis.com --project "$PROJECT_ID"
````

### 2. Create Terraform configuration files

**versions.tf**

```hcl
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}
```

**providers.tf**

```hcl
variable "project" { type = string }
variable "region"  { type = string }
variable "zone"    { type = string }

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
```

**main.tf**

```hcl
data "google_project" "this" {
  project_id = var.project
}

output "project_number" {
  value = data.google_project.this.number
}
output "project_name" {
  value = data.google_project.this.name
}
```

**terraform.tfvars**

```hcl
project = "terraform-sandbox-lab"
region  = "asia-northeast1"
zone    = "asia-northeast1-a"
```

---

### 3. Execute Terraform commands

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## ✅ Expected Result

Terraform runs successfully and reads project metadata.

```
Outputs:

project_name   = "terraform-sandbox-lab"
project_number = "841765922679"

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

No resources are created; only project data is fetched and stored in the local state.

---

## 💬 Notes

* This layer verifies that Terraform ↔ GCP authentication and provider setup are correct.
* The configuration uses **Application Default Credentials (ADC)** stored in `~/.config/gcloud`.
* The output confirms access to the specified project ID.
* The `.terraform.lock.hcl` file should be committed for consistent provider versions.

---

## 🧭 Next Step (Layer 2)

**Layer 2 — GCP Connect Design** will:

1. Configure a **GCS backend** for remote state management.
2. Enable required GCP APIs via `google_project_service`.
3. Create a **GCS bucket** resource (`google_storage_bucket`) for validation.

---

```
