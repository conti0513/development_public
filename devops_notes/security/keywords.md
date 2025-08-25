# Security Cheat Sheet

## 目次
1. Identity & Access
2. SaaSセキュリティ
3. IDライフサイクル管理
4. Zero Trust / ネットワーク境界
5. 監視・運用基盤
6. データ保護
7. 端末セキュリティ
8. クラウドネイティブセキュリティ

---

## 1. Identity & Access

- **IAM**: *Identity and Access Management*（権限管理の基本）
- **RBAC**: *Role-Based Access Control*（役割ベースでのアクセス制御）
- **SSO**: *Single Sign-On*（複数サービスを1つの認証で利用）
- **MFA**: *Multi-Factor Authentication*（多要素認証）
- **JIT Access**: *Just-In-Time Access*（一時的な権限付与）
- **PAM**: *Privileged Access Management*（特権アカウント管理）

---

## 2. SaaSセキュリティ

- **Google Workspace / Microsoft 365 / HENNGE**
  - SSO・アクセス制御・条件付きアクセス
  - **HENNGE**: 国内SaaSセキュリティ基盤（SSO・アクセス制御に強み）

---

## 3. IDライフサイクル管理

- 入退社・異動に伴う **アカウント作成／削除／権限変更の自動化**
- **SCIM**: *System for Cross-domain Identity Management*（標準プロビジョニング仕様）

---

## 4. Zero Trust / ネットワーク境界

- **Zero Trust**: *Zero Trust Architecture*（信用せず都度検証）
- **VPC Service Controls**: *Virtual Private Cloud Service Controls*（GCPリソース境界でのデータ流出防止）

---

## 5. 監視・運用基盤

- **SIEM**: *Security Information and Event Management*（ログ収集・相関分析）
- **Cloud Logging**（GCP）, **Azure Sentinel**（Microsoft）
- **SOC**: *Security Operations Center*（セキュリティ監視組織）
- **CSIRT**: *Computer Security Incident Response Team*（インシデント対応チーム）
- **SOAR**: *Security Orchestration, Automation and Response*（対応自動化基盤）

---

## 6. データ保護

- **CASB**: *Cloud Access Security Broker*（クラウド利用の可視化・制御）
- **DLP**: *Data Loss Prevention*（機密データ漏洩防止）
- **KMS**: *Key Management Service*（暗号鍵管理）
- **BYOK**: *Bring Your Own Key*（顧客側で鍵を持ち込み暗号化）
- **Audit Logs**: *Audit Logging*（監査証跡の保持）

---

## 7. 端末セキュリティ

- **EDR**: *Endpoint Detection and Response*（端末の脅威検知・対応）
- **MDM**: *Mobile Device Management*（端末管理、ポリシー配布）
- **ESET / Intune / Malion**: 実務経験あり

---

## 8. クラウドネイティブセキュリティ

- **CSPM**: *Cloud Security Posture Management*（クラウド構成のベストプラクティス準拠チェック）
- **CNAPP**: *Cloud-Native Application Protection Platform*（クラウド〜コンテナ〜アプリ全体の保護）

---

# 詳細

## 1. Identity & Access

### IAM
- **IAM**: *Identity and Access Management*（権限管理の基本）
- **経験**: AWS / GCP / Microsoft 365 / Google Workspace / HENNGE にて管理者経験。入退社に伴うアカウント発行・削除、権限付与の運用改善。
- **実務適用例**: マルチクラウド・マルチSaaS環境のIAMを一元管理し、IPO準備に向けた監査ログや内部統制強化に関与。
- **規模感**: 100〜500名規模の従業員管理。Microsoft Entra ID では10万人超のグローバルユーザーを対象。
- **関連規格**: ISO/IEC 27001（アクセス制御）、CIS Control v8（IAM管理）
- **経験レベル**: 導入・運用・改善フェーズを担当。

---

### RBAC
- **RBAC**: *Role-Based Access Control*（役割ベースでのアクセス制御）
- **経験**: Google Workspace, Microsoft 365, HENNGE, AWSにてロール設計・権限割当を運用。
- **実務適用例**: 部門・職種ごとの権限スコープを整理し、属人的管理を排除。
- **規模感**: 主に100〜500名規模の組織に適用。
- **関連規格**: ISO/IEC 27001 A.9.2（ユーザーアクセス権の管理）
- **経験レベル**: 運用改善フェーズを中心に実務経験。

---

### SSO
- **SSO**: *Single Sign-On*（複数サービスを1つの認証で利用）
- **経験**: HENNGEを介したGoogle Workspace連携、Microsoft Entra IDを用いたSaaS連携の導入・運用を経験。
- **実務適用例**: SSO基盤を導入し、利便性とセキュリティを両立。複数プロジェクトにて定着化を支援。
- **規模感**: 100〜500名規模の組織での導入。Entra IDでは10万人以上のグローバルユーザーを対象。
- **関連規格**: NIST 800-63（デジタルアイデンティティ指針）
- **経験レベル**: 導入〜運用定着まで対応。

---

### MFA
- **MFA**: *Multi-Factor Authentication*（多要素認証）
- **経験**: 各種SaaSでMFA導入・運用を実施。RedMine環境ではMFA機能を開発・実装。
- **実務適用例**: フィッシング対策としてMFAを標準化し、海外拠点を含むユーザーに展開。
- **規模感**: 100〜500名規模の社内導入、Entra IDでは10万人規模＋グローバルユーザー対応を経験。
- **関連規格**: NIST 800-63B（MFA推奨）
- **経験レベル**: 運用フェーズ＋一部開発寄りの実装経験。

---

### JIT Access
- **JIT Access**: *Just-In-Time Access*（一時的な権限付与）
- **経験**: MalionにてUSB・カメラ権限の一時付与・回収を実装。
- **実務適用例**: 小売現場における柔軟な権限付与を仕組化し、業務効率とセキュリティを両立。
- **規模感**: 100〜500名規模の組織に適用。
- **関連規格**: NIST Zero Trust Architecture（動的アクセス制御）
- **経験レベル**: 運用改善の実務経験。

---

### PAM
- **PAM**: *Privileged Access Management*（特権アカウント管理）
- **経験**: GWS, M365, AWSでRoot発行・管理アカウント利用・監査ログ対応を実施。
- **実務適用例**: 特権アカウント利用を制御し、監査証跡を保持。監査法人対応や内部統制監査に貢献。
- **規模感**: 100〜500名規模の組織管理。
- **関連規格**: ISO/IEC 27001 A.9.4（システム・アプリケーションアクセス制御）
- **経験レベル**: 運用＋監査対応フェーズでの経験。
---
