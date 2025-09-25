# ✅ SC-900 学習パス一覧 & チートシート

SC-900 の試験範囲に直結する 4 つのラーニングパスです。  
この順番で学習すれば効率よく全体を網羅できます。  

---

## 📚 学習パス一覧

### 1. セキュリティ、コンプライアンス、ID の概念の概要
🔗 https://learn.microsoft.com/ja-jp/training/paths/describe-basic-concepts-of-cybersecurity/

- サイバーセキュリティの基本概念  
- 認証 / 認可、ゼロトラストモデル  
- 脅威の種類と軽減策  

---

### 2. Microsoft Entra の概要
🔗 https://learn.microsoft.com/ja-jp/training/paths/describe-basic-concepts-of-entra/

- Microsoft Entra ID (旧 Azure AD) の役割  
- ID 管理とアクセス制御  
- 条件付きアクセス、多要素認証 (MFA)  

---

### 3. Microsoft Priva と Microsoft Purview の概要
🔗 https://learn.microsoft.com/ja-jp/training/paths/describe-basic-concepts-of-purview-priva/

- データ ガバナンスとコンプライアンス  
- データ保護 (DLP, ラベル付け, 暗号化)  
- インサイダーリスク管理、eDiscovery  

---

### 4. Microsoft セキュリティ ソリューションの概要
🔗 https://learn.microsoft.com/ja-jp/training/paths/describe-basic-concepts-of-security-solutions/

- Microsoft Defender ファミリー  
- SIEM / SOAR (Microsoft Sentinel)  
- セキュリティ運用の統合と自動化  

---

# 🛡️ SC-900 チートシート

---

## 1. セキュリティ、コンプライアンス、ID の概念の概要

### 🔑 基本概念
- **セキュリティ**：データ・資産を脅威から守る  
- **コンプライアンス**：規制・法律・業界標準に準拠  
- **ID 管理**：ユーザーやデバイスを一意に識別し、アクセスを制御  

### 🎯 攻撃ベクトルと脅威
- **ソーシャルエンジニアリング** → 心理操作（例: フィッシング）  
- **マルウェア**：ウイルス / ワーム / トロイの木馬 / バックドア  
- **インサイダー脅威**：内部関係者による不正利用  
- **ゼロデイ脆弱性**：修正パッチが未提供の欠陥  

### 🛡️ 軽減策
- パッチ管理（定期更新）  
- 多要素認証 (MFA)  
- ゼロトラスト（明示的に確認 / 侵害前提 / 最小特権）  

### 🔐 認証と認可
- **認証**：本人確認（知識 / 所有物 / 生体）  
- **認可**：何ができるかを制御（RBAC）  

### 🔢 暗号の基本
- 対称鍵：同じ鍵で暗号化/復号  
- 非対称鍵：公開鍵 + 秘密鍵  
- ハッシュ関数：改ざん検知  

### 🌐 ネットワーク脅威
- MITM攻撃（盗聴・改ざん）  
- ネットワークセグメント化  
- VPNによる暗号化  

### 💻 アプリケーション脅威
- ゼロデイ攻撃  
- 軽減策：アプリ自動更新を有効化  

### 📊 まとめフレーズ
- 「ゼロトラスト = 決して信頼せず常に検証」  
- 「MFA = パスワード侵害対策」  
- 「パッチ管理 = 脆弱性対策」  

---

## 2. Microsoft Entra の概要

### 🌐 Microsoft Entra とは
- **ID & Access 管理製品ファミリー**  
- 主なサービス：  
  - Entra ID（旧 Azure AD）  
  - Permissions Management（マルチクラウド権限管理）  
  - Verified ID（分散型ID）  

### 👤 Entra ID
- 認証 & 認可を提供  
- 機能：
  - SSO  
  - MFA  
  - 条件付きアクセス  
  - デバイス管理  

### 🔒 アクセス制御
- **SSO**：1度のログインで複数アプリ利用  
- **MFA**：「知識 + 所有物 + 生体」で追加認証  
- **条件付きアクセス**：状況に応じて制御  

### 🎯 RBAC と ID 管理
- RBAC = 最小特権アクセスの実現  
- ID ライフサイクル：作成 → 更新 → 削除  

### 🪪 Verified ID
- 分散型ID（DID）を提供  
- デジタル証明の所有・提示  

### 🛡️ Permissions Management
- Azure, AWS, GCP の権限を一元管理  
- 過剰権限検出 & 最小特権適用  

### 📊 まとめフレーズ
- 「Entra ID = クラウド版 AD」  
- 「SSO = 一度のログインで全アプリ」  
- 「MFA = 最優先のセキュリティ対策」  
- 「条件付きアクセス = 動的制御」  

---

## 3. Microsoft Priva と Microsoft Purview の概要

### 🛡️ Microsoft Priva
- プライバシー管理ツール  
- DSR（データ主体リクエスト）対応  
- プライバシーリスク管理  
- データ使用に関する透明性を提供  

### 🔎 Microsoft Purview
- データ ガバナンス & コンプライアンス基盤  
- 機能：
  - データ分類 / ラベル付け / DLP  
  - eDiscovery  
  - 監査 (Audit)  
  - コミュニケーションコンプライアンス  

### 📊 比較
| 製品 | 目的 | 主な機能 |
|------|------|----------|
| **Priva** | プライバシー管理 | DSR、自動化、透明性 |
| **Purview** | ガバナンス & コンプライアンス | 分類、DLP、監査 |

### 🎯 まとめフレーズ
- 「Priva = プライバシー保護 / DSR管理」  
- 「Purview = データ管理とコンプライアンス」  

---

## 4. Microsoft セキュリティ ソリューションの概要

### 🛡️ Defender ファミリー
- **Defender for Endpoint**：EDR、脆弱性管理  
- **Defender for Identity**：ID攻撃検出  
- **Defender for Office 365**：フィッシング対策（Safe Links/Attachments）  
- **Defender for Cloud Apps**：CASB、SaaS制御  
- **Defender for Cloud**：マルチクラウド保護（CSPM/CWPP）  

### 🔎 Microsoft Sentinel
- **クラウドネイティブ SIEM/SOAR**  
- ログ分析、アラート検知、自動レスポンス  

### 📊 Purview (再掲)
- コンプライアンス & データ管理統合基盤  

### 🛠️ その他ソリューション
- Security Copilot（AIセキュリティ分析）  
- Entra Permissions Management（権限管理）  
- Priva（プライバシー保護）  

### 📌 試験ポイント
- Defender 各製品のカバー範囲を区別  
- Sentinel = SIEM/SOAR  
- Defender for Cloud = マルチクラウド対応  

### 🎯 まとめフレーズ
- 「Defender = 多層防御」  
- 「Sentinel = SIEM/SOAR」  
- 「Purview = データガバナンス」  

---

# 📘 SC-900 Glossary of Key Terms (Expanded)

Essential terms frequently tested in **SC-900**.  
Focus on **definitions + Japanese keyword bridge** for quick review.  

---

## 🔑 Core Security Concepts
- **Confidentiality (機密性)** — Ensuring data is only accessible to authorized users.  
- **Integrity (完全性)** — Guaranteeing that data is accurate and unaltered.  
- **Availability (可用性)** — Making sure data and services are accessible when needed.  
- **Zero Trust (ゼロトラスト)** — "Never trust, always verify"; continuous verification of users and devices.  
- **Defense in Depth (多層防御)** — Multi-layered approach to security.  

---

## 🔐 Identity & Access
- **Authentication (認証)** — Verifying identity (password, token, biometric).  
- **Authorization (認可)** — Defining what resources a user can access.  
- **RBAC (ロールベースアクセス制御)** — Permissions assigned to roles, not individuals.  
- **Least Privilege (最小権限の原則)** — Users get only the access necessary to perform tasks.  
- **SSO (シングルサインオン)** — One login for multiple apps/services.  
- **MFA (多要素認証)** — Requires two or more authentication methods.  
- **Privileged Identity Management / PIM (特権ID管理)** — Manage and monitor privileged accounts.  
- **Just-In-Time Access / JIT (JITアクセス)** — Temporary elevated access.  
- **Passwordless Authentication (パスワードレス認証)** — FIDO2 keys, Windows Hello, Authenticator app.  

---

## 🌐 Microsoft Entra (Identity)
- **Microsoft Entra ID (旧 Azure AD)** — Cloud-based identity and access management (IAM).  
- **Conditional Access (条件付きアクセス)** — Policies controlling access based on conditions (location, device, risk).  
- **Verified ID (検証済みID)** — Decentralized identity / verifiable credentials.  
- **Permissions Management (権限管理)** — Cloud Infrastructure Entitlement Management (CIEM).  

---

## 🛡️ Security Solutions
- **Microsoft Defender for Endpoint (エンドポイント保護)** — Protects devices against malware and advanced threats.  
- **Microsoft Defender for Identity (ID保護)** — Detects suspicious activity in AD / Entra ID.  
- **Microsoft Defender for Office 365 (O365保護)** — Phishing, spam, malicious attachments/links.  
- **Microsoft Defender for Cloud Apps (MCAS / CASB)** — SaaS visibility/control.  
- **Microsoft Defender for Cloud (クラウド保護)** — Security posture across Azure, AWS, GCP.  
- **Microsoft Sentinel (クラウドSIEM)** — SIEM + SOAR for detection and automated response.  
- **Microsoft Secure Score (セキュリティスコア)** — Measurement of security posture.  
- **Attack Simulation Training (攻撃シミュレーション)** — Phishing simulation & awareness training.  
- **Defender XDR (統合Defender)** — Cross-product detection & response integration.  

---

## 📊 Compliance & Governance
- **Microsoft Purview (データガバナンス/コンプライアンス)** — Unified compliance solution.  
- **Data Loss Prevention / DLP (情報漏えい防止)** — Prevents sensitive data from leaving the org.  
- **Sensitivity Labels (機密ラベル)** — Classify and protect data (encryption, watermark).  
- **eDiscovery (電子情報開示)** — Find/manage data for legal cases.  
- **Audit Logs (監査ログ)** — Record user/admin activities.  
- **Insider Risk Management (内部リスク管理)** — Detects risky insider activity.  
- **Communication Compliance (コミュニケーション コンプライアンス)** — Monitor messages for compliance.  
- **Information Barriers (情報バリア)** — Prevent communication between groups.  
- **Records Management (記録管理)** — Define retention and disposition of records.  

---

## 🔎 Privacy
- **Microsoft Priva (プライバシー管理)** — Privacy risk management solution.  
- **Data Subject Request / DSR (データ主体要求)** — User request for data access/deletion.  
- **Privacy Risk Management (プライバシーリスク管理)** — Detects overexposed/misused personal data.  
- **GDPR (EU一般データ保護規則)** — European privacy regulation.  
- **CCPA (カリフォルニア消費者プライバシー法)** — California privacy regulation.  

---

## ⚡ Threats & Mitigations
- **Phishing (フィッシング)** — Deceptive messages to steal credentials.  
- **Malware (マルウェア)** — Virus, worm, Trojan, ransomware.  
- **Backdoor (バックドア)** — Hidden unauthorized access.  
- **MITM / Man-in-the-Middle (中間者攻撃)** — Intercepting communication.  
- **Patch Management (パッチ管理)** — Regular updates to fix vulnerabilities.  
- **Threat Intelligence (脅威インテリジェンス)** — Knowledge about threats and attackers.  

---

## 🧩 Acronyms to Remember
- **IAM** — Identity and Access Management (IDとアクセス管理)  
- **SSO** — Single Sign-On (シングルサインオン)  
- **MFA** — Multi-Factor Authentication (多要素認証)  
- **RBAC** — Role-Based Access Control (ロールベースアクセス制御)  
- **CASB** — Cloud Access Security Broker (クラウドアクセスセキュリティブローカー)  
- **SIEM** — Security Information and Event Management (セキュリティ情報イベント管理)  
- **SOAR** — Security Orchestration, Automation, and Response (セキュリティオーケストレーション自動化対応)  
- **DLP** — Data Loss Prevention (情報漏えい防止)  

---
