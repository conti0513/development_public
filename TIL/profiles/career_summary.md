cat << 'EOF' > /workspaces/development_public/TIL/profiles/career_summary.md
# 🌍 Career Summary – Global IT Professional Experience  
# 🌍 職務経歴書（グローバル対応・バイリンガル）

---

## ✅ Overview / 概要

This document outlines globally relevant experiences and capabilities for technical roles.  
海外就職や英語環境での仕事を見据えた、実務実績・スキルの整理です。

---

## 📘 Recent Highlights / 直近の実績

### 🔹 2025-04-10 – Google Apps Script: CSV Automation  
- Built reusable automation to aggregate unit-based CSV data in Google Drive  
- Supported multiple encodings (Shift_JIS/UTF-8), preserved leading zeroes  
- Reduced recurring reporting workload via lightweight scripting  

**技術ハイライト**: GAS / Map() / 0埋め保持 / 業務報告自動化

---

### 🔹 2025-04-01 – FTPS Transfer API on Cloud Run  
- Created a serverless file transfer API using Cloud Run + Cloud NAT  
- Enabled FTPS with static IP via VPC Connector  
- Delivered a lightweight and secure solution without VMs  

**技術ハイライト**: 固定IP / Cloud NAT / VPC Connector / FTPS連携

---

## 🔍 Selected Projects – STAR形式での職務整理

### 📌 FTPS Transfer API on Cloud Run  
**Situation:** Needed a secure, serverless method for transferring files to an external FTPS server from Google Cloud Platform.  
**Task:** Avoid virtual machine maintenance, ensure fixed IP access, and follow security standards.  
**Action:** Built a serverless API using Cloud Run + VPC Connector + Cloud NAT to connect to FTPS over static IP.  
**Result:** Delivered a reliable file transfer pipeline with zero VM management and full audit compliance.  

---

### 📌 Google Apps Script – CSV Data Automation  
**Situation:** Internal team was manually aggregating CSV data for reporting, which was time-consuming and error-prone.  
**Task:** Automate the process while supporting Japanese encodings and preserving data integrity.  
**Action:** Developed modular GAS scripts to parse, aggregate, and export unit-based CSV data from Google Drive.  
**Result:** Saved multiple hours of manual work monthly, improved data accuracy, and enabled reuse in other teams.  

---

### 🥇 SFTP Managed Transfer to S3  
**Situation:** Regular file reception from external systems was required with security and automation in mind.  
**Task:** Implement a low-maintenance, secure, and scalable SFTP environment and store files into Amazon S3.  
**Action:**  
- Chose **AWS Transfer Family**  
- Set IAM policies, S3 bucket structure, and tested passive mode  
- Configured static IPs, firewall rules, and traceable logging  
**Result:**  
- Automated secure file imports  
- Enabled S3-triggered workflows  
- Achieved full audit compliance without EC2

---

### 🥈 AWS Lambda + CloudWatch → LINE Alerts  
**Situation:** Business team lacked visibility into backend server performance.  
**Task:** Provide real-time, non-technical notifications via chat tools like LINE.  
**Action:**  
- Built Python Lambda to detect CloudWatch anomalies  
- Used LINE Notify API + Secrets Manager  
- Connected via SNS to deliver alerts  
**Result:**  
- Reduced MTTR  
- Improved cross-team communication  
- Demonstrated full-stack automation skills

---

### 🥉 VPN Server → AWS Managed VPN Migration  
**Situation:** In-house VPN server caused maintenance burden and security lag.  
**Task:** Migrate to AWS-managed VPN with better access control and compliance.  
**Action:**  
- Evaluated AWS Client VPN  
- Designed VPC/subnet/security group  
- Tested full connectivity and created handover docs  
**Result:**  
- Reduced maintenance  
- Improved security  
- Created reusable implementation blueprint

---

## 💼 Role-based Skills / 担当領域別スキルセット

### 🧠 Internal IT & SaaS Operations  
- Google Workspace連携によるアカウント自動作成・削除  
- SaaS利用状況を監査基準で管理、退職者対応の効率化  
- 社内ITと総務部門をまたぐ横断的オペレーションを担当  
→ Automated onboarding/offboarding, SaaS cleanup with audit readiness.

---

### 🛠 Device & Setup Automation  
- Windows/Mac 環境対応、キッティング自動化（PowerShell / Zsh）  
- PC修理（マザーボード・モニター交換など）  
→ Scripted provisioning and manual hardware repair.

---

### 🌐 Network & Security Engineering  
- VLAN分離・QoSを含むアジア小売店舗ネットワーク構築  
- 端末・拠点にESETやSaaSセキュリティを導入  
→ Designed VLAN networks with QoS, deployed endpoint security solutions.

---

### 🤝 Global Communication & Troubleshooting  
- 海外拠点のMicrosoft 365/Entra IDトラブル対応  
- 英語での障害調整・ベンダー折衝（CDN/API連携）  
- 日英バイリンガルでのインシデント報告  
→ Bilingual issue handling, timezone coordination, vendor negotiations.

---

## 🔖 Core Principles / 行動指針と価値観

> “Quiet systems that never fail are better than flashy ones.”  
> 「静かに壊れない仕組みは、派手さより価値がある。」

- Build maintainable, reliable systems  
- Make contributions visible through documentation  
- Embrace quiet effectiveness over flashiness

---

## 📜 Certifications / 保有資格一覧

- 🏅 Google Associate Cloud Engineer（2025年4月予定）  
- 🏅 Microsoft Certified: Azure Administrator Associate  
- 🏅 Microsoft 365 Fundamentals  
- 🏅 Coursera: Python for Data Science – IBM  
- 🏅 Coursera: Introduction to Statistics – University of Michigan  
- 🏅 Cisco Certified Network Associate (CCNA)  
- 🏅 ITIL Foundation v2  
- 🏅 Duolingo English Test: 95（実務英語レベル）

---

## 🏷️ Tags  
`#CloudEngineering` `#Automation` `#Networking` `#BilingualIT` `#ITAdmin` `#GAS` `#FTPS` `#GlobalCareer`
EOF
