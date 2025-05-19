# 🛡️ CompTIA Security+ Knowledge Base (SY0-701)

This directory documents a structured, implementation-aware summary of the **CompTIA Security+ (SY0-701)** syllabus.
Its goal is not mere certification, but the **practical refinement of security language and architectural thinking** used in real-world system design.

このフォルダは、Security+ の学習内容をベースに、実務実装へ応用できるよう整理・構造化された技術ナレッジ集です。
試験対策を越えて、**現場で使える設計視点・検知思考・構成判断の言語化**にフォーカスしています。

---

## 🎯 Purpose / 学習の軸

* 単なる暗記ではなく、「なぜその構成・制御・対策が必要なのか」を理解し、**設計に転用できる言葉で残す**
* TILやポートフォリオと連携し、**再現可能なセキュリティ実装の裏付け**として機能させる
* 各ドメインの知識を、自身のインフラ／クラウド構成・アラート設計・運用監視に繋げて考察

---

## 📂 Directory Overview

```bash
comptia/
├── 01.x.md    # Threats, Vulnerabilities, Attacks
├── 02.x.md    # Architecture & Design
├── 03.x.md    # Secure Networking
├── 04.x.md    # Identity & Access Management
├── 05.x.md    # Risk, Governance, Incident Response
└── README.md  # Index and learning tracker
```

---

## 📚 Core Materials (2025)

| Type         | Title                                                                                                  | Notes                   |
| ------------ | ------------------------------------------------------------------------------------------------------ | ----------------------- |
| 🎥 YouTube   | [Professor Messer – SY0-701](https://www.youtube.com/playlist?list=PLG49S3nxzAnl4QDVqK-hOnoqcSKEIDDuv) | 全セクション網羅 / 音声明瞭 / 無料    |
| 🧪 Udemy     | Jason Dion – Practice Tests                                                                            | 模試5セット＋詳細解説 / 英語の実戦演習向け |
| 💻 TryHackMe | [Security+ Path](https://tryhackme.com/path/outline/comptia)                                           | 実践で学ぶドメイン別のハンズオンルーム     |

---

## 🔗 Integration with My Work

Security+ knowledge is actively reflected in:

* `TIL/`: Concept refinement, term mapping, bilingual phrasing
* `project_examples/`: Slack alert design, webhook auth, monitoring PoC
* `devops_notes/`: FTPS, Cloud NAT, segmentation logic, alert surfaces

---

## 📘 Tracker: Professor Messer Video Series

学習ごとに「英語で1フレーズTIL」を記録し、用語定着・設計観点・応用アイデアに繋げています。
全一覧は本README後半に掲載済みです。

---

## 🎧 ADHD × 非ネイティブの学習最適化戦略（Boo式）

英語講義や資格学習を「完璧に理解しよう」とすると失速しがちです。
Boo式では、**目的の絞り込み → 流し聞き → 記憶残りの1点に集中**することを重視します。

| フェーズ          | 主体ツール           | スタイル                |
| ------------- | --------------- | ------------------- |
| フェーズ1：視聴・要点拾い | TIL（公開・構造化）     | 要点だけ拾って「残す」         |
| フェーズ2：反復記録    | GoodNotes（自由記録） | 感覚的に暴れて記憶に焼きつける     |
| フェーズ3：公開整理    | TIL/ブログ         | 知識を再構成し他者に伝えるアウトプット |

> 「全部理解しない」ことが、長期定着と自分の言葉で話せる力につながります。

---

## 👨‍💻 Author

Security-oriented infrastructure & cloud engineer.
Documenting the **intersection between certification frameworks and deployable designs**.

---


## 📘 Learning Tracker – Professor Messer Series

Each video is followed by a written TIL memo in English.
Focus is placed on *conceptual clarity*, *terminology usage*, and *how it connects to actual system design*.

| No. | Section   | Topic               | Duration | Watched | TIL Logged |
| --- | --------- | ------------------- | -------- | ------- | ---------- |
| 1   | 01\_Intro | How to Pass SY0-701 | 10:07    | ✅       | ✅          |
| 2   | 01.1      | Security Controls   | 11:49    | ✅       | ✅          |
| 3   | 01.2      | CIA Triad           | ...      | ✅       | ✅          |
| 3   | 01.2     | CIA Triad                                   | 5:18     | ✅      | ✅         |
| 4   | 01.2     | Non-repudiation                             | 7:58     | ✅      | ✅         |
| 5   | 01.2     | Authentication, Authorization, Accounting   | 9:04     | ✅      | ✅         |
| 6   | 01.2     | Gap Analysis                                | 6:45     | ✅      | ✅         |
| 7   | 01.2     | Zero Trust                                  | 10:05    | ✅      | ✅         |
| 8   | 01.2     | Physical Security                           | 8:18     | ✅      | ✅         |
| 9   | 01.2     | Deception and Disruption (Honeypot etc.)    | 4:31     | ✅      | ✅         |
| 10  | 01.3     | Change Management                           | 11:22    | ✅      | ✅         |
| 11  | 01.3     | Technical Change Management                 | 10:54    | ✅      | ✅         |
| 12  | 01.4     | Public Key Infrastructure                   | 9:08     | ✅      | ✅         |
| 13  | 01.4     | Encrypting Data                             | 9:48     | ✅      | ✅         |
| 14  | 01.4     | Key Exchange                                | 3:39     | ✅      | ✅         |
| 15  | 01.4     | Encryption Technologies                     | 6:53     | ✅      | ✅         |
| 16  | 01.4     | Obfuscation                                 | 8:00     | ✅      | ✅         |
| 17  | 01.4     | Hashing and Digital Signatures              | 10:25    | ✅      | ✅         |
| 18  | 01.4     | Blockchain Technology                       | 2:22     | ✅      | ✅         |
| 19  | 01.4     | Certificates                                | 14:38    | ✅      | ✅         |
| 20  | 02.1     | Threat Actors                               | 10:23    | ✅      | ✅         |
| 21  | 02.2     | Common Threat Vectors                       | 17:14    | ✅      | ✅         |
| 22  | 02.2     | Phishing                                    | 6:32     | ✅      | ✅         |
| 23  | 02.2     | Impersonation                               | 5:52     | ✅      | ✅         |
| 24  | 02.2     | Watering Hole Attacks                       | 4:12     | ✅      | ✅         |
| 25  | 02.2     | Other Social Engineering Attacks            | 3:29     | ✅      | ✅         |

| No. | Section | Topic                             | Duration | Keywords                                | Watched | TIL Logged |
|-----|---------|-----------------------------------|----------|-----------------------------------------|---------|------------|
| 26  | 02.3    | Memory Injections                 | 2:39     | memory, code injection, heap/shellcode  | ✅      | ✅         |
| 27  | 02.3    | Buffer Overflows                  | 3:37     | memory overwrite, crash, arbitrary code | ✅      | ✅         |
| 28  | 02.3    | Race Conditions                   | 4:58     | timing, simultaneous processes          | ✅      | ✅         |
| 29  | 02.3    | Malicious Updates                 | 5:45     | tampered patch, fake updates            | ✅      | ✅         |
| 30  | 02.3    | OS Vulnerabilities                | 4:09     | kernel exploits, privilege escalation   | ✅      | ✅         |
| 31  | 02.3    | SQL Injection                     | 5:09     | database, query injection, authentication bypass| ✅      | ✅         |
| 32  | 02.3    | Cross-site Scripting (XSS)        | 8:34     | script injection, DOM/stored/reflected  | ✅      | ✅         |
| 33  | 02.3    | Hardware Vulnerabilities          | 6:27     | firmware, Meltdown, Spectre             | ✅      | ✅         |
| 34  | 02.3    | Virtualization Vulnerabilities    | 5:25     | hypervisor, escape attack               | ✅      | ✅         |
| 35  | 02.3    | Cloud-specific Vulnerabilities    | 4:06     | API security, tenant isolation          | ✅      | ✅         |
| 36  | 02.3    | Supply Chain Vulnerabilities      | 9:12     | vendor trust, hardware/software risk    | ✅      | ✅         |
| 37  | 02.3    | Misconfiguration Vulnerabilities  | 7:09     | open ports, default creds, bad ACLs     | ✅      | ✅         |
| 38  | 02.3    | Mobile Device Vulnerabilities     | 3:23     | jailbreaking, untrusted apps, OS flaws  | ✅      | ✅         |
| 39  | 02.3    | Zero-day Vulnerabilities          | 3:02     | unknown exploit, patch delay            | ✅      | ✅         |



| No. | Section | Topic                              | Duration | Keywords                              | Watched | TIL Logged |
|-----|---------|------------------------------------|----------|---------------------------------------|---------|------------|
| 40  | 02.4    | Overview of Malware                | 6:06     | malware types, delivery methods       | ✅      | ✅         |
| 41  | 02.4    | Viruses and Worms                  | 5:54     | self-replication, infection methods   | ✅      | ✅         |
| 42  | 02.4    | Spyware and Bloatware              | 4:21     | tracking, resource hog                | ✅      | ✅         |
| 43  | 02.4    | Other Malware Types                | 7:32     | ransomware, keyloggers, logic bombs   | ✅      | ✅         |
| 44  | 02.4    | Physical Attacks                   | 4:04     | hardware theft, skimming, eavesdropping | ✅      | ✅         |
| 45  | 02.4    | Denial of Service                  | 6:07     | DoS, DDoS, resource exhaustion        | ✅      | ✅         |
| 46  | 02.4    | DNS Attacks                        | 8:57     | DNS poisoning, hijacking              | ✅      | ✅         |
| 47  | 02.4    | Wireless Attacks                   | 7:55     | evil twin, deauth attack              | ✅      | ✅         |
| 48  | 02.4    | On-path Attacks                    | 5:30     | man-in-the-middle, interception       | ✅      | ✅         |
| 49  | 02.4    | Replay Attacks                     | 5:45     | packet capture, session reuse         | ✅      | ✅         |
| 50  | 02.4    | Malicious Code                     | 3:40     | injected code, macros, scripts        | ✅      | ✅         |
| 51  | 02.4    | Application Attacks                | 11:48    | input validation, logic flaws         | ✅      | ✅         |
| 52  | 02.4    | Cryptographic Attacks              | 9:31     | brute force, downgrade, collisions    | ✅      | ✅         |
| 53  | 02.4    | Password Attacks                   | 7:16     | dictionary, brute force, credential stuffing | ✅      | ✅         |
| 54  | 02.4    | Indicators of Compromise           | 10:59    | IOC types, behavioral signs           | ✅      | ✅         |


| No. | Section | Topic                           | Duration | Keywords                                | Watched | TIL Logged |
| --- | ------- | ------------------------------- | -------- | --------------------------------------- | ------- | ---------- |
| 55  | 02.5    | Segmentation and Access Control | 6:06     | VLAN, ACLs, NAC                         | ✅       | ✅          |
| 56  | 02.5    | Mitigation Techniques           | 6:51     | patching, configuration, security tools | ✅       | ✅          |
| 57  | 02.5    | Hardening Techniques            | 12:11    | disable services, secure defaults       | ✅       | ✅        

| No. | Section | Topic                           | Duration | Keywords                                | Watched | TIL Logged |
| --- | ------- | ------------------------------- | -------- | --------------------------------------- | ------- | ---------- |

| 58  | 03.1    | Cloud Infrastructures             | 9:56     | IaaS, PaaS, SaaS, shared responsibility | ✅       | ✅          |
| 59  | 03.1    | Network Infrastructure Concepts   | 6:56     | SDN, SDN data flow, SDN security       | ✅       | ✅          |
| 60  | 03.1    | Other Infrastructure Concepts     | 14:24    | SDN, virtualization, edge computing    | ✅       | ✅          |
| 61  | 03.1    | Infrastructure Considerations     | 13:48    | redundancy, availability, architecture | ✅       | ✅          |
| 62  | 03.2    | Secure Infrastructures            | 5:54     | segmentation, security zones           | ✅       | ✅          |
| 63  | 03.2    | Intrusion Prevention              | 5:14     | IDS/IPS, detection vs prevention       | ✅       | ✅          |
| 64  | 03.2    | Network Appliances                | 11:56    | proxies, load balancers, VPN           | ✅       | ✅          |
| 66  | 03.2    | Firewall Types                    | 8:00     | stateless, stateful, NGFW              | ✅       | ✅          |
| 67  | 03.2    | Secure Communication              | 9:55     | VPN, TLS, IPsec                        | ✅       | ✅          |
| 68  | 03.3    | Data Types and Classifications    | 5:54     | PII, PHI, classification levels        | ✅       | ✅          |
| 69  | 03.3    | States of Data                    | 6:07     | data at rest, in transit, in use       | ✅       | ✅          |
| 70  | 03.3    | Protecting Data                   | 14:28    | encryption, masking, retention         | ✅       | ✅          |
| 71  | 03.4    | Resiliency                        | 9:42     | HA, fault tolerance, redundancy        | ✅       | ✅          |
| 72  | 03.4    | Capacity Planning                 | 3:53     | forecasting, scalability               | ✅       | ✅          |
| 73  | 03.4    | Recovery Testing                  | 5:18     | backup verification, DR drills         | ✅       | ✅          |
| 74  | 03.4    | Backups                           | 12:16    | full, incremental, snapshot            | ✅       | ✅          |
| 75  | 03.4    | Power Resiliency                  | 4:02     | UPS, generators, dual power supplies   | ✅       | ✅          |


| No. | Section | Topic                             | Duration | Keywords                               | Watched | TIL Logged |
|-----|---------|-----------------------------------|----------|----------------------------------------|---------|------------|
| 76  | 04.1    | Secure Baselines                  | 4:11     | config standards, image templates      | ✅       | ✅          |
| 77  | 04.1    | Hardening Targets                 | 10:11    | reduce attack surface, disable services | ✅      | ✅          |
| 78  | 04.1    | Securing Wireless and Mobile      | 8:58     | WPA3, mobile security policies         | ✅       | ✅          |
| 79  | 04.1    | Wireless Security Settings        | 10:55    | WPA2, EAP, SSID management             | ✅       | ✅          |
| 80  | 04.1    | Application Security              | 8:26     | input validation, sandboxing           | ✅       | ✅          |
| 81  | 04.2    | Asset Management                  | 8:37     | inventory, lifecycle, tagging          | ✅       | ✅          |

| No. | Section | Topic                             | Duration | Keywords                               | Watched | TIL Logged |
|-----|---------|-----------------------------------|----------|----------------------------------------|---------|------------|
| 82  | 04.3    | Vulnerability Scanning            | 7:45     | scanners, authenticated/unauthenticated | ✅       | ✅       |
| 83  | 04.3    | Threat Intelligence               | 4:46     | threat feeds, indicators, IOC          | ✅        | ✅       |
| 84  | 04.3    | Penetration Testing               | 6:21     | red team, exploit simulation           | ✅        | ✅       |
| 85  | 04.3    | Analyzing Vulnerabilities         | 10:29    | CVSS, false positives, context         | ✅        | ✅       |
| 86  | 04.3    | Vulnerability Remediation         | 8:45     | patching, mitigation, acceptance       | ✅        | ✅       |
| 87  | 04.4    | Security Monitoring               | 10:27    | log analysis, SIEM, alerting           | ✅        | ✅       |
| 88  | 04.4    | Security Tools                    | 14:06    | Nmap, Wireshark, forensic tools        | ✅        | ✅       |

| 89  | 04.5    | Firewalls                         | 11:31    | stateless, stateful, NGFW              | ☐       | ☐          |
| 90  | 04.5    | Web Filtering                     | 10:00    | URL filtering, DNS filtering           | ☐       | ☐          |
| 91  | 04.5    | Operating System Security         | 3:22     | patching, access control, secure boot  | ☐       | ☐          |
| 92  | 04.5    | Secure Protocols                  | 4:47     | HTTPS, SSH, SFTP                       | ☐       | ☐          |
| 93  | 04.5    | Email Security                    | 7:05     | SPF, DKIM, anti-spam/anti-phishing     | ☐       | ☐          |
| 94  | 04.5    | Monitoring Data                   | 7:25     | DLP, audit logs, alerts                | ☐       | ☐          |
| 95  | 04.5    | Endpoint Security                 | 9:25     | antivirus, EDR, device control         | ☐       | ☐          |
| 96  | 04.6    | Identity and Access Management    | 12:46    | SSO, federation, lifecycle             | ☐       | ☐          |
| 97  | 04.6    | Access Controls                   | 7:49     | DAC, MAC, RBAC                         | ☐       | ☐          |
| 98  | 04.6    | Multifactor Authentication        | 4:30     | tokens, biometrics, TOTP               | ☐       | ☐          |
| 99  | 04.6    | Password Security                 | 6:22     | complexity, rotation, storage          | ☐       | ☐          |

| No. | Section | Topic                             | Duration | Keywords                               | Watched | TIL Logged |
|-----|---------|-----------------------------------|----------|----------------------------------------|---------|------------|
| 100 | 04.7    | Scripting and Automation          | 8:20     | Python, PowerShell, APIs               | ☐       | ☐          |
| 101 | 04.8    | Incident Response                 | 9:14     | IR process, preparation, containment   | ☐       | ☐          |
| 102 | 04.8    | Incident Planning                 | 6:50     | roles, playbooks, communication        | ☐       | ☐          |
| 103 | 04.8    | Digital Forensics                 | 9:54     | chain of custody, imaging              | ☐       | ☐          |
| 104 | 04.9    | Log Data                          | 13:41    | log sources, SIEM, event correlation   | ☐       | ☐          |
| 105 | 05.1    | Security Policies                 | 11:02    | AUP, onboarding, offboarding           | ☐       | ☐          |
| 106 | 05.1    | Security Standards                | 5:36     | ISO, NIST, PCI-DSS                     | ☐       | ☐          |
| 107 | 05.1    | Security Procedures               | 7:02     | SOPs, best practices                   | ☐       | ☐          |
| 108 | 05.1    | Security Considerations           | 4:52     | data handling, access restrictions     | ☐       | ☐          |
| 109 | 05.1    | Data Roles and Responsibilities   | 2:27     | owner, steward, custodian, user        | ☐       | ☐          |
| 110 | 05.2    | Risk Management                   | 3:30     | risk types, framework overview         | ☐       | ☐          |
| 111 | 05.2    | Risk Analysis                     | 9:13     | quantitative, qualitative, likelihood  | ☐       | ☐          |
| 112 | 05.2    | Risk Management Strategies        | 3:12     | avoid, transfer, accept, mitigate      | ☐       | ☐          |
| 113 | 05.2    | Business Impact Analysis          | 2:55     | RTO, RPO, critical assets              | ☐       | ☐          |
| 114 | 05.3    | Third-party Risk Assessment       | 11:36    | vendor risk, due diligence             | ☐       | ☐          |
| 115 | 05.3    | Agreement Types                   | 5:19     | SLA, MOU, NDA                          | ☐       | ☐          |
| 116 | 05.4    | Compliance                        | 8:06     | regulatory, industry, internal         | ☐       | ☐          |
| 117 | 05.4    | Privacy                           | 5:22     | GDPR, CCPA, data protection            | ☐       | ☐          |
| 118 | 05.5    | Audits and Assessments            | 2:49     | internal, external, risk assessment    | ☐       | ☐          |
| 119 | 05.5    | Penetration Tests                 | 5:29     | white/black/gray box, scope            | ☐       | ☐          |
| 120 | 05.6    | Security Awareness                | 6:45     | phishing training, policy education    | ☐       | ☐          |
| 121 | 05.6    | User Training                     | 4:31     | role-based, onboarding, ongoing        | ☐       | ☐          |






# 🎧 英語講義ハック法（ADHD × 非ネイティブ向け）

英語の動画講義を「全部聞こう」とすると、ADHD脳も非ネイティブ脳もすぐに折れてしまう。  
そこで、静かに・短時間で・確実に吸収するための Boo式ハックを記録しておく。

---

## ✅ Boo式ハック4ステップ

### ① 🎯 目的を決める（全理解しない）

- 「今日は“CIA Triad”を拾えたらOK」
- 「“Threat Actor”の定義だけわかればいい」
- → 小さな目標 × 完了感 × 成功体験

---

### ② ⏩ 倍速再生 × 聞き流すモード

- 1.25x 〜 1.5x 推奨（退屈防止・脳にとって自然）
- 理解しようとしない → 聞き取れた部分だけ拾えばOK
- それが「自分に今必要な知識」＝脳が選んだもの

---

### ③ 📋 見ながら書かない → 一周してから記録

- ADHDにはマルチタスク記録は負担
- まず流し見 → 終わったら“記憶に残った1点”を書く

---

### ④ ✍️ TILに「1フレーズだけ」英語で書く

- 例：
  - *Confidentiality means protecting info from unauthorized access.*
  - *Threat actors include nation-states and script kiddies.*

---

## 🧠 補助ツール（必要に応じて）

| ツール名              | 目的                           |
|------------------------|--------------------------------|
| YouTube英語字幕         | リズム補助・視覚補完               |
| Language Reactor（Chrome拡張） | 英語＋日本語対訳／精読に使える       |
| ChatGPT              | 英語要約・要点抽出・日本語訳支援       |

---

## 🎯 大前提マインドセット

> 「全部聞き取る必要はない。ひとつ拾えたらそれが今日の成果」  
> 「流す × 残す × 積み上げる」が最強のQuiet戦術。




## 🎯 学習フェーズごとの利用ツール

| 項目                  | 内容                                           |
| ------------------- | -------------------------------------------- |
| 📱 **GoodNotesの強み** | 自由なスクショ、マークアップ、非公開OK → 超高速学習が可能（過去に資格取得成功）   |
| 🌍 **TILの目的**       | 公開前提・再利用・構造化・ストック型アウトプット                     |
| ❓ **現在の悩み**         | 「GoodNotesの自由度」と「TILの公開性」の間で、どちらを主軸にするか悩んでいる |
| 💡 **仮説**           | 問題演習以降にGoodNotesを再登場させるのが良い？                 |

---

## ✅ 結論：**フェーズごとに分担して使う戦略が最適**

### 🧪【フェーズ1：インプット＆動画視聴】

* **TIL中心**

  * 要点まとめ／英語フレーズ／一日一振り返り
  * 公開前提で「他人が見てもわかる」＝後で自分も助かる
* **GoodNotesは控えめ**（スクショしたい時だけ）

---

### 📝【フェーズ2：問題演習〜反復アウトプット】

* **GoodNotes全開放**

  * 問題文・選択肢・解説のスクショ → 手書きで記憶補強
  * 自分専用＝思いっきりマーク、殴り書きOK
  * ADHDフレンドリーな「没入用キャンバス」として使う

---

### 📚【フェーズ3：復習＆発信】

* GoodNotesでの記録をTIL化（清書して公開用に）
* 「自分だけの解き方」や「重要語彙リスト」をブログやノートに

---

## 🧠 ポイント

* 「TILで整える → GoodNotesで暴れる」使い分けが◎
* ADHD傾向がある人には、「制約のある場（TIL）」と「無制限の場（GoodNotes）」を**明確に分ける**のが効果的です

---




