# 📚 ACE試験：日本人が苦手な重要英単語 30選

| 単語 (Word) | 意味 (Meaning) | 背景・試験での文脈 (Context) |
| --- | --- | --- |
| **Adhere to** | 〜を遵守する、従う | 「Google の推奨案に従う」という文脈で必ず登場します 。

 |
| **Prerequisite** | 前提条件 | コマンドを打つ前に「まず有効化が必要」などの条件を指します 。

 |
| **Retain / Retention** | 保持する / 保管期間 | ログやバックアップを「何日間残すか」という設定の話です 。

 |
| **Provision** | 準備する、配備する | インフラを「作成・割り当てる」ことを指す動詞です 。

 |
| **Ephemeral** | 一時的な、儚い | インスタンス削除時に消えてしまう「一時 IP」などで使われます 。

 |
| **Incur** | （費用を）負う、発生させる | 「追加の費用がかかる」という文脈で頻出します 。

 |
| **Egress / Ingress** | 下り（送出）/ 上り（流入） | 通信費用の計算やファイアウォールの「方向」を決めます 。

 |
| **Exhaustion** | 枯渇（こかつ） | 「IP アドレスが足りなくなった」というトラブルの合図です 。

 |
| **Compliant / Compliance** | 遵守している / 法令遵守 | 「監査（Audit）に合格する必要がある」という状況設定です 。

 |
| **Overhead** | 負荷、余分な手間 | 「管理の手間（Operational Overhead）」を減らすのが正義です 。

 |
| **Proprietary** | 独自の、社外秘の | 自社開発のソフト。Marketplace に対する対義語として出ます 。

 |
| **Unresponsive** | 応答がない | サーバーが死んでいる（Autohealing）の文脈で使われます 。

 |
| **Constraint** | 制約（せいやく） | 組織ポリシーなどで「特定のアクションを禁ずる」ルールです 。

 |
| **Consolidate** | 統合する、まとめる | 複数のプロジェクトや請求書を一つにまとめる時。 |
| **Substantial** | かなりの、大幅な | 費用の「大幅な」削減など、強調表現として使われます 。

 |
| **Disruption** | 中断、停止 | サービスが止まること。`minimal disruption`（最小の停止）を目指します 。

 |
| **Audit / Auditor** | 監査 / 監査人 | ログを見せる相手。一時権限を与える対象として頻出します 。

 |
| **Accidental** | 誤った、不注意な | <br>`Accidental deletion`（うっかり削除）防止の設定（保護）の話です 。

 |
| **Retrieve** | 取り出す、検索する | ストレージからデータを読み出す際の手数料に関連します 。

 |
| **Consistent** | 一貫性のある | データがズレていないこと。Spanner の強みとして出ます 。

 |
| **Durable / Durability** | 耐久性のある | データが消えないこと。GCS の信頼性を示す言葉です 。

 |
| **Unoccupied** | 空いている、暇な | 待機中のインスタンス（Idle）を指す際に使われます 。

 |
| **Enforce** | 強制する、適用する | 組織ポリシーを全プロジェクトに「無理やり」かける時に出ます 。

 |
| **Expire / Expiry** | 期限が切れる / 有効期限 | キーや一時権限の「寿命」が切れることです 。

 |
| **Isolated / Isolation** | 分離された / 隔離 | 他と混ざらない環境。セキュリティ上の「分離」を指します 。

 |
| **Grant** | 付与する、与える | 権限（Role）を「あげる」こと。`Assign` とほぼ同義です 。

 |
| **Execute** | 実行する | コマンドを叩く。`Run` のフォーマルな表現です 。

 |
| **Mitigate** | 軽減する、緩和する | リスクやコストを抑える、という意味で使われます 。

 |
| **Preempt** | 横取りする、中断する | 安いけど Google に中断される VM（Spot/Preemptible）のことです 。

 |
| **Granular** | きめ細かい、粒度の細かい | 権限を「細部まで」設定する際に使われます 。

 |

---

# 🧠 GCP ACE 試験：分野別重要キーワード論点マップ

### 1. クラウドソリューション環境の設定 (Setting up environment)

組織全体の統制と、リソースを使い始める前の「箱作り」に関する論点です。

* **リソース階層 (Resource Hierarchy)**:
* 
**組織 ➔ フォルダ ➔ プロジェクト ➔ リソース** の順序を厳守すること 。




* **権限管理 (IAM Best Practices)**:
* 
**Google グループ** を活用し、個々のユーザーではなくグループにロールを付与する 。


* 
**最小権限の原則 (Least Privilege)**: 基本ロール（Viewer/Editor）を避け、**事前定義ロール**や**カスタムロール**を使用する 。




* **プロジェクト属性 (Project Attributes)**:
* 
**プロジェクト名**は変更可能だが、**プロジェクト ID** と**プロジェクト番号**は不変である 。




* **課金管理 (Cloud Billing)**:
* プロジェクトは常に**1つの請求先アカウント**にのみリンクされる 。


* 
**Billing Export**: 詳細なコスト分析には **BigQuery** へのエクスポートが必須 。





### 2. 計画と構成 (Planning and Configuring)

要件（毒）に合わせた最適なサービス（薬）の選択に関する論点です。

* **コンピューティングの選択 (Compute Options)**:
* 
**Compute Engine**: 特定の OS への依存関係や高度なカスタマイズが必要な場合 。


* 
**Cloud Run**: コンテナ化されたマイクロサービス、**Scale-to-Zero**（リクエスト時のみ課金）が必要な場合 。


* 
**GKE Autopilot**: インフラ（Node）管理を Google に任せ、Pod 単位で管理したい場合 。




* **ストレージ・DB の選択 (Storage & DB Options)**:
* 
**BigQuery**: SQL を使用した大規模データの分析（Analytics） 。


* 
**Cloud Spanner**: グローバル規模、強一貫性、リレーショナル DB 。


* 
**Cloud Bigtable**: 高スループット、時系列データ、IoT データの格納 。


* 
**Firestore**: モバイル/Web 向けの NoSQL ドキュメント DB 。





### 3. デプロイと実装 (Deploying and Implementing)

実際のリソース構築と、その際の設定項目に関する論点です。

* **ネットワーク (Networking)**:
* 
**カスタムモード VPC**: サブネットの IP 範囲を完全に制御したい場合に使用 。


* 
**VPC ネットワーク拡張**: `expand-ip-range` コマンドで既存サブネットの IP 範囲を広げる 。




* **自動化 (Automation)**:
* 
**Infrastructure as Code (IaC)**: **Terraform** を使用し、`terraform apply` でリソースを確定させる 。




* **データ移行 (Migration)**:
* 
**Cloud Marketplace**: 既存の DB（MySQL 等）を最も迅速かつ経済的にクラウドへ展開する手段 。





### 4. 正常な運用 (Successful Operation)

稼働後の保守、バックアップ、監視に関する論点です。

* **バックアップ・復旧 (Backup & Recovery)**:
* 
**Snapshot Schedule**: スナップショットの定期実行と自動削除（ライフサイクル管理） 。


* 
**Lifecycle Management**: GCS で Age（日数）を条件に、ストレージクラスを Nearline や Archive へ自動変更する 。




* **監視とアラート (Monitoring & Alerting)**:
* 
**Alerting Policy**: CPU 使用率などの指標（Metric）がしきい値を超えた際に、通知（メール、Webhook）を送る設定 。


* **Uptime Check**: アプリケーションの可用性を外部からチェックする。



### 5. アクセスとセキュリティ (Access and Security)

安全なアクセスの確保と、アイデンティティ管理に関する論点です。

* **サービスアカウント (Service Accounts)**:
* アプリケーション（GKE Pod や VM）間の認証にはユーザーアカウントではなくサービスアカウントを使用する 。




* **アイデンティティ連携 (Identity Federation)**:
* **Google Cloud Directory Sync (GCDS)**: オンプレミスの Active Directory ユーザーを Google Cloud へ同期する標準ツール。


* **セキュアな接続**:
* **Cloud SQL Auth Proxy**: 暗号化された安全な DB 接続を最小限の手間で実現するツール。



---

### 💡 AA（アスキーアート）による概念イメージ

**リソース階層のイメージ**

```text
[ Organization ]  <-- 組織ポリシー/一括請求
       |
    [ Folder ]    <-- 部門ごとの管理
       |
   [cite_start][ Project ]    <-- 最小の独立単位 / 課金の境界 [cite: 25]
       |
 [ Resources ]    <-- VM, GCS, BQ, etc.

```

**データの流れ（IoT パイプライン）**

```text
[センサー/端末] ➔ [Pub/Sub] ➔ [Dataflow] ➔ [Bigtable/GCS] ➔ [BigQuery]
   (発生)        (収集)       (加工)          (保存)         (分析)

```

---
