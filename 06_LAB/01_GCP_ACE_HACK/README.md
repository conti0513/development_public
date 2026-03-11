```markdown
# Google Cloud ACE Study Notes (2026)

このディレクトリは  
**Google Cloud Associate Cloud Engineer (ACE)** 試験対策のための  
コンパクトな学習ノートです。

目的は以下の3点です。

- 試験範囲の整理
- サービス選択の理解
- 試験トラップの把握

内容は **試験対策＋実務寄りの整理**として作成しています。

---

# ディレクトリ構成

```

sessions_ver262

01_overview.md
02_iam.md
03_compute.md
04_storage.md
05_database.md
06_networking.md
07_serverless.md
08_operations.md
09_cost.md
10_security.md
11_service_selection.md
12_exam_traps.md
13_mock_exam_1.md
14_mock_exam_2.md
15_mock_exam_3.md

```

---

# 学習の進め方

推奨順序

```

1. 基礎サービス理解
   01〜08

2. 運用・コスト・セキュリティ
   09〜10

3. サービス選択
   11

4. 試験トラップ
   12

5. 模擬問題
   13〜15

```

ACE試験では

```

サービス選択

```

が最も重要です。

---

# ACE試験の特徴

試験は

```

知識問題
ではなく

サービス選択問題

```

です。

基本的な解き方

```

要件
↓
キーワード
↓
GCPサービス

```

例

```

PostgreSQL
→ Cloud SQL

Docker container
→ Cloud Run

ログ分析
→ BigQuery

```

---

# 重要サービス

ACEで頻出

```

Compute Engine
Cloud Run
Cloud Storage
Cloud SQL
BigQuery
Pub/Sub
Secret Manager
IAM
Cloud Monitoring

```

---

# 試験トラップ

よくある誤答

```

PostgreSQL → Spanner ❌
正解 → Cloud SQL

ログ分析 → Logging ❌
正解 → BigQuery

Container API → Compute Engine ❌
正解 → Cloud Run

```

詳細は

```

12_exam_traps.md

```

参照。

---

# 対象試験

Google Cloud

```

Associate Cloud Engineer

```

試験コード

```

ACE

```

---

# 想定読者

- GCP初学者
- インフラエンジニア
- DevOpsエンジニア
- クラウド学習者

---

# 注意

このノートは

```

試験対策用まとめ

```

です。

最新仕様は公式ドキュメントを参照してください。

https://cloud.google.com/docs

---

# License

Personal study notes.
```

---

