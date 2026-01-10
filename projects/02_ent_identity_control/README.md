# Case Study 02: 大規模エンタープライズにおけるID統制と運用管理

### 📌 プロジェクトの背景

* **Domain:** 国内最大手製造業（大手製造業）
* **Context:** 数万人規模の組織における、厳格なガバナンス下でのID運用。
* **Approach:** 徹底された統制環境（スクリプト制限下）において、標準機能と論理的な手順管理のみで「不備ゼロ」の運用を確立。

### 🏗 構造化のアーキテクチャ

規律を重んじる環境での経験が、現在のセキュアな自動化設計の「規律」となっていることを視覚化。

```mermaid
graph TD
    subgraph Governance [統制レイヤー]
        Policy[運用規程/ITGC] --> Workflow[標準ワークフロー/ServiceNow]
    end

    subgraph Operation [技術レイヤー]
        Workflow --> Tool[標準機能/Excelマクロ]
        Tool --> Directory[ID基盤/ディレクトリサービス]
    end

    subgraph Evidence [証跡管理]
        Directory --> Log[監査ログ自動抽出]
        Log --> Archive[不変証跡ストレージ]
    end

    style Directory fill:#f0f7ff,stroke:#004a99,stroke-width:1px
    style Log fill:#f6ffed,stroke:#237804,stroke-width:1px
    style Workflow fill:#fff7e6,stroke:#d46b08,stroke-width:1px
    style Policy fill:#f5f5f5,stroke:#333,stroke-width:1px

```

### 🎯 運用の要諦

* **制約下の最適化:** 独自ツールの使用が制限される中で、既存アセットを組み合わせて「誰がやっても同じ結果が出る」構造を構築。
* **証跡の自律性:** 監査時に慌てることのないよう、日々の運用ログが自動的にアーカイブされる仕組みを重視。

---
