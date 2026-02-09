# 📦 Gmail CSV to Google Cloud Storage Uploader

This project automatically extracts the **latest `.csv` attachment** from Gmail and uploads it to **Google Cloud Storage (GCS)**. Optionally, it can also store a backup in Google Drive.

A clean, serverless solution built with Google Apps Script.

---

## ✅ Key Features

- 📥 Filters `.csv` attachments based on **email subject** and **filename keywords**
- 📤 Uploads only the **latest file** to GCS, replacing old ones
- 🧹 Automatically deletes older files in GCS to reduce storage usage
- 📁 Optionally saves a backup copy to Google Drive
- ⏰ Runs hourly using a time-based trigger (e.g., every hour at xx:05)

---

## 🧑‍💻 Tech Stack

- Google Apps Script (GAS)
- Gmail API
- Google Cloud Storage (GCS) API
- Google Drive API

---

## 📁 Project Structure

```
gmailcsv_to_gcs_uploader/
├── README.md                        # This guide
├── docs/
│   └── summary.md                  # Optional: use-case documentation
└── scripts/
    ├── saveLatestCsvToGCSAndDrive.js   # Core script
    ├── uploadToGCS.js                  # GCS upload logic
    ├── deleteOldFilesInGCS.js         # GCS cleanup logic
    ├── saveToDrive.js                 # Optional: Drive backup
    └── authorizeStorageAccess.js      # Initial authorization script
```

---

## 🔐 Security Considerations

- Utilizes **OAuth 2.0** via Google Apps Script for access to Gmail, GCS, and Drive
- Only uploads and stores **CSV** files explicitly matching filters
- Deletes outdated files in GCS to avoid unnecessary storage costs

---

## 💡 Use Cases

- Automated upload of sales or inventory CSVs from vendors
- Replaces manual download → upload workflows
- Reduces human error and increases reliability
- Ideal for recurring data feeds into BigQuery or data pipelines

---

## 🧠 Why This Project Helps

- ✅ Easy to set up, no external servers or cron jobs needed
- 🌐 Fully cloud-native, works inside Google Workspace
- ⚡ Can be customized for any Gmail label, sender, filename pattern, or storage location

---

## 🧰 Need Customization?

This project is ideal for clients who:

- Need automation for repetitive Gmail-based file flows
- Want to centralize CSV intake into GCS
- Prefer low-maintenance, serverless solutions

If you’d like to customize this for your team or connect it to another system (e.g., BigQuery, Cloud Run, Slack), feel free to reach out via [GitHub](https://github.com/conti0513) or [Upwork](https://www.upwork.com/) 💼

---

## 📄 License

MIT License  
Free to use, modify, and share with attribution.
```

---
