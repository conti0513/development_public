# 技術検討ログ：オンプレ前提 GCPデータ基盤（設計メモ）

## 0. Overview（3行）
オンプレミス上の業務データを起点に、Google Cloud 上でセキュアかつ信頼性の高いデータ基盤を構築・運用する前提を整理する。  
目的は「構築」ではなく「止まらず・壊れず・属人化しない運用が回る」状態の実現。  
本メモは、案件要件の実像（課題・構造・AS-IS/TO-BE・差分）を言語化し、学習/準備の基準点とする。

---

## 1. 想定課題（Problem Statement）
オンプレミス環境に存在する事業データをもとに、Google Cloud 上に **セキュアで信頼性が高く、自動化されたデータ基盤** を構築する。  
単なるデータ格納ではなく、以下を同時に満たすことが求められる。

- 継続運用が可能（運用フェーズを前提）
- 手動作業に依存しない（自動化・再現性）
- 失敗時に検知・復旧できる（再実行性・可観測性）
- 属人化しない（コード/ドキュメントで明文化）

---

## 2. 前提（Constraints / Non-negotiables）
- データの一次生成元はオンプレミス
- 業務データのため停止・欠損が許されない
- セキュリティ・権限分離を初期から設計する
- 手作業運用はスケールしない（自動化前提）
- 責任境界（オンプレ ↔ クラウド）を曖昧にしない

---

## 3. 全体構造（High-level Architecture）
### 3.1 データフロー俯瞰（Mermaid）
```mermaid
flowchart LR
    A[On-Premises Data] -->|Secure Transfer| B[Cloud Storage]
    B --> C[ETL / Workflow]
    C --> D[BigQuery]
    D --> E[Downstream / Analytics]

    subgraph GCP
        B
        C
        D
    end

    C --> F[Monitoring / Alerting]
    D --> F
````

### 3.2 構成要素（役割）

* Cloud Storage：生データ/中間データの置き場、再処理の起点
* ETL / Workflow：取り込み・変換・依存関係管理（定期実行の心臓部）
* BigQuery：加工・集計・分析の中心（コスト/性能設計が重要）
* CI/CD：変更の自動反映（人が手で回さない）
* Monitoring：失敗検知・アラート・再実行判断（運用負荷を下げる）

---

## 4. AS-IS / TO-BE（想定現状と目指す姿）

### 4.1 AS-IS（想定される現状）

* オンプレ側に業務データが存在
* 連携が手動/属人的、または運用が部分的に暗黙知
* 障害時の検知・再実行・原因追跡が弱い
* 環境構築や設定が人依存（再現性が低い）
* 手順書/構成が分散し、運用引継ぎが難しい

### 4.2 TO-BE（目指す姿）

* オンプレ ↔ クラウドの責任境界が明確
* 取り込み〜加工までが自動化されている
* 失敗時に検知でき、再実行・復旧が可能
* 構成・手順がコードとドキュメントで管理されている
* 人が張り付かなくても回る（運用負荷が低い）

---

## 5. 運用前提の設計ポイント（SRE的観点）

* 再実行性：途中失敗しても安全にやり直せる（冪等性、二重取り込み防止）
* 失敗耐性：失敗を前提に、検知・リトライ・保留ができる
* 可観測性：ログ/メトリクス/アラートで状況が追える
* 権限分離：アクセス権、責任範囲、監査を初期設計する
* 明文化：構成・手順・判断基準を文章で残す

---

## 6. 技術要素の整理（用語・役割）

### Ansible

サーバー/実行環境の状態を揃える。手作業の設定差分を減らし、再現性を担保する。

### Jenkins（CI/CD）

ETL定義や構成変更を自動反映する仕組み。人が実行ボタンを押さない前提を作る。

### embulk

データ取り込み（ETL）のためのツール。オンプレや外部ソースからのデータ投入で利用されることがある。

### Digdag

ワークフロー/依存関係を管理し、ジョブをスケジューリングして回す。バッチ運用の制御面を担う。

### BigQuery

分析・集計の中核。SQLで扱えるが、RDBと同じ感覚ではなく、コスト/性能を意識した設計が重要。

### IaC（Infrastructure as Code）

インフラ構成をコードで管理し、再現性・レビュー可能性・属人性排除を実現する考え方/手法。

---

## 7. 自分の技術スタックとの照合（Fit / Gap）

### 7.1 活かせる点（現時点の強み）

* Linux 前提の運用・設計思考
* Docker / IaC / CI/CD の概念理解・実務経験
* オンプレ ↔ クラウドの責任境界を意識した設計
* 監視・改善を前提とした運用視点（SRE文脈）
* 「構築より運用」を重視する設計思想

### 7.2 足りない/弱い点（差分）

* BigQuery 特有の設計・クエリ最適化（実務量）
* ETL/ワークフロー（embulk/Digdag/Airflow等）の本番運用経験
* 冪等性・データ品質・再実行設計の実体験（データ基盤特化領域）
* データ基盤の運用で発生する障害パターンの経験値（回して学ぶ部分）

---

## 8. 位置付け（このメモの結論）

本案件は「今すぐ取る/取らない」の判断材料というより、
データ基盤エンジニア像（運用前提・自動化・可観測性）を具体化するための基準点として扱う。
現時点では、思想・前提理解は到達している一方、データ基盤特化の実務量が差分となる。

---

## 9. 次アクション（実装なし前提の準備）

* 本メモを「差分スキルの棚卸し」として保持（更新して育てる）
* 必要になったタイミングで `projects/` 配下に実装用ディレクトリを新設する
* TILには本メモへのリンクのみ貼る（本文肥大化を避ける）


## 10. 技術用語メモ  
## ETL × BigQuery 学習メモ  
### AS-IS / TO-BE 構造整理（現場ベース）

---

### 1. AS-IS（現状構造）

#### 背景
- ETLという概念設計がないまま、場当たり的に実装が進行
- データ元（POS）のカラム構成が、基幹システム要件を満たしていない
- 手動転送（WinSCP等）を起点とした運用が存在し、構成がスパゲッティ化
- 失敗検知・再実行・責任境界が曖昧な状態で運用が継続

---

#### 現行フロー（AS-IS）

##### データ取り込み〜整形（分析 / Queryエンジニア担当）
- POS（Windows）
  - ローデータ（基幹要件未達）
  - スケジュール実行で GCP コマンドを起動
- GCS（箱1）
  - 生データを一時保管（Raw / Staging）
- BigQuery
  - 要件を満たすようにデータ整形（カラム調整・型補正など）
- GCS（箱2）
  - 整形済みデータを出力（UTF-8）

---

##### 配送・変換（自分が担当）
- GCS（箱2）への PUT をトリガに Cloud Run が発火
- UTF-8 → SJIS へ文字コード変換（Transform）
- ログ・メタ情報を GCS（箱3）へ保存
- セキュアに基幹システムへ転送（SFTP / FTPS）

---

#### AS-IS の課題
- 各工程の責任境界が明文化されていない
- データの正（Source of Truth）が不明確
- 失敗時の再実行・二重送信防止ルールがない
- ログや処理履歴が分散し、追跡性が低い
- ETL全体像を説明できるドキュメントが存在しない

---

### 2. TO-BE（目指す構造）

#### 基本方針
- ETLを「処理の集合」ではなく「運用前提の構造」として再定義
- データの流れを **ゾーン（箱）単位** で分離し、責任境界を明確化
- Transform を段階分離し、役割を整理
- 自動化・再実行・可観測性を前提に設計する

---

#### TO-BE フロー（概念整理）

##### ゾーン定義
- GCS 箱1（Raw / Staging）
  - 原本保管・再処理起点
  - 加工しない、触らない
- BigQuery（Curated）
  - 業務要件を満たす形への整形・正規化
- GCS 箱2（Delivery）
  - 外部連携向け成果物（UTF-8）
- GCS 箱3（Ops）
  - ログ・メタ・再実行情報の集約

---

##### Transform の分離
- Transform①（BigQuery）
  - カラム構成調整
  - 型変換・欠損補完
  - 業務要件への適合
- Transform②（Cloud Run）
  - 文字コード変換（UTF-8 → SJIS）
  - 外部システム制約への適応
  - 配送前の最終加工

---

#### ETL全体構造（TO-BE）

```mermaid
flowchart TB
  subgraph OnPrem
    POS[POS Windows\nRaw Data (要件未達)]
    SCH[Scheduler\n(gcloud command)]
  end

  subgraph GCP
    GCS1[GCS Box1\nRaw / Staging]
    BQ[BigQuery\nTransform①\n業務要件整形]
    GCS2[GCS Box2\nDelivery (UTF-8)]
    CR[Cloud Run\nTransform② + Delivery\nUTF-8→SJIS]
    GCS3[GCS Box3\nOps\nLogs / Meta / Retry]
  end

  subgraph CoreSystem
    CORE[Core System\n(SFTP / FTPS)]
  end

  POS --> SCH --> GCS1 --> BQ --> GCS2
  GCS2 -->|PUT trigger| CR
  CR -->|log / meta| GCS3
  CR -->|secure transfer| CORE
````

---

### 3. TO-BEで意識する運用設計ポイント

* データ責任境界（SoT）の明確化
* 冪等性（同一データの二重送信防止）
* 失敗時の再実行設計
* ログ・メタ情報の一元管理
* 人手を介さない実行フロー

---

### 4. 学習メモ（BigQueryの位置づけ）

* BigQueryは「分析専用」ではなく **ETLの中核的Transformレイヤー**
* BigQuery自体を使いこなすことより、

  * どこまでをBigQueryでやるか
  * どこからを外部処理に切り出すか
    の判断が重要
* BigQueryはパイプラインの **終点ではなく通過点** になり得る

---

### 5. まとめ（気づき）

ETLの問題は、ツールやSQLの問題ではなく、
**構造・責任境界・運用定義が存在しないこと** に起因する。

BigQueryとCloud Runを分離して設計することで、
モダンなクラウドとレガシーな基幹システムを
無理なく接続できる構造が成立する。

---

## embulk Digdag 学習メモ

### embulk（えんばるく）

ETL（特に Extract / Load）を担うための **データ転送・取り込みツール**。  
オンプレミスや外部システム、ファイル（CSV/TSVなど）からデータを取得し、  
BigQuery や Cloud Storage などへ **定義ベースで再現性をもって投入**するために使われる。

#### 役割のポイント
- データの「取り出し」と「投入」を専門に扱う
- 入出力の仕様を設定ファイル（YAML等）で定義できる
- 手動転送（WinSCP等）を排除し、**自動・再実行可能**な形にできる
- ローカル/オンプレ環境からクラウドへの橋渡し役になりやすい

#### 現場文脈での位置づけ
- POSや業務DBなど、**クラウド外にあるデータを定期的に取り込む**用途で利用される
- Transform（複雑な加工）は embulk ではなく、  
  取り込み後に BigQuery や別処理に委ねるケースが多い
- 「転送の標準化」「属人化排除」が主目的

---

### Digdag（でぃぐだぐ）

ETLやバッチ処理全体を **どの順番で・いつ・失敗時にどう回すか** を管理する  
**ワークフロー（オーケストレーション）ツール**。

#### 役割のポイント
- 複数ジョブの依存関係を定義できる
- 定期実行（スケジューリング）が可能
- 失敗時の停止・再実行・分岐制御ができる
- embulk やスクリプト、SQL などを **まとめて制御** する立場

#### 現場文脈での位置づけ
- embulk単体では管理しきれない  
  「前処理 → 取り込み → 整形 → 出力」 の流れを制御する
- 夜間バッチ・日次処理などの **運用の司令塔**
- 人が cron や手動で順番管理する代わりに使われる

---

### embulk × Digdag の関係（理解の軸）

- embulk：  
  **「データを運ぶ人」**
- Digdag：  
  **「いつ・どの順で運ぶか指示する人」**

embulkが「1作業」なのに対し、  
Digdagは「全体の流れと失敗時の振る舞い」を管理する。

---

### ETL全体での配置イメージ

```mermaid
flowchart LR
  A[On-Prem / External Data] -->|Extract / Load| B[embulk]
  B --> C[Cloud Storage / BigQuery]
  C --> D[Transform / SQL / Script]

  E[Digdag] --> B
  E --> D
````

---

### 学習メモ（自分の経験と照合）

* 手動転送や個人PC起点の処理は、
  本来 embulk + Digdag が担う領域
* 自分が Cloud Run で実装した処理は、
  embulk の代替や後段 Transform をクラウドネイティブに実装した形とも言える
* ツールは違っても、**考え方（ETL / オーケストレーション）は共通**


なお、「embulk / Digdag はOSSで安価だが、運用基盤としての維持コストが高い場合があるため、
Cloud Run中心のマネージド構成を選択してもOKな場合も多い。
オンプレミスなどで、大量のデータを裁く必要がある場合は道入メリットはありそう。
運用コストとの兼ね合い。
---


## 警報転送（Alert → Slack）の実装案メモ

### 方針
- 処理（Cloud Run / BigQuery）は「ログを出すだけ」
- 異常検知・通知は Cloud Monitoring 側に寄せる（責務分離）
- Slack通知は Incoming Webhook を Notification Channel として使う

---

### 通知先（Slack）準備
1. Slack に専用チャンネルを用意（例：#etl-alert）
2. Incoming Webhook を作成
3. Webhook URL を控える（Secret化してもよいが、まずはMonitoring登録でOK）

---

### 監視/通知の全体構成
1) Cloud Logging にログが集約  
2) ログベースメトリクス（Log-based Metrics）で「失敗」を数値化  
3) Cloud Monitoring Alert Policy で閾値判定  
4) Notification Channel（Slack Webhook）へ通知

---

### 監視項目（最小3つ）

#### 1. Cloud Run 転送失敗（Delivery失敗）
- 検知：Cloud Run の ERROR ログ / 非200
- 実装：ログベースメトリクス（例：cloudrun_transfer_fail_count）
- アラート：直近5分で >0 なら通知

例：ログフィルタ（概念）
- resource.type="cloud_run_revision"
- severity>=ERROR
- "transfer" "failed" などのキーワード
- もしくは jsonPayload.status="fail"（メタログ出してるならこれが最強）

---

#### 2. BigQuery ジョブ失敗（Transform①失敗）
- 検知：BigQuery job の error
- 実装：BigQueryジョブログをログベースメトリクス化
- アラート：直近1時間で >0

---

#### 3. 「日次成功メタが出ていない」（未実行/詰まり検知）
- 検知：Ops（箱3）に success メタログが一定時間出ていない
- 実装案A（推奨）：Cloud Runが成功時に `status=success` を必ずログ出力 → 欠損アラート（absence）
- 実装案B：Ops用GCSへ successメタJSONを出力し、その書き込みログを監視（欠損）

アラート：24h 連続で success が無い → 通知

---

### Slack通知メッセージ（短く・構造的に）
通知文に入れるのはこれだけで十分：
- step（どの工程か）
- status（FAILED / MISSING）
- time
- run_id（あれば）
- log_link（あれば）

例（イメージ）
[ELT ALERT]
step: Cloud Run Delivery
status: FAILED
time: 2026-01-31 02:15 JST
hint: check Cloud Logging (cloud_run_revision)

---

### 実装の優先順位（1週間想定の最短ルート）
Day1: Slack webhook + Monitoring Notification Channel 作成  
Day2: Cloud Run ERRORログ → ログベースメトリクス → Alert  
Day3: BigQuery job failure → メトリクス → Alert  
Day4: successログ（またはsuccessメタJSON）を定義  
Day5: 欠損アラート（absence）を追加  
Day6: しきい値調整（誤検知を減らす）  
Day7: 運用手順（誰が見る/一次対応/再実行）を1枚メモ化

---

### メモ
- 「処理からSlackへ直接通知」は避ける（責務分離・監査説明が楽）
- Ops用メタログ（run_id/status/rows/dest）を出すと、監視・監査・運用が一気に安定する

---

