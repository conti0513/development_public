# 🌥️ Terraform Layer 4 — Cloud Run Custom App Design

**Document version:** `v0.1`  
**Author:** @conti0513  
**Date:** 2025-10-30  
**Project:** Terraform Sandbox Series (L1–L10)

---

## 🧩 Architecture Overview (AA Diagram)

```text
+--------------------------------------------------------+
|                    Terraform (IaC)                     |
|   main.tf / artifact_registry.tf / cloudrun.tf         |
+-------------------------+------------------------------+
                          |
                          v
+--------------------------------------------------------+
|                 Google Cloud Platform (GCP)            |
|                                                        |
|  +-----------------------------------------------+     |
|  | Artifact Registry                             |     |
|  |  - repo: custom-app-repo                      |     |
|  |  - stores built Docker image                  |     |
|  +-----------------------------------------------+     |
|                           |                            |
|                           | (Terraform deploys image)  |
|                           v                            |
|  +-----------------------------------------------+     |
|  | Cloud Run Service                             |     |
|  |  - name: custom-app                           |     |
|  |  - image: artifactregistry/.../custom-app:latest |   |
|  |  - auth: allUsers (public)                    |     |
|  +-----------------------------------------------+     |
|                           |                            |
|                           v                            |
|                 HTTPS Endpoint (Trigger)               |
|        https://custom-app-xxxx.a.run.app               |
+--------------------------------------------------------+
````

---

## 🎯 Objective

Deploy a **custom Python web app (Flask)** as a container on **Cloud Run** using **Terraform**.

This layer validates:

* Docker image build and push to Artifact Registry
* Deployment automation via Terraform
* Public access via HTTPS (no authentication required)

---

## 🧱 Project Structure

```bash
/workspaces/development_public/devops_notes/Terraform/sandbox/
├── 04_cloudrun_custom/
│   ├── app/
│   │   ├── app.py
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   ├── artifact_registry.tf
│   ├── cloudrun.tf
│   ├── backend.tf
│   ├── providers.tf
│   ├── versions.tf
│   ├── terraform.tfvars
│   └── main.tf
```

---

## 🧩 Application — Flask Web App (`app/app.py`)

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Custom App on Cloud Run!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
```

---

## 🐳 Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]
```

---

## 📦 requirements.txt

```
flask
```

---

## ⚙️ Terraform Configuration

### `artifact_registry.tf`

```hcl
resource "google_project_service" "artifact_registry" {
  project            = var.project
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "custom_repo" {
  location      = var.region
  repository_id = "custom-app-repo"
  format        = "DOCKER"
}
```

---

### `cloudrun.tf`

```hcl
resource "google_cloud_run_service" "custom_app" {
  name     = "custom-app"
  location = var.region

  template {
    spec {
      containers {
        image = "LOCATION-docker.pkg.dev/${var.project}/custom-app-repo/custom-app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
  depends_on = [
    google_project_service.artifact_registry,
  ]
}

resource "google_cloud_run_service_iam_member" "invoker_all" {
  location = google_cloud_run_service.custom_app.location
  service  = google_cloud_run_service.custom_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "custom_app_url" {
  value = google_cloud_run_service.custom_app.status[0].url
}
```

---

## 🚀 Execution Flow

```text
[1] Docker build → [2] Push to Artifact Registry
         ↓
[3] Terraform apply → Cloud Run deploy
         ↓
[4] Access HTTPS URL → Container responds
```

---

## ✅ Expected Result

When accessing the deployed URL:

```
Hello from Custom App on Cloud Run!
```

Terraform output example:

```
Outputs:

custom_app_url = "https://custom-app-xxxxx.a.run.app"
```

---

## 💡 Notes & Tips

| Topic                    | Description                                                                                        |
| ------------------------ | -------------------------------------------------------------------------------------------------- |
| **Auth Setup**           | Use `setup_auth_min.sh` (same as Layer 3)                                                          |
| **Push Command Example** | `gcloud builds submit --tag LOCATION-docker.pkg.dev/$PROJECT_ID/custom-app-repo/custom-app:latest` |
| **Cleanup**              | `terraform destroy -auto-approve`                                                                  |
| **Cost**                 | Minimal (Cloud Run free tier + small registry storage)                                             |

---

## 🧠 TIL Summary Template

**TIL Date:** 2025-10-30
**Topic:** Terraform Layer 4 — Cloud Run Custom App
**Duration:** 60 min

**Summary:**

* Reviewed L3 (“Hello World” public container)
* Created L4 design for custom Cloud Run app
* Introduced Artifact Registry + Docker workflow
* Prepared Terraform IaC for end-to-end deployment

---

```

---
