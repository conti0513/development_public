# 📘 Unit Data CSV Automation with Google Apps Script  
# 📘 Google Apps Script によるユニットデータCSV自動処理

This project provides a reusable GAS-based automation for importing, summarizing, and exporting CSV-based unit data  
(e.g., devices, IDs, subscriptions). It is designed for recurring operations such as internal billing prep or SaaS integration.

本プロジェクトは、Google Apps Script（GAS）を活用して、CSVファイルベースのユニットデータ（例：端末、ID、サブスクリプションなど）の  
読み込み・集計・整形を自動化する仕組みを提供します。主に請求データ処理やSaaS連携などの月次業務を想定しています。

---

## ✨ Features / 特徴

- CSV import from Google Drive  
  Googleドライブ上のCSVファイルを自動取り込み  
- Data aggregation by identifier (unit ID, device ID, etc.)  
  IDやデバイス単位での集計処理に対応  
- Export-ready formatting for SaaS tools  
  外部SaaSへの出力用に整形したフォーマットに変換  
- Fully script-based, no add-ons or external costs  
  GASのみで完結、追加コストなし・軽量運用

---

## 📂 Structure / フォルダ構成

```
unit_data_csv_automation/
├── README.md                     # プロジェクト概要
├── docs/
│   └── summary.md                # 日本語＆英語の詳細ドキュメント
└── scripts/
    ├── importCsvFromDrive.js     # CSV読み込み処理
    ├── summarizeByUnit.js        # 単位ごとの集計処理
    └── exportToFormattedSheet.js # フォーマット整形出力
```

---

## 🔗 Use Cases / 利用シーン

- Monthly reconciliation or billing summaries  
  月次請求や社内配賦用の集計業務の自動化  
- Internal SaaS usage aggregation  
  SaaSやモバイルの利用実績データの取りまとめ  
- Streamlined export pipeline for external tools  
  会計・精算・業務管理ツール向けのCSV出力下準備
```

---
