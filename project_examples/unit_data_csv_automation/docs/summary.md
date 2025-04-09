# 📘 TIL: Google Apps Script for Automating Unit-Based CSV Processing  
# 📘 Google Apps Script でユニット単位のCSV処理を自動化

---

## Overview / 概要

This tool automates the import, aggregation, and formatting of structured CSV files stored in Google Drive.  
It is designed to summarize values by unit (e.g., device, service ID) and export the result for external SaaS integration or billing support.

Google Drive 上のCSVからデータを取得し、端末・ID単位で集計、整形する軽量な自動処理ツールです。

---

## 🧠 Script Structure / スクリプト構成

1. `importCsvFromDrive()`  
   Loads the specified CSV file into a target sheet. Supports multiple encodings (Shift_JIS, UTF-8).  
   指定のCSVを読み込み、文字コード変換に対応。

2. `summarizeByUnit()`  
   Extracts rows matching a specific label (e.g., "aggregation target") and aggregates values by unit ID.  
   特定ラベルを抽出し、ID単位で金額を合算。

3. `exportToFormattedSheet()`  
   Transfers the formatted data to an export sheet, ready for CSV output or SaaS upload.  
   整形済データを出力シートに転送。

---

## ✅ Outcome / 成果

- Reduced manual processing time from 30–40 minutes to one-click operation  
- Zero additional cost — pure Google Apps Script  
- Easily maintained and deployed in internal workflows

---

## 💡 Use Cases / 利用シーン

- Internal unit-based cost aggregation  
- Preprocessing for billing or reconciliation CSVs  
- Lightweight workflow automation with no dependency on external tools

---

## 📂 Folder Structure

```
project_examples/unit_data_csv_automation/
├── scripts/
│   ├── importCsvFromDrive.js
│   ├── summarizeByUnit.js
│   └── exportToFormattedSheet.js
├── docs/
│   └── summary.md
└── README.md
```

---

## 🌍 Global Perspective

By structuring this as a modular GAS template, this solution is easily transferable across teams or regions.  
The focus on unit-level aggregation aligns with global best practices for SaaS usage tracking, device management, and internal cost control.
```

---
