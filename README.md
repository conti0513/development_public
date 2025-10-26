````md
# 🧭 Development & Learning Log — Public Repository

This repository documents **daily learning, small automation projects, and IaC (Infrastructure as Code) experiments**  
focusing on **Security Operations, Cloud Infrastructure, and PMO practices**.  
It aims to make operational knowledge **reusable, structured, and continuously improvable**.

---

## 📝 TIL（Today I Learned）

* Simple daily learning logs — “done is better than perfect.”  
* Focus on **continuity and reflection**, not polish.  
* Entries are stored under `/TIL/entries/YYYY/`.

---

## 📂 Repository Structure

```bash
TIL/
  ├── entries/2025/...   # Daily logs
  ├── create_til_entry.sh
  └── til_git_push.sh

devops_notes/
  ├── Terraform/          # IaC Sandbox & Design Docs (Terraform)
  ├── cloud/              # Cloud notes (AWS / GCP)
  ├── docker/             # Docker environment & automation
  ├── gas/                # Google Apps Script
  ├── powershell/         # Windows automation scripts
  ├── python/             # Python utilities
  └── security/           # Security operation notes

project_examples/
  ├── daily-sheet-to-slack/        # GAS: daily report → Slack
  ├── gmailcsv_to_gcs_uploader/    # Node.js CSV uploader
  ├── gws_auto_py/                 # Python GWS automation
  ├── windows_setup_automation/    # Windows setup automation
  └── zapier_form_notify_logger/   # Zapier + GCS logger
````

---

## 💼 Career Summary (Recent 6 Years)

* **2019** — Telecom: M365 deployment & post-support
* **2020–2022** — IT Service: SaaS integration (HENNGE / GWS), security ops, audit support
* **2022–2023** — Healthcare: SharePoint, PowerAutomate, VPN replacement
* **2023–2024** — Manufacturing SIer: Entra ID / Cloud IAM management
* **2024–2025** — Retail (IPO-prep): ESET, GWS, HENNGE ops, audit, vendor coordination, PMO support

---

## 🧱 Key Strengths

* **Security Operations** — Zero Trust (HENNGE / GWS / ESET)
* **Cloud Automation** — AWS Lambda / GCP Cloud Run / Terraform
* **Process Design** — Store IT setup, vendor coordination, weak-current planning
* **PMO Assistance** — Progress tracking, documentation, audit coordination

---

## 🌍 Terraform Sandbox (IaC Learning Environment)

> **“A portable Terraform lab that resets instantly — no local pollution.”**

This Codespaces-based environment enables safe Terraform experimentation.
It focuses on **clean isolation**, **quick resets**, and **step-by-step IaC learning**.

### 🧩 Structure

```bash
devops_notes/
└── Terraform/
    ├── README.md                # Main guide
    ├── scripts/                 # reset / clean scripts
    ├── sandbox/                 # Hands-on experiments (non-committed)
    │   ├── 01_init_validate/    # Terraform basic init/validate
    │   ├── 02_gcp_connect/      # GCP authentication test
    │   └── 03_cloudrun_hello/   # Cloud Run Hello World
    └── design_docs/             # Layer design blueprints
```

### 🧠 Purpose

* Learn Terraform step by step (Layer 1–3)
* Practice IaC safely inside Codespaces
* Prepare for **Terraform Associate (TA-003)** certification
* Use as base material for **Zenn / Udemy courses**

→ See detailed guide: [Terraform README](./devops_notes/Terraform/README.md)

---

## 🚀 Direction

* Maintain consistent **daily learning (TIL)**
* Refine **Terraform Mock environment** for Upwork / portfolio use
* Prepare for **Terraform Associate & GCP certifications**
* Long-term: convert learnings into **Zenn / Udemy** content

---

## 🎯 Policy

* **Record first, refine later**
* **Japanese-first**, with English adaptability for global use
* **Archive outdated info** in `archive_private/`
* **Keep reproducibility & minimalism**

---

**© 2025 Yoshimasaru Kondo — Licensed under MIT License**

```
```
