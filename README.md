# Tech Inventory & Logs

インフラの構造化と、運用プロセスの記録。

---

### Implementation Archives

サーバーレス基盤の構築から、現場の負債を解消する自動化まで。

#### 1. [Cloud Run / Secure Egress](https://github.com/conti0513/development_public/tree/main/devops_notes/serverless-ftps-api-public)

```mermaid
graph LR
    subgraph VPC
        direction LR
        CR[Cloud Run] --> SVC[VPC Connector]
        SVC --> NAT[Cloud NAT]
    end
    NAT -->|Static IP| Ext[External]

    style CR fill:#f0f7ff,stroke:#004a99,stroke-width:1px
    style NAT fill:#fffdeb,stroke:#857000,stroke-width:1px
    style SVC fill:#f5f5f5,stroke:#333,stroke-width:1px
    style VPC fill:#fafafa,stroke:#eee,stroke-dasharray: 5 5

```

#### 2. [GWS / Slack Automation](https://github.com/conti0513/development_public/tree/main/project_examples/daily-sheet-to-slack)

```mermaid
graph LR
    SS[Google Sheets] --> GAS[Apps Script] --> SL[Slack]
    GWS[GWS API] <--> Py[Python Script]
    
    style SS fill:#f6ffed,stroke:#237804,stroke-width:1px
    style GAS fill:#f6ffed,stroke:#237804,stroke-width:1px
    style Py fill:#f6ffed,stroke:#237804,stroke-width:1px
    style SL fill:#fff7e6,stroke:#d46b08,stroke-width:1px

```

#### 3. [Windows Setup Automation](https://github.com/conti0513/development_public/tree/main/project_examples/windows_setup_automation)

```mermaid
graph LR
    Win[Raw Windows OS] --> PS[PowerShell]
    PS --> Pol[Policy / Apps / Config]
    
    style Win fill:#f0f7ff,stroke:#004a99,stroke-width:1px
    style PS fill:#f5f5f5,stroke:#333,stroke-width:1px
    style Pol fill:#fff7e6,stroke:#d46b08,stroke-width:1px

```

---

### Stacks

* **Infrastructure:** Google Cloud, AWS, Entra ID, M365 (Intune)
* **Governance:** ITGC Compliance, Identity Management
* **Automation:** Python, PowerShell, GAS, LLM Orchestration

---

### Contents

* **[TIL](https://www.google.com/search?q=./TIL/)** : 2025- / 技術的な試行錯誤の軌跡
* **[DevOps Notes](https://www.google.com/search?q=./devops_notes/)** : Cloud, Security, Automation, IaC
* **[Project Examples](https://www.google.com/search?q=./project_examples/)** : 実装プロトタイプ

---

### Profile

20年余のインフラ経験。通信キャリアのNW設計から、大規模組織のID基盤運用、スタートアップの自動化まで。

「技術を、一過性の作業ではなく、再利用可能な構造として残すこと」を旨とする。

---
