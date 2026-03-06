# SQL / Data Pipeline Experience
（匿名化プロジェクト整理）

本ドキュメントでは、SQLおよびデータ処理に関する実務経験を  
匿名化したプロジェクト形式で整理しています。

SQL単体の開発というより、

```

データ収集
↓
データ抽出（SQL）
↓
データ整形
↓
外部連携

```

といった **データパイプライン構築・運用**の経験が中心です。

---

# Project A
SQL監視・障害検知システム

## 概要

SQLサーバーの運用監視において  
SQLエラーや処理停止を検知する監視システムの構築・運用を担当。

障害検知後はアラートを発報し、  
運用チームへ通知する仕組みを実装しました。

## 担当領域

- SQLログ解析
- 障害検知処理
- Shellによる監視処理
- アラート通知フロー構築

## アーキテクチャ

```

SQL Server
│
│ Log / Error
▼
Monitoring Script (Shell)
│
│ SQL解析
▼
Alert System
│
▼
Operations Team

```

## 技術

- SQL
- Shell Script
- Linux
- 運用監視

---

# Project B
ユーザーデータ分析・抽出

## 概要

ユーザー管理データベースに対して  
SQLを用いたデータ抽出・集計を実施。

業務の進捗管理やデータ分析に利用しました。

## 利用用途

- 回線構築進捗管理
- ユーザーデータ抽出
- 簡易データ分析

## アーキテクチャ

```

User Database
│
▼
SQL Query
│
▼
Microsoft Access
│
▼
Analysis / Reporting

```

## 技術

- SQL
- Microsoft Access
- データ抽出
- データ分析

---

# Project C
Redmine環境構築（MySQL）

## 概要

Redmineを利用したプロジェクト管理基盤を  
内製で構築。

アプリケーションサーバーおよび  
MySQLデータベースの構築を担当しました。

## 担当領域

- MySQLサーバー構築
- Redmine環境構築
- DB接続設定
- 運用管理

## アーキテクチャ

```

Users
│
▼
Redmine (Ruby on Rails)
│
▼
MySQL Database
│
▼
Linux Server

```

## 技術

- MySQL
- Ruby on Rails
- Linux
- ミドルウェア構築

---

# Project D
BigQueryデータ連携基盤

## 概要

クラウド上のデータ分析基盤として  
BigQueryを利用したデータ処理パイプラインを構築。

SQLで抽出したデータを  
外部システムへ自動連携する仕組みを実装しました。

## ビジネス課題

従来のデータ連携は

```

手動エクスポート
↓
ローカル保存
↓
共有フォルダ
↓
外部システム処理

```

という **手動運用**でした。

このため

- 作業ミス
- 運用負荷
- 処理遅延

の問題がありました。

---

## 改善アーキテクチャ

クラウド上で完結する  
**イベント駆動データ連携基盤**を構築しました。

```

BigQuery
│
│ Scheduled Query
▼
Google Cloud Storage
│
│ Event Trigger
▼
Cloud Function / Cloud Run
│
│ Data Transform
▼
FTPS Transfer
│
▼
Legacy Server

```

---

## データ処理フロー

```

BigQuery
↓
SQL抽出
↓
CSV生成
↓
GCS保存
↓
イベント発火
↓
Python / Go処理
↓
文字コード変換
↓
FTPS転送

```

---

## 実装内容

- BigQueryスケジュールクエリ
- データ抽出SQL
- Python / Goによるデータ整形
- 文字コード変換（UTF-8 → Shift-JIS）
- GCSイベントトリガー
- FTPS自動転送

---

## 技術

- BigQuery
- SQL
- Python
- Go
- Cloud Functions / Cloud Run
- GCS
- Event-driven architecture

---

# 技術的な特徴

これらのプロジェクトでは

```

SQL
↓
データ抽出
↓
イベント処理
↓
データ連携

```

といった **データパイプライン設計**に関わってきました。

SQL単体ではなく、

```

Data
↓
Cloud
↓
Automation

```

という形で **クラウドデータ処理基盤**を扱っています。
```

---

