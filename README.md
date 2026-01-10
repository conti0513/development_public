# Tech Inventory & Logs

インフラの構造化と、運用プロセスの記録。

---

### Cloud Run / Secure Egress

```mermaid
graph LR
    subgraph VPC
        direction LR
        CR[Cloud Run] --> SVC[VPC Connector]
        SVC --> NAT[Cloud NAT]
    end
    NAT -->|Static IP| Ext[External]

    style CR fill:#fff,stroke:#333
    style NAT fill:#fff,stroke:#333
    style VPC fill:#fafafa,stroke:#eee

```

### Stacks

* **Infrastructure:** Google Cloud, AWS, Entra ID, M365 (Intune)
* **Governance:** ITGC Compliance, Identity Management
* **Automation:** Python, PowerShell, GAS, LLM Orchestration

---

### Contents

* **[TIL](https://github.com/conti0513/development_public/tree/main/TIL)** : 2025- / 技術的な試行錯誤の軌跡
* **[DevOps Notes](https://github.com/conti0513/development_public/tree/main/devops_notes)** : Cloud, Security, Automation, IaC
* **[Project Examples](https://github.com/conti0513/development_public/tree/main/project_examples)** : 実装プロトタイプ

---

### Profile

20年余のインフラ経験。通信キャリアのNW設計から、大規模組織のID基盤運用、スタートアップの自動化まで。

「技術を、一過性の作業ではなく、再利用可能な構造として残すこと」を旨とする。

---
