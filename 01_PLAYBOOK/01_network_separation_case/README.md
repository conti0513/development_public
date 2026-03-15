# Network Separation Case
（カーブアウトにおけるネットワーク分離プレイブック）

---

# Overview

本ドキュメントは、**企業カーブアウト（事業分離）プロジェクトにおけるネットワーク分離の一般的なパターン**を整理したものである。

企業の一部事業が独立会社として分離される場合、ITインフラも親会社環境から分離する必要がある。  
その中でもネットワークは多くのシステムの基盤となるため、**初期フェーズで整理が必要となる重要領域**である。

本Playbookでは、ネットワーク分離プロジェクトの典型的な構造と実務タスクを整理する。

---

# 想定プロジェクト

ネットワーク分離は主に以下のケースで発生する。

- カーブアウト（事業分離）
- スピンオフ（独立会社化）
- M&Aによる事業売却
- 組織再編によるIT分離

典型的な既存構造

```

親会社ネットワーク
├ 本社
├ 拠点
├ クラウド
└ 共通サービス

```

この環境から新会社ネットワークを構築する必要がある。

---

# Target Architecture（概念）

```

新会社ネットワーク

Internet
│
Firewall
│
Core Network
├ Office Network
├ Site Network
├ WAN
└ Cloud Connectivity

```

設計では以下を考慮する。

- 独立運用
- セキュリティ境界
- 可用性
- 拡張性
- 法規制対応

---

# PMBOKベースの作業構造

本PlaybookではPMBOKプロセス群を参考に整理する。

```

Initiating
Planning
Executing
Monitoring & Controlling
Closing

```

---

# 1 Initiating（立ち上げ）

プロジェクト理解と初期情報収集。

## 実施内容

- PJT目的確認
- 分離スコープ確認
- 分離期限確認
- TSA期間確認
- ステークホルダー整理

## 作成物

```

project_overview.md
stakeholder_map.md
document_inventory.md

```

---

# 2 Planning（計画）

既存環境の把握と設計準備。

## ネットワーク棚卸

確認対象

- WAN構成
- 回線契約
- IPアドレス設計
- Firewallルール
- ルーティング
- クラウド接続

## 作成物

```

As-Is Network Diagram
Circuit Inventory
IP Address List

```

---

# 3 Executing（実行）

依存関係整理と分離設計。

## 実施内容

- システム依存関係整理
- TSA対象サービス整理
- 分離アーキテクチャ検討

## 作成物

```

Dependency Map
TSA Service List
To-Be Network Draft

```

---

# 4 Monitoring & Controlling（監視・管理）

リスク・課題管理。

## 実施内容

- NWリスク整理
- 課題管理
- 設計判断ログ

## 管理表

```

Issue Register
Risk Register
Decision Log

```

---

# 5 Closing（終了）

プロジェクト終了時の整理。

## 実施内容

- 最終構成図整理
- TSA終了確認
- Lessons Learned整理

## 作成物

```

Final Network Diagram
Lessons Learned
Operations Handover

```

---

# Network Separation WBS（例）

ネットワーク分離の典型的WBS。

| WBS | タスク | 内容 |
|----|------|------|
| 1 | プロジェクト理解 | スコープ確認 |
| 1.1 | ステークホルダー整理 | IT / NW / ベンダー |
| 1.2 | ドキュメント収集 | NW図 / 回線 / IP |

| WBS | タスク | 内容 |
|----|------|------|
| 2 | 現行NW調査 | As-Is整理 |
| 2.1 | NW構成図作成 | 現行ネットワーク |
| 2.2 | 回線棚卸 | Circuit Inventory |
| 2.3 | IP整理 | Address Plan |
| 2.4 | FWルール確認 | Policy整理 |

| WBS | タスク | 内容 |
|----|------|------|
| 3 | 依存関係整理 | システム依存 |
| 3.1 | AD依存 | 認証 |
| 3.2 | DNS依存 | 名前解決 |
| 3.3 | Proxy依存 | 外部通信 |
| 3.4 | Cloud接続 | VPN / Private Link |

| WBS | タスク | 内容 |
|----|------|------|
| 4 | 分離設計 | To-Be設計 |
| 4.1 | WAN設計 | 拠点接続 |
| 4.2 | Firewall設計 | セグメント |
| 4.3 | IP再設計 | 重複回避 |
| 4.4 | TSA設計 | 一時接続 |

| WBS | タスク | 内容 |
|----|------|------|
| 5 | 移行計画 | カットオーバー |
| 5.1 | 回線切替 | Carrier作業 |
| 5.2 | FW変更 | Policy変更 |
| 5.3 | DNS変更 | 名前解決 |
| 5.4 | 動作確認 | 通信テスト |

---

# カーブアウト案件：参画〜1ヶ月（NW担当）

## Week 1

実施

- PJT概要理解
- ステークホルダー把握
- ドキュメント収集

作成物

```

project_overview.md
document_inventory.md

```

---

## Week 2

既存NW把握

作成物

```

As-Is Network Diagram
Circuit Inventory
IP Address List

```

---

## Week 3

依存関係整理

作成物

```

Dependency Map
TSA Service List

```

---

## Week 4

初期設計・リスク整理

作成物

```

To-Be Network Draft
Network Risk List

```

---

# Minimum Deliverables（1ヶ月）

```

As-Is Network Diagram
Circuit Inventory
IP Address List
Dependency Map
TSA Service List
Network Risk List

```

---

# Common Risks

ネットワーク分離案件では以下が頻出。

- 回線契約不明
- NW構成図未整備
- Firewallルールブラックボックス
- DNS依存
- Cloud接続依存
- 拠点ネットワーク依存

---

# Lessons Learned

多くのカーブアウト案件では以下が課題となる。

- ネットワーク情報不足
- 回線契約整理の遅延
- Firewallルール肥大化
- TSA長期化

重要ポイント

- 早期棚卸
- Decision Log
- TSA Exit Plan
```

---

# ① Issue Register

`issue_register.md`

```md
# Issue Register

| ID | Issue | 影響範囲 | 優先度 | 担当 | ステータス | 対応内容 | 更新日 |
|----|------|---------|-------|------|-----------|---------|--------|
| I-001 | 回線契約不明 | 拠点NW | High | NW Team | Open | 契約確認中 | YYYY-MM-DD |
| I-002 | FWルール不明 | DC | Medium | Security | Open | ログ解析予定 | YYYY-MM-DD |
```

---

# ② Risk Register

`risk_register.md`

```md
# Risk Register

| ID | Risk | 発生確率 | 影響 | 対応策 | 担当 | ステータス |
|----|------|----------|------|--------|------|------------|
| R-001 | IPアドレス重複 | Medium | High | IP再設計検討 | NW Team | Monitoring |
| R-002 | 回線名義変更遅延 | Medium | Medium | 新回線検討 | Infra Team | Open |
```

---

# ③ Decision Log

`decision_log.md`

```md
# Decision Log

| ID | 日付 | Decision | 背景 | 影響 | 承認 |
|----|------|----------|------|------|------|
| D-001 | YYYY-MM-DD | 新会社WANはSD-WAN採用 | 拠点増加対応 | WAN構成変更 | Architecture Board |
| D-002 | YYYY-MM-DD | TSA接続はFW経由 | セキュリティ要件 | Firewall追加 | Security Team |
```

---

# ④ Deliverables List

`deliverables.md`

```md
# Deliverables

| Deliverable | 内容 | 担当 | 期限 | ステータス |
|-------------|------|------|------|------------|
| As-Is Network Diagram | 現行NW構成図 | NW Team | YYYY-MM-DD | In Progress |
| Circuit Inventory | 回線一覧 | Infra | YYYY-MM-DD | Open |
| Dependency Map | 依存関係整理 | Architecture | YYYY-MM-DD | Open |
| TSA Service List | TSA対象 | PMO | YYYY-MM-DD | Open |
```

---

# ⑤ Network Inventory

`network_inventory.md`

```md
# Network Inventory

| 拠点 | ネットワーク | IP Range | VLAN | 用途 |
|------|-------------|---------|------|------|
| HQ | Core Network | 10.0.0.0/16 | 10 | Office |
| Site-A | Site Network | 10.1.0.0/16 | 20 | Office |
| Cloud | VPC | 10.10.0.0/16 | - | Cloud |
```

---

# ⑥ Project Overview

`project_overview.md`

```md
# Project Overview

## Project
Network Separation Project

## Objective
親会社ネットワークから新会社ネットワークを分離する。

## Scope
- Network
- Firewall
- WAN
- Cloud Connectivity

## Timeline
YYYY-MM → YYYY-MM

## Stakeholders
- PM
- Network Team
- Security Team
- Infrastructure Team
```

---

# ⑦ Document Inventory

`document_inventory.md`

```md
# Document Inventory

| Document | 内容 | 所在 | ステータス |
|---------|------|------|------------|
| Network Diagram | 現行NW構成図 | SharePoint | Draft |
| Circuit List | 回線一覧 | Excel | In Progress |
| Firewall Policy | FWルール | Firewall | Unknown |
```

---

# PMBOKで使う管理表まとめ

```
Issue Register
Risk Register
Decision Log
Deliverables List
Network Inventory
Project Overview
Document Inventory
```

---

