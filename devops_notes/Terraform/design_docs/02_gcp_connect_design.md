
# L2 実行（最短・安全・コピペOK）

## 0) 事前移動＆L1から雛形コピー

```bash
cd /workspaces/development_public/devops_notes/Terraform/sandbox
cp -a 01_init_validate/. 02_gcp_connect/
cd 02_gcp_connect
rm -rf .terraform terraform.tfstate .terraform.lock.hcl
　「L1（ローカルstateの検証用）環境をきれいに初期化し、L2（GCSバックエンド環境）を真っさらな状態で構築するためのリセット」

```

## 1) tfstate用バケットを先に作る（初回のみ gcloud）

```bash
export PROJECT_ID="terraform-sandbox-lab"
export TFSTATE_BUCKET="${PROJECT_ID}-tfstate"
gcloud storage buckets create gs://$TFSTATE_BUCKET \
  --project=$PROJECT_ID --location=asia-northeast1 \
  --uniform-bucket-level-access
```

## 2) backend.tf を追加（stateをGCSへ）

```bash
cat > backend.tf <<'EOF'
terraform {
  backend "gcs" {
    bucket = "terraform-sandbox-lab-tfstate"
    prefix = "envs/sandbox"
  }
}
EOF
```

**state 移行（初期化）**

```bash
terraform init -migrate-state
```

## 3) API管理＆検証用バケットの定義を追加

```bash
# services.tf
cat > services.tf <<'EOF'
resource "google_project_service" "storage" {
  project            = var.project
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}
EOF

# versions.tf に random 追加（上書き）
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

## 4) plan → apply

```bash
terraform init    # random追加で一度だけ
terraform plan
terraform apply -auto-approve
```

## 5) 検証

```bash
# state がGCSにあるか
gcloud storage ls gs://$TFSTATE_BUCKET/envs/sandbox

# 作られた検証バケット名＆存在確認
terraform output -raw lab_bucket_name
gcloud storage ls gs://$(terraform output -raw lab_bucket_name)
```

---

## 詰まったら（超要約）

* 認証系：`gcloud auth application-default login`
* 権限：自アカに `Storage Admin` と `Viewer` 以上
* API：`services.tf` の `storage.googleapis.com` を確認（depends_on 済み）

---

## 今日のゴール（チェック）

* [ ] tfstate用GCSバケット作成（gcloud）
* [ ] `backend.tf` 追加 → `terraform init -migrate-state` 成功
* [ ] `storage.googleapis.com` を Terraform 管理化
* [ ] 検証用GCSバケットを Terraform で作成
* [ ] state と バケットの存在をGCSで確認

ここまで通れば **Layer 2 完了**です。
進めてログを貼ってくれれば、そのまま **Layer 3（Cloud Run Hello）** の雛形を渡します。
