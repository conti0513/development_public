# Tech Inventory & Logs

インフラの構造化と、運用プロセスの記録。

---


### 実装アーカイブ：インフラ構築と自動化

サーバーレス基盤の構築から、現場の負債を解消する自動化ツールまで、実務に即した構成を記録しています。

#### 1. [Cloud Run / Secure Egress](https://github.com/conti0513/development_public/tree/main/devops_notes/serverless-ftps-api-public)

```mermaid
graph LR
    subgraph VPC
        direction LR
        CR[Cloud Run] --> SVC[VPC Connector]
        SVC --> NAT[Cloud NAT]
    end
    NAT -->|Static IP| Ext[External]

    style CR fill:#e1f5fe,stroke:#01579b
    style NAT fill:#fff9c4,stroke:#fbc02d
    style SVC fill:#f5f5f5,stroke:#333
    style VPC fill:#fafafa,stroke:#eee

```

#### 2. [Google Workspace / Slack Automation](https://github.com/conti0513/development_public/tree/main/project_examples/daily-sheet-to-slack)

```mermaid
graph LR
    SS[Google Sheets] --> GAS[Apps Script] --> SL[Slack]
    GWS[GWS API] <--> Py[Python Script]
    
    style SS fill:#e8f5e9,stroke:#2e7d32
    style GAS fill:#e8f5e9,stroke:#2e7d32
    style Py fill:#e8f5e9,stroke:#2e7d32
    style SL fill:#fff3e0,stroke:#e65100

```

#### 3. [Windows Setup Automation](https://github.com/conti0513/development_public/tree/main/project_examples/windows_setup_automation)

```mermaid
graph LR
    Win[Raw Windows OS] --> PS[PowerShell]
    PS --> Pol[Policy / Apps / Config]
    
    style Win fill:#e1f5fe,stroke:#01579b
    style PS fill:#f5f5f5,stroke:#333
    style Pol fill:#fff3e0,stroke:#e65100

```

---


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
