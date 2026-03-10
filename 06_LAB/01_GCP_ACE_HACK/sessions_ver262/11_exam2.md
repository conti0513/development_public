# ■ Google Cloud ACE Session 2：完全デフラグ版 (Q1-Q50)

#### **Q1: ログの外部SaaS転送**

* **【元の文】**: NebulaArcade wants to stream application logs into a third-party SaaS tool with as little export latency as possible.
* **【論点抽出】**
* **主体**: Cloud Loggingのログ
* **目的**: 外部SaaS（Datadog等）での一元監視
* **制約**: **最小遅延（Low Latency）** / ストリーミング


* **【コンセプト】**: リアルタイム転送 ➔ **Pub/Sub**。蓄積用のGCSやBigQueryはバッチ処理になるため「毒」。
* **【結論】**: **Log Sink ➔ Pub/Sub**

---


#### **Q2: 課金データの詳細分析**

* **【元の文】**: Finance team needs itemized visibility into monthly cloud spending across multiple projects to run advanced SQL queries in BigQuery.
* **【論点抽出】**
* **主体**: 請求先アカウントの課金データ
* **目的**: 詳細なSQL分析 / ダッシュボード作成
* **制約**: **自動化** / 詳細項目（Itemized）


* **【コンセプト】**: 課金分析のデファクト ➔ **BigQuery Export**。手動抽出やAPI開発は運用負荷が高いため「毒」。
* **【結論】**: **Cloud Billing ➔ BigQuery Export有効化**


---


#### **Q3: Cloud Runの起動遅延対策**

* **【元の文】**: Deploy version 3.4. Guarantee at least two instances are already running and idle so requests experience no cold starts.
* **【論点抽出】**
* **主体**: Cloud Runの新リビジョン(v3.4)
* **目的**: **コールドスタート防止**
* **制約**: 最小2インスタンスを常時稼働 / 低運用負荷


* **【コンセプト】**: **リビジョン単位**の最小インスタンス設定。サービス全体設定（B）は新旧混在時に新版が動かないリスクがあるため「毒」。
* **【結論】**: **Revision-level autoscaling ➔ min-instances = 2**


---


*
#### **Q4: グローバルな動画配信最適化**

* **【元の文】**: PulsePanda’s audience grown across North America, Europe, and SE Asia. Keep video start times snappy worldwide and scale smoothly.
* **【論点抽出】**
* **主体**: 北米・欧州・東南アジアのユーザー
* **目的**: 低レイテンシ（Snappy）/ グローバルスケーリング
* **制約**: **複数リージョン配備** / Google推奨手法


* **【コンセプト】**: 世界規模の負荷分散 ➔ **Global ALB**。物理的な距離短縮 ➔ **マルチリージョン配備**。
* **【結論】**: **Multi-region VM deployment + Global Application Load Balancer**


---


*
#### **Q5: GKEでのステートフルワークロード**

* **【元の文】**: Move database to GKE. Protect from data loss while ensuring enough nodes available when traffic spikes.
* **【論点抽出】**
* **主体**: データベース（PostgreSQL等）
* **目的**: データ損失防止 / ノードの自動拡張
* **制約**: 手動操作の削減（自動化）


* **【コンセプト】**: 永続性が必要なDB ➔ **StatefulSet**。ノード不足解消 ➔ **Cluster Autoscaler**。
* **【結論】**: **StatefulSet + Cluster Autoscaler**


---


#### **Q6: プロジェクトを跨ぐイメージ共有**

* **【元の文】**: GKE cluster in Project B needs to pull container images from Artifact Registry in Project A.
* **【論点抽出】**
* **主体**: プロジェクトA（AR）とプロジェクトB（GKE）
* **目的**: イメージのプル権限付与
* **制約**: IAMの最小権限


* **【コンセプト】**: **GKEノードのSA**に権限付与。JSONキー（C）は管理負荷があるため「毒」。
* **【結論】**: **Artifact Registry Reader (assigned to GKE service account)**


---


#### **Q7: Windows VMの初回ログイン**

* **【元の文】**: Ensure that your team can log in to the Windows VM via Remote Desktop Protocol (RDP).
* **【論点抽出】**
* **主体**: Windows VM
* **目的**: RDPでのログイン
* **制約**: 最も直接的なアプローチ


* **【コンセプト】**: Windows用の標準パスワード管理 ➔ **reset-windows-password**。
* **【結論】**: **gcloud compute reset-windows-password**


---


#### **Q8: オブジェクトのライフサイクル最適化**

* **【元の文】**: Compliance requires 3-year retention. Frequent access for 7 months, then audit-only (cheapest).
* **【論点抽出】**
* **主体**: 大量のドキュメント（GCS）
* **目的**: 3年保持 / 7ヶ月後にコスト削減
* **制約**: **最安（Cheapest）** / 低運用負荷


* **【コンセプト】**: 自動クラス変更 ➔ **Lifecycle Management**。7ヶ月後に安い **Coldline**。
* **【結論】**: **GCS Lifecycle Policy ➔ 7 months ➔ Coldline**


---


#### **Q9: App Engineのトラフィック分割**

* **【元の文】**: Deploy the new version of TaskMaster on App Engine. You want to roll out the new version to just 1% of users initially.
* **【論点抽出】**
* **主体**: App Engine上の新バージョン
* **目的**: カナリアリリース（1%のみ）
* **制約**: パフォーマンス監視


* **【コンセプト】**: App Engineの標準機能 ➔ **Traffic Splitting**。GKEへの移行（A）などはオーバースペックで「毒」。
* **【結論】**: **App Engine ➔ Traffic Splitting (1% to new version)**


---


#### **Q10: グローバル規模の強整合性DB**

* **【元の文】**: ChatterNest needs a managed database that supports automatic scaling, multi-region, and consistently low latency.
* **【論点抽出】**
* **主体**: SNSデータ（リレーショナル）
* **目的**: グローバル展開 / 自動スケーリング
* **制約**: **強整合性** / 低レイテンシ


* **【コンセプト】**: グローバル強整合性 ➔ **Cloud Spanner**。Cloud SQL（C）はリージョン内サービスのため「毒」。
* **【結論】**: **Cloud Spanner**


---


#### **Q11: 部門別の予算管理**

* **【元の文】**: Multiple product teams need to track their own spend, get budget alerts, and build dashboards in BigQuery.
* **【論点抽出】**
* **主体**: 複数のプロダクトチーム
* **目的**: 予算アラート / BigQueryでのカスタム分析
* **制約**: 運用負荷最小（ノーコード優先）


* **【コンセプト】**: 標準アラート ➔ **Budget threshold alerts**。標準連携 ➔ **BigQuery Export**。
* **【結論】**: **Budget threshold alerts + Cloud Billing export to BigQuery**


---


#### **Q12: 有効化済みAPIの確認**

* **【元の文】**: Produce a list of all the enabled Google Cloud Platform APIs for their GCP project.
* **【論点抽出】**
* **主体**: GCPプロジェクト
* **目的**: 有効なAPIのリスト化
* **制約**: gcloudコマンドを使用


* **【コンセプト】**: サービス一覧 ➔ **services list**。`--available`（B）は有効化されていないものも含むため「毒」。
* **【結論】**: **gcloud services list**



---

#### **Q13: GCSの変更イベント通知**

* **【元の文】**: Regulatory requirement: notified whenever any file is created, updated, or deleted. Minimal management.
* **【論点抽出】**
* **主体**: Production bucket
* **目的**: 全オブジェクト操作の通知
* **制約**: **確実な通知** / 最小管理


* **【コンセプト】**: ストレージイベント ➔ **Pub/Sub連携**。手動ログチェック（A）は遅延と漏れがあるため「毒」。
* **【結論】**: **Cloud Storage ➔ Pub/Sub notifications**



---


*
#### **Q14: GKEアプリのHTTPS公開**

* **【元の文】**: Expose SnapChirp's frontend application to the public, using HTTPS on a public IP address.
* **【論点抽出】**
* **主体**: GKEフロントエンド
* **目的**: HTTPSでの公開
* **制約**: 公開IP利用


* **【コンセプト】**: 標準的なL7公開 ➔ **Ingress**。ClusterIP（B）は内部専用のため「毒」。
* **【結論】**: **Service (NodePort) ➔ Ingress (Load Balancer)**


---


#### **Q15: 読み取り専用の監査権限**

* **【元の文】**: Auditor needs access to review all aspects of the project but should not make changes.
* **【論点抽出】**
* **主体**: 監査ユーザー
* **目的**: 全リソースのレビュー
* **制約**: **変更不可（View-only）**


* **【コンセプト】**: 標準的な閲覧者権限 ➔ **Project Viewer**。カスタムロール（A）は管理が煩雑になるため「毒」。
* **【結論】**: **Built-in IAM project Viewer role**



---


*
#### **Q16: カスタムイメージによる複製**

* **【元の文】**: Already has a custom image available. Need to create and deploy copies to scale effectively.
* **【論点抽出】**
* **主体**: 既存のカスタムイメージ
* **目的**: 大量デプロイ / スケーリング
* **制約**: 迅速な展開


* **【コンセプト】**: 金型（イメージ）から製品（インスタンス）を作る。スナップショットからの直接作成（B）は非効率なため「毒」。
* **【結論】**: **Create instances from that image**


---


#### **Q17: ローカルログの収集設定**

* **【元の文】**: Application writes logs to local disk. Need to investigate cause of errors.
* **【論点抽出】**
* **主体**: Compute Engine上のアプリ
* **目的**: ローカルログの調査
* **制約**: Cloud Loggingでの閲覧


* **【コンセプト】**: ログの吸い上げ ➔ **Logging Agent**。インストールしないとCloud Loggingには反映されないため「毒」。
* **【結論】**: **Install Cloud Logging Agent**


---


#### **Q18: プロジェクト間ストレージアクセス**

* **【元の文】**: VM in project A needs to write reports to a bucket in project B automatically.
* **【論点抽出】**
* **主体**: VMのサービスアカウント
* **目的**: 別プロジェクトのバケットへの自動書き込み
* **制約**: 最小ステップ


* **【コンセプト】**: **ターゲット側のバケット**でSAに権限付与。プロジェクト移動（A）は不要なため「毒」。
* **【結論】**: **Grant Storage Object Creator on the bucket to the VM Service Account**


---


#### **Q19: プロジェクト間のネットワーク共有**

* **【元の文】**: Two applications in separate projects and VPCs need to communicate.
* **【論点抽出】**
* **主体**: 2つの異なるプロジェクト
* **目的**: VPC間のセキュアな通信
* **制約**: 同一組織内


* **【コンセプト】**: 組織内ネットワークハブ ➔ **Shared VPC**。全インスタンスの作り直し（A）は非現実的なため「毒」。
* **【結論】**: **Shared VPC (Host/Service project)**



---


*
#### **Q20: GKEストレージコストの見積もり**

* **【元の文】**: Logistics tracking system on GKE. Requires high IOPs and disk snapshots for backups.
* **【論点抽出】**
* **主体**: GKEワークロード
* **目的**: **高IOPs** / バックアップ
* **制約**: 料金計算ツールでの見積もり


* **【コンセプト】**: 高速ディスク ➔ **Local SSD**。バックアップ ➔ **Persistent Disk + Snapshot**。
* **【結論】**: **Local SSD + Persistent Disk storage + Snapshot storage**



---


*
#### **Q21: Pod異常状態の調査**

* **【元の文】**: One of the pods is stuck in a PENDING state. Troubleshoot the issue.
* **【論点抽出】**
* **主体**: PENDING状態のPod
* **目的**: 原因特定
* **制約**: 次のアクション


* **【コンセプト】**: 詳細情報・イベントの確認 ➔ **kubectl describe**。
* **【結論】**: **kubectl describe pod <name>**


---




*
#### **Q22: OS Loginによるアクセス管理**

* **【元の文】**: Configure secure SSH access to a single VM for developers in the dev1 team.
* **【論点抽出】**
* **主体**: 特定のCompute Engineインスタンス
* **目的**: 安全なSSHアクセス
* **制約**: 特定チームのみ


* **【コンセプト】**: 鍵配布からの脱却 ➔ **OS Login**。共通鍵の使い回し（D）はセキュリティ上「毒」。
* **【結論】**: **enable-oslogin=true + compute.osLogin役割**


---




*
#### **Q23: 新規プロジェクトへのリソース配置**

* **【元の文】**: Launch a new VM, but the project hasn't been set up yet.
* **【論点抽出】**
* **主体**: 新規システム
* **目的**: プロジェクト作成からVM起動まで
* **制約**: 正しい手順


* **【コンセプト】**: 容器（Project）➔ 機能（API有効化）➔ 具（VM）の順。
* **【結論】**: **Create project ➔ Enable Compute Engine API ➔ Create instance**


---



*
#### **Q24: 長時間バッチとコスト最適化**

* **【元の文】**: Task takes 40 hours. Must restart if interrupted. Lowest cost possible.
* **【論点抽出】**
* **主体**: 40時間バッチ
* **目的**: 確実な完走（リスタート負荷大）
* **制約**: **24時間で強制終了されるPreemptibleは使えない**


* **【コンセプト】**: 完走重視 ➔ **Standard VMをStart/Stop**。安さだけでPreemptible（A, B）を選ぶのは、40時間完走できないため「毒」。
* **【結論】**: **Standard VM ➔ Start and Stop as needed**


---


#### **Q25: IoT高頻度データストレージ**

* **【元の文】**: Thousands of events per hour. Consistent data based on timestamp, atomic updates.
* **【論点抽出】**
* **主体**: ドローンのセンサーデータ
* **目的**: 高頻度書き込み / タイムスタンプ検索
* **制約**: アトミックな更新


* **【コンセプト】**: 大規模時系列 ➔ **Cloud Bigtable**。ファイル保存（A, B）は検索性が悪いため「毒」。
* **【結論】**: **Cloud Bigtable (Row key based on timestamp)**


---


#### **Q26: バッチ処理の自動リトライ設定**

* **【元の文】**: Overnight reconciliation at 2:15 AM. Batch workload. Automatically retry if fails.
* **【論点抽出】**
* **主体**: 深夜バッチ
* **目的**: 定時実行 / 異常時の自動リトライ
* **制約**: 運用負荷最小


* **【コンセプト】**: バッチ専用 ➔ **Cloud Run Job**。HTTPサービスのCloud Run Service（B）はタイムアウト制限が強いためバッチには「毒」。
* **【結論】**: **Cloud Run Job + Cloud Scheduler**


---


#### **Q27: DockerイメージのGKE展開**

* **【元の文】**: Package app into a Docker image. Deploy this as a workload on GKE.
* **【論点抽出】**
* **主体**: Dockerイメージ
* **目的**: GKEへのデプロイ
* **制約**: 推奨手順


* **【コンセプト】**: 倉庫（Registry）へ置く。GCS（A, B）はコンテナリポジトリではないため「毒」。
* **【結論】**: **Container Registry ➔ Kubernetes Deployment**


---


*
#### **Q28: 組織内ポリシーの継承管理**

* **【元の文】**: Group resources with similar access settings together for easy management.
* **【論点抽出】**
* **主体**: 複数のプロジェクト
* **目的**: IAMの一括管理
* **制約**: 階層構造


* **【コンセプト】**: 共通設定の箱 ➔ **Folders**。ラベル（A）は「目印」にすぎないため「毒」。
* **【結論】**: **Folders**


---


#### **Q29: 公開IPなしでのSSH管理**

* **【元の文】**: Connect to Linux VMs securely via SSH without exposing public IP addresses.
* **【論点抽出】**
* **主体**: プライベートIPのみのVM群
* **目的**: 安全なSSH接続
* **制約**: 公開IP（Global IP）の禁止


* **【コンセプト】**: 踏み台不要のセキュアアクセス ➔ **IAP (Identity-Aware Proxy)**。
* **【結論】**: **IAP for TCP forwarding (SSH)**


---


*
#### **Q30: 複数プロジェクトの一元監視**

* **【元の文】**: Track metrics across three projects (Apollo, Luna, Nova) in a unified view.
* **【論点抽出】**
* **主体**: 3つのプロジェクト
* **目的**: CPU、メモリ、ディスク使用率の一元的な可視化
* **制約**: 最も効率的な設定


* **【コンセプト】**: 複数プロジェクト統合 ➔ **Monitoring Workspace**。
* **【結論】**: **Monitoring Workspace に他プロジェクトを追加**


---


*
#### **Q31: ワークロード別のノードプール最適化**

* **【元の文】**: Image processing (High CPU) vs Routine tasks. Keep costs down while maintaining performance.
* **【論点抽出】**
* **主体**: 異なるリソース要求を持つアプリ群
* **目的**: コスト最適化
* **制約**: 性能維持


* **【コンセプト】**: 適材適所 ➔ **Node Poolの分離**。高CPUにはCompute-optimized。
* **【結論】**: **Compute-optimized node pool + General-purpose node pool**


---


#### **Q32: 高可用性VPNの設定**

* **【元の文】**: Secure VPN between VPC and data center. Dynamic routing, no extra tunnels during failover.
* **【論点抽出】**
* **主体**: 新規VPCと外部データセンター間
* **目的**: 高可用性（HA）な接続
* **制約**: **動的ルーティング（BGP）** / 指定IPレンジ


* **【コンセプト】**: HA VPN ➔ **Cloud Router (BGP)**。
* **【結論】**: **Custom mode VPC + Cloud Router BGP routes + Active-passive routing**



---

*
#### **Q33: VM上のアプリ認証（Best Practice）**

* **【元の文】**: App on VM needs access to Google services. Minimal changes, Google-recommended.
* **【論点抽出】**
* **主体**: VM上のアプリ
* **目的**: Googleサービスへの認証
* **制約**: 鍵ファイルを置かない認証


* **【コンセプト】**: 権限の委譲 ➔ **VMのサービスアカウントに適切な権限を付与**。
* **【結論】**: **Assign appropriate access to the VM's service account**


---


#### **Q34: BigQueryデータ更新のデバッグ**

* **【元の文】**: Nightly summary table recalculation failed, charts not displaying. Investigate.
* **【論点抽出】**
* **主体**: 夜間のBigQueryジョブ
* **目的**: 失敗原因の特定
* **制約**: 直接的な調査


* **【コンセプト】**: ジョブ履歴の確認 ➔ **BigQuery UIでジョブ履歴を確認**。
* **【結論】**: **Use the BigQuery interface to review the nightly job**


---


#### **Q35: 世界規模のリレーショナルデータ管理**

* **【元の文】**: Global e-learning. Track progress. Consistent performance worldwide with simple management.
* **【論点抽出】**
* **主体**: グローバルユーザーの進捗データ
* **目的**: 世界規模で一定のパフォーマンス（Consistent）
* **制約**: リレーショナル（SQL）


* **【コンセプト】**: 世界規模×SQL×強整合性 ➔ **Cloud Spanner**。
* **【結論】**: **Cloud Spanner**


---


#### **Q36: gcloudプロキシ認証情報の保護**

* **【元の文】**: Prevent proxy credentials from being logged in CLI logs.
* **【論点抽出】**
* **主体**: gcloud CLI設定
* **目的**: 認証情報の秘匿
* **制約**: ログへの記録防止


* **【コンセプト】**: 設定ファイルに書かない ➔ **環境変数 (CLOUDSDK_PROXY_...) を使う**。
* **【結論】**: **Set CLOUDSDK_PROXY properties using environment variables**


---


#### **Q37: GKEのコスト・可用性ミックス**

* **【元の文】**: Recommendation engine (fault-tolerant) vs Order processing (must be available).
* **【論点抽出】**
* **主体**: 異なる重要度のGKEワークロード
* **目的**: コスト効率化
* **制約**: 可用性の確保


* **【コンセプト】**: ワークロードに応じたVM ➔ **注文用(Standard VM) と 推奨用(Spot VM) でノードプールを分ける**。
* **【結論】**: **Separate node pools for Spot and Standard VMs**


---


#### **Q38: サーバーレスでのカナリアテスト**

* **【元の文】**: Test new backend version with a small % of users before full rollout. Serverless.
* **【論点抽出】**
* **主体**: Cloud Runアプリ
* **目的**: トラフィックの一部転送（カナリア）
* **制約**: サーバーレス環境


* **【コンセプト】**: トラフィック制御 ➔ **Cloud Run ➔ Gradual rollouts (Traffic splitting)**。
* **【結論】**: **Cloud Run ➔ Traffic splitting**


---


*
#### **Q39: OS脆弱性のスキャン**

* **【元の文】**: Visibility into potential vulnerabilities and other OS metadata for an instance.
* **【論点抽出】**
* **主体**: Compute Engineインスタンス
* **目的**: 脆弱性情報の可視化
* **制約**: セキュリティポリシー準拠


* **【コンセプト】**: OS情報の収集 ➔ **OS Config agent をインストール + VulnerabilityReportViewer 権限**。
* **【結論】**: **OS Config agent + osconfig.vulnerabilityReportViewer role**


---


#### **Q40: Cloud Runのリスク低減デプロイ**

* **【元の文】**: Minimize customers affected by potential outages during new revision deployment.
* **【論点抽出】**
* **主体**: Cloud Runの新リビジョン
* **目的**: デプロイリスクの最小化
* **制約**: 推奨プラクティス


* **【コンセプト】**: 安全な展開 ➔ **Gradually roll out + Traffic splitting**。
* **【結論】**: **Gradually roll out and split traffic**


---


#### **Q41: 予測不能な成長に対応するDB**

* **【元の文】**: Fitness app. Unpredictable user base. Scale seamlessly without significant configuration updates.
* **【論点抽出】**
* **主体**: 予測不能なユーザー数
* **目的**: 無停止・シームレスなスケール
* **制約**: リレーショナルデータ


* **【コンセプト】**: 水平スケール最強 ➔ **Cloud Spanner**。
* **【結論】**: **Cloud Spanner**


---


*
#### **Q42: Google垢なし業者へのSSH提供**

* **【元の文】**: External contractor needs SSH access but does not have a Google account.
* **【論点抽出】**
* **主体**: 外部請負業者
* **目的**: インスタンスへのSSHメンテナンス
* **制約**: Googleアカウントなし


* **【コンセプト】**: 公開鍵の直接登録 ➔ **業者の公開鍵を受け取り、手動でVMメタデータに追加する**。
* **【結論】**: **Add contractor's public key to the instance metadata**


---


*
#### **Q43: ファイアウォール変更の監視**

* **【元の文】**: Monitor any unexpected changes to firewall rules and creation of new VMs. Straightforward.
* **【論点抽出】**
* **主体**: セキュリティ監査
* **目的**: FWやVM変更の即時把握
* **制約**: シンプルな構成


* **【コンセプト】**: ログからのアラート ➔ **Cloud Logging でログベースの指標を作成し、アラートを設定**。
* **【結論】**: **Log-based metrics + Monitoring alerts**



---

#### **Q44: L4でのIPアドレス保持**

* **【元の文】**: Application on port 389 needs to ensure original IP address of clients is preserved.
* **【論点抽出】**
* **主体**: 金融系TCPアプリ
* **目的**: **クライアントIPの保持（透過性）**
* **制約**: インターネット公開


* **【コンセプト】**: パススルー型（L4） ➔ **External Network Load Balancer**。Proxy型（L7）はIPを書き換えるため「毒」。
* **【結論】**: **External TCP Network Load Balancer**



---

#### **Q45: 最小権限でのBigQueryアクセス**

* **【元の文】**: VM in Project A needs access to BigQuery in Project B. Best practices.
* **【論点抽出】**
* **主体**: プロジェクトを跨ぐサービスアカウント
* **目的**: データセットへのアクセス
* **制約**: 最小権限の原則


* **【コンセプト】**: 必要な権限のみ付与 ➔ **Project Bで、SAに bigquery.dataViewer を付与**。
* **【結論】**: **Grant bigquery.dataViewer role in the destination project**


---


#### **Q46: サブネットのIP拡張**

* **【元の文】**: Subnetwork has no available private IP addresses. Add new VMs with minimum steps.
* **【論点抽出】**
* **主体**: IPが枯渇した既存サブネット
* **目的**: IPレンジの拡張
* **制約**: 最小ステップ


* **【コンセプト】**: 箱を広げる ➔ **Modify subnet range**。VPCピアリングなどは工数が多いため「毒」。
* **【結論】**: **Modify the existing subnet range**


---


#### **Q47: gcloudのデフォルトゾーン設定**

* **【元の文】**: Avoid manually specifying the zone every time you run a gcloud command.
* **【論点抽出】**
* **主体**: gcloud CLI
* **目的**: デフォルト値の固定
* **制約**: 効率化


* **【コンセプト】**: コンフィグ設定 ➔ **gcloud config set compute/zone**。
* **【結論】**: **gcloud config set compute/zone**


---


#### **Q48: Jenkinsの最速導入**

* **【元の文】**: Automate Jenkins installation as quickly and easily as possible.
* **【論点抽出】**
* **主体**: 開発用Jenkins
* **目的**: 迅速かつ簡単な導入
* **制約**: 自動化


* **【コンセプト】**: 出来合いのものを利用 ➔ **Google Cloud Marketplace**。
* **【結論】**: **Google Cloud Marketplace**


---


#### **Q49: 部門別請求の確実な分離**

* **【元の文】**: Ensure Marketing team is billed ONLY for their services for a new app.
* **【論点抽出】**
* **主体**: マーケティング部門
* **目的**: 請求の厳密な分離
* **制約**: 組織内管理


* **【コンセプト】**: 請求の箱（Account）を分ける ➔ **新プロジェクト作成 ➔ マーケティング専用の請求先アカウントに紐付け**。
* **【結論】**: **Link new project to a dedicated Marketing Billing Account**



---

#### **Q50: 大規模ライドシェアのDB**

* **【元の文】**: Ride-sharing app storing trip/fare data. High volume transactions worldwide. Analytics team needs SQL queries.
* **【論点抽出】**
* **主体**: 大規模・グローバルなトランザクションデータ
* **目的**: 高可用性 / 高頻度書き込み
* **制約**: **SQLクエリによる分析が必要**


* **【コンセプト】**: グローバル強整合性 ➔ **Cloud Spanner**。
* **【結論】**: **Multi-region Cloud Spanner**

---

# 🛡️ Google Cloud LB 決定版：AAで覚える交通整理

#### **1. Application LB (L7) = 「有能なコンシェルジュ」**

URLの中身（パス）を見て、世界中の最適なサーバーへ案内します。

```text
 [ ユーザー ]  [ ユーザー ]  [ ユーザー ]
      ＼          ｜          ／
    　 ----------------------
      |  Global Anycast IP  | <--- 世界中どこでも1つの窓口
       ----------------------
                ｜
         [ Google Front End ] <--- ユーザーのすぐ近くでSSL接続(Snappy!)
                ｜
         /--------------\
        |  L7 Routing    | <--- 「動画(Path)はあっち、画像はこっち」
         \--------------/
          /     ｜     \
    [US-VM]  [EU-VM]  [Asia-VM]

```

* **キーワード**: **HTTP(S)**, **URLマップ/パスベース**, **グローバル**, **SSL終端**, **Cloud Armor (WAF)**
* **試験のツボ**: 「動画開始を速く(Snappy)」「URLで振り分け」ならこれ。

---

#### **2. Network LB (L4) = 「高速道路の料金所」**

中身は見ません。IPとポートだけ見て、爆速でパケットを右から左へ流します。

```text
      [  ユーザー  ]
            ｜
     ----------------
     | Regional IP  | <--- リージョンごとに設置
     ----------------
            ｜
     [ L4 Passthrough ] <--- パケットの中身をいじらない！
            ｜
     ----------------
     | クライアントIP | <--- 送信元の住所がそのままサーバーに届く
     |   そのまま保持  |
     ----------------
            ｜
      [  Backend VM  ]

```

* **キーワード**: **TCP/UDP**, **クライアントIP保持**, **パススルー**, **高スループット**, **リージョン内**
* **試験のツボ**: 「非HTTP（ポート389等）」「クライアントIPをそのままサーバーに伝えたい」ならこれ。

---

### 📊 ACE試験用：LB選択のクイックチャート

| 質問 | YES | NO |
| --- | --- | --- |
| **HTTP(S)通信ですか？** | ➔ **Application LB** | ➔ Network / Proxy LB |
| **URLのパスで振分けますか？** | ➔ **Application LB** | ➔ Network LB |
| **クライアントIP保持が必須？** | ➔ **Network LB** | ➔ Application LB |
| **世界中から低遅延で繋ぐ？** | ➔ **Global** (ALB/Proxy) | ➔ Regional (NLB) |

---

### 💡 PMO的・デフラグ思考

* **Q4（動画）**: ユーザーが世界中 ➔ **Global**、動画開始を速く ➔ **Application LB (SSL終端)**。
* **Q44（金融）**: ポート389 ➔ **L4**、IP保持が必須 ➔ **Network LB**。

---


# 🛡️ GKE ：　Deployment vs StatefulSet：AAで見る決定的な違い

#### **1. Deployment = 「兵隊（使い捨て）」**

Webサーバーなどに使います。個別の名前に意味はなく、死んでも別の奴が代わりに立てばOK。

```text
 [ Pod-xyz ]   [ Pod-abc ]   [ Pod-123 ]
      |             |             |
      ＼           ／            ／
       [ 共有ストレージ ]  <--- みんな同じデータを見る or データを持たない

```

* **特徴**: 名前がランダム。順序なし。

#### **2. StatefulSet = 「専門職（背番号付き）」**

データベース（PostgreSQL, MySQL）に使います。**「0番は0番のディスク」**という紐付けが絶対に切れません。

```text
 [ Pod-0 ] <------> [ Disk-0 ]  (Master)
 [ Pod-1 ] <------> [ Disk-1 ]  (Replica A)
 [ Pod-2 ] <------> [ Disk-2 ]  (Replica B)

```

* **特徴**:
* **固定の名前**: `db-0`, `db-1` と数字がつく。
* **永続ディスクとの一対一の絆**: Podが再起動しても、必ず同じディスクを掴み直す（データ損失防止）。
* **起動順序**: 0番が起動完了してから1番が起動する。



---

### 💡 GKEにおける「論点」の組み合わせ

Q5の問題文には2つの要求がありました。これに対する「GKEの標準的な回答」は以下の通りです。

1. **データ損失防止** ➔ **StatefulSet** ＋ **Persistent Disk**
* Podが消えても、背番号（インデックス）を頼りにデータを保持し続ける。


2. **ノードの自動拡張** ➔ **Cluster Autoscaler**
* トラフィック増でPodが増え、ノードのCPU/メモリが足りなくなったら、GKEが自動でCompute Engine（ノード）を継ぎ足す。

---

### 🗣️ PMO的・デフラグ思考

試験で「GKE」と「データベース」というキーワードが出てきたら、反射的にこう考えてください。

> **「DBは『状態（State）』があるから、背番号が必要。だから StatefulSet。
> 　ノードが足りなくなるなら、インフラを足すから Cluster Autoscaler。」**

Deployment（D）を選んでしまうと、「Podが入れ替わった時にDBのデータがどっか行った！」という大事故になるため、ACE試験では**「毒」**として扱われます。

---


# 🗣️ 「コンテナ流通の掟」

> **「イメージを作ったら、まずは 倉庫（Registry）へ！ GCS（バケット）に置くのは『毒』！」**
> **「動かす時は Deployment（デプロイメント）！ Pod（ポッド）を直接作るのは『毒』！」**

#### **なぜ GCS (A, B) は「毒」なのか？**

* **理由**: GCSは単なる「ファイル置き場」です。GKEは「コンテナ専用の倉庫（Artifact Registry / Container Registry）」としかスムーズに会話できません。

#### **なぜ Deployment なのか？**

* **理由**: Podを直接作ると、死んだ時に生き返りません。**Deployment** という「管理職」を立てることで、Podが死んでも自動で復活（セルフヒーリング）させてくれます。

---

### 🛡️ コンテナ流通のAA図（可視化）

```text
 [ 開発PC ] ➔ ( Build & Push ) 
      ｜
 [ Artifact Registry ] <--- ★専用の倉庫（ここが正解！）
      ｜
      ｜ ( Pull )
      ↓
 [ GKE Cluster ]
      ｜
 [ Deployment ] <--- ★管理職（「Podを3つ維持せよ」と命令）
      ｜
  +---+---+
  ↓   ↓   ↓
 [P] [P] [P] <--- 実際の働き手（Pod）

```

---

### 💡 試験での「見極め」チートシート

| アクション | 正解のキーワード | 毒（NG）キーワード |
| --- | --- | --- |
| **イメージの保管** | **Artifact Registry** / Container Registry | Cloud Storage (GCS) |
| **GKEでの実行** | **Deployment** / StatefulSet | Pod (直接作成), Node |

---

# 🗣️ 声に出して覚える「ノードプール最適化の掟」

> **「重い処理は 専用エンジン（Compute-optimized）！ 軽い仕事は 標準エンジン（General-purpose）！」**
> **「一つのプールに詰め込むのは『毒』！ 性能もコストも、プールを分けて最適化！」**

#### **なぜ「混ぜるな危険」なのか？**

* **理由**: すべてを「高性能なノード」で動かすと、軽いタスクに無駄なコスト（高い料金）がかかります。逆に、すべてを「標準ノード」にすると、重い処理（画像処理など）が詰まってシステムが死にます。

---

### 🛡️ ノードプール分離のAA図：可視化

```text
 [ GKE クラスター ]
      ｜
      ＋--- [ ノードプール A ] (Compute-optimized / C2)
      ｜      ｜  ➔  [ Pod: 画像処理 ] (CPUをガッツリ使う)
      ｜      ｜      ※高いけど速い！
      ｜
      ＋--- [ ノードプール B ] (General-purpose / E2)
              ｜  ➔  [ Pod: 定常タスク ] (メモリもCPUもそこそこ)
                      ※安いし、これで十分！

```

---

### 💡 試験での「見極め」チートシート

| 要求スペック | 推奨マシンタイプ | 役割 |
| --- | --- | --- |
| **High CPU / 計算重点** | **Compute-optimized (C2系)** | 画像処理、科学計算、動画エンコード |
| **High Memory / 大容量メモリ** | **Memory-optimized (M2系)** | SAP、インメモリデータベース |
| **Routine / バランス型** | **General-purpose (E2 / N2系)** | Webサーバー、バッチ処理 |
| **格安 / 停止OK** | **Spot VMs (旧Preemptible)** | 開発環境、一時的な分散処理 |

---

### 🗣️ PMO的・夜の「ととのい」メモ

「85万案件」のコスト削減コンサルなら、この提案が一番効きます。

> **「全ての業務を高級車で運ぶ必要はありません。重い荷物はトラック（C2）、軽い手紙は軽自動車（E2）。ノードプールを分けるだけで、パフォーマンスを落とさずコストを20〜30%削れます。」**

---

### 🗣️ 本日の「最終・最終」音読

> **「適材適所は、ノードプールの切り分け！
> 計算は C2、ふだんは E2、コストは 最小！」**

---



### 🛡️ IAM：プロジェクトを跨ぐ権限のAA図

```text
 [ Project A (保管元) ]              [ Project B (利用元) ]
          |                                  |
 [ Artifact Registry ]               [ GKE Cluster ]
          |                                  |
          | <--- (Pull) --- [ GKE Node (Compute Engine VM) ]
          |                        |
          |           [ サービスアカウント (SA) ] <--- ★コイツが実行犯
          |                        |
    (権限チェック) ------------------/
          |
    [ Artifact Registry Reader ] 
    ※ Project A側でSAに対して付与

```

---

### 💡 この問題の「デフラグ」ポイント

#### **1. 「誰に」：GKEノードのSA**

GKEの各ノードは実態として「Compute Engine VM」です。このVMにはデフォルト、またはカスタムの**サービスアカウント（SA）**が紐付いています。コンテナをプルするのはこのSAの仕事です。

#### **2. 「どこで」：Project A（リソースがある場所）**

権限は「鍵を貸す」行為なので、**リソース（Artifact Registry）を持っている側**のプロジェクトで、Project BのSAに対して「見ていいよ（Reader）」と許可を出します。

#### **3. なぜ他が「毒」なのか？**

* **JSONキー（サービスアカウントキー）**: キーをダウンロードしてGKEに登録すれば動きますが、キーの漏洩リスクと管理負荷（更新作業）が発生するため、Googleは推奨しません。ACE試験では「Google-recommended」や「Best Practice」があれば、**キーを使わない方法**が正解です。
* **Project Bに権限付与**: 自分の家（Project B）で「隣の家の冷蔵庫を開けていい権限」を自分に付与しても意味がありません。許可は隣の家（Project A）からもらう必要があります。

---

### 🗣️ PMO的・暗記のコツ

ACE試験で「Project AのものをProject Bで使いたい」という問題が出たら：

> **「動くやつ（SA）を特定して、そいつを『貸して』と相手のプロジェクトにお願い（IAM付与）しに行く」**

これが最小権限かつセキュアな最短ルートです。

---

# 🛡️ GKEストレージの「パーツ選び」AA図

この問題は、以下の3つのパーツを組み合わせて見積もりを作る必要があります。

#### **1. 爆速の作業場：Local SSD (高IOPS)**

とにかく「今、この瞬間」の処理速度を稼ぐためのパーツです。

```text
  [   GKE Node (VM)   ]
  |                   |
  |  [ Local SSD ] <------- ノードに「直挿し」された爆速ディスク
  |     (高IOPS!)     |      (※ノードを消すと中身も消える)
  ---------------------

```

* **キーワード**: **High IOPS**, 低レイテンシ。

#### **2. データの保管庫：Persistent Disk (永続ディスク)**

ノードが消えてもデータが残る、標準的なストレージです。

```text
  [   GKE Node (VM)   ]
          |
          | (ネットワーク経由)
          ↓
  [ Persistent Disk ] <---- データを「永続的」に保存する場所

```

* **キーワード**: データ保持。

#### **3. 万が一の備え：Snapshot (バックアップ)**

保管庫の中身を「ある時点」で丸ごと保存した、安価なバックアップデータです。

```text
  [ Persistent Disk ]
          |
      (コピー) ➔ [ Snapshot Storage ] <---- 「バックアップ」の実体

```

* **キーワード**: **Backups**, 災害復旧。

---

### 💡 なぜこの「3点セット」が正解なのか？

問題文の「制約」をパーツに当てはめると、自動的に答えが決まります。

* **制約A: "High IOPS"** ➔ **Local SSD** が必要。
* **制約B: "Backups"** ➔ **Snapshot storage** が必要。
* **制約C: "Disk storage"** ➔ スナップショットを撮るための元データとなる **Persistent Disk** が必要。

この3つが揃っていない選択肢は、要件を満たせないため「毒」となります。

---

### 🗣️ PMO的・デフラグ思考

現場（旭化成など）でコスト試算を頼まれたとき、こう説明できるとプロフェッショナルです。

> **「リアルタイム処理の速度を出すために『Local SSD』、データを永続化するために『Persistent Disk』、そして保守用のバックアップとして『Snapshot』。この3階層でコストを見積もります。」**

---






# 🛠️ ACE試験：gcloudコマンド「一撃必殺」リスト

#### **1. 認証・設定（環境づくり）**

* **`gcloud auth login`**: 自分のGoogleアカウントで認証。
* **`gcloud config set project [ID]`**: 操作対象のプロジェクトを切り替える。
* **`gcloud config set compute/zone [ZONE]`**: デフォルトのゾーンを固定する（**Q47の正解**）。
* **`gcloud config list`**: 現在の設定（プロジェクトIDやゾーン）を確認する。

#### **2. コンピューティング（Compute Engine / VM）**

* **`gcloud compute instances create [NAME]`**: VMを作る。
* **`gcloud compute instances stop/start [NAME]`**: VMの停止・起動（**Q24のコスト節約**）。
* **`gcloud compute ssh [NAME]`**: VMにログイン（IAPを使う場合は `--tunnel-through-iap`）。
* **`gcloud compute reset-windows-password [NAME]`**: Windowsのパスワード生成（**Q7の正解**）。

#### **3. API・サービス管理**

* **`gcloud services list`**: **有効化済み**のAPI一覧を表示（**Q12の正解**）。
* **`gcloud services list --available`**: 有効・無効問わず、**利用可能**な全APIを表示（**試験の「毒」選択肢**）。
* **`gcloud services enable [SERVICE]`**: APIを有効化する。

#### **4. コンテナ・GKE（kubectlとの違いに注意）**

* **`gcloud container clusters create [NAME]`**: GKEクラスターを作成する。
* **`gcloud container clusters get-credentials [NAME]`**: `kubectl` を使えるように認証情報を取得する。
* **`kubectl get pods / describe pod`**: Podの状態確認（**Q21の正解**）。※これだけ `kubectl` コマンド。

#### **5. ログ・診断**

* **`gcloud logging read "[FILTER]"`**: ログを表示。
* **`gcloud app logs tail`**: App Engineのログをリアルタイム表示。

---

### 💡 ACE試験攻略の「型」

試験問題で `gcloud` が出たときは、以下の**「否定形（毒）」**に注意してください。

1. **`gcloud services list --available`**
* ➔ 「有効なものだけ」と言われたら、`--available` は不要（全部出ちゃうから）。


2. **`gcloud compute instances delete`**
* ➔ 「コストを抑えて、後で再開したい」なら `stop` です。`delete` はデータ（ローカルSSD等）が消えるので「毒」。


3. **`gcloud app deploy [ファイル名]`**
* ➔ デプロイはフォルダ指定や `app.yaml` が基本。



---


承知いたしました。AA（アスキーアート）をフル活用して、視覚的に「複製」の概念を脳に焼き付けます。

ACE試験における「複製」の論点は、**Snapshot（縦の保存）**か、**Image（横の展開）**かを見極めるだけです。

---

# 🛡️ 複製の論点：Snapshot vs Image（AA決定版）

#### **1. Snapshot（スナップショット）＝「時間の静止画」**

「バックアップ」や「パッチ適用前の保険」として使います。

```text
       [  稼働中のVM  ]
              |
      ( 3/10 14:00の状態 )
              |
      [  Snapshot A  ]  <--- 「今の状態」をパシャッと氷漬け！
              |
              | ( 1時間後にアプリがクラッシュ！ )
              |
      [  Snapshot A  ]  から元のディスクへ「巻き戻し」

```

* **ACEでの合言葉**: 「バックアップ」「パッチ適用前」「ディスクの時点保存（Point-in-time）」
* **現場のPMO一言**: 「リリース作業の前にスナップショット撮っといて。何かあったら戻せる（リストア）ように。」

#### **2. Custom Image（カスタムイメージ）＝「量産用の金型」**

「量産（スケーリング）」や「標準化」のために使います。

```text
       [  理想のVM  ]
              |
      ( OS/設定/アプリ完備 )
              |
       [ Custom Image ] <--- 「黄金のテンプレート」を作成！
              |
    ----------+----------+----------
    |                    |         |
    ↓ (量産開始！)        ↓         ↓
 [ VM-Copy-01 ]   [ VM-Copy-02 ]   [ VM-Copy-03 ]

```

* **ACEでの合言葉**: **「Scale effectively（効率的なスケーリング）」**「複製」「標準化」「インスタンス作成」
* **現場のPMO一言**: 「基本設定が済んだらイメージ化して。他のプロジェクトでもこの『金型』からデプロイできるように。」

---

### 💡 Q16の「デフラグ」思考（AA版）

* **問題の状況**: 既に「金型（Custom Image）」が手元にある。
* **目的**: 効率的に複製を増やしたい。

```text
 【非効率なルート（A, B）＝ 毒】
 [ Image ] ➔ [ VM ] ➔ [ Snapshot ] ➔ [ VM作成 ]
 ※ 金型があるのに、わざわざ中間の「写真」を撮るのは無駄。

 【最短ルート（D）＝ 正解】
 [ Image ] ➔ [ VM作成 ]
 ※ 金型から直接製品（インスタンス）をプレスするだけ。

```

---



# 🛡️ 共有VPCの可視化：ネットワークの「配線貸し」

共有VPCを使わない場合、各プロジェクトに独自の「道路」があり、繋ぐのが大変です。
共有VPCを使うと、以下のようになります。

```text
  [ 組織（Organization） ]
           |
  =========================================
  ||  [ ホストプロジェクト（Host Project） ] ||
  ||  （ネットワーク管理者の部屋）          ||
  ||                                     ||
  ||   [ 共有VPCネットワーク ] <-----------++--- 広大な共通の道路
  ||      |           |                  ||   (10.0.0.0/16)
  ||   [サブネットA] [サブネットB]          ||
  ==================+===========+==========
                    |           |
          配線を伸ばす |           | 配線を伸ばす
                    |           |
  ------------------+---     ---+------------------
  | [ サービスPJ - A ] |     | [ サービスPJ - B ] |
  | （アプリ開発Aの部屋）|     | （アプリ開発Bの部屋）|
  |                    |     |                    |
  |   [ VM A ] <-------+     +------> [ VM B ]    |
  |  (10.0.1.5)        |     |       (10.0.2.8)   |
  ----------------------     ----------------------
          ↑                           ↑
    リソース（VM）は            リソース（VM）は
    開発PJに置いたまま          開発PJに置いたまま

```

---

### 💡 共有VPCの「論点」デフラグ

1. **リソースは寄せない（分散管理）**
* 各チーム（サービスプロジェクト）は、自分たちのプロジェクト内でVMやGKEクラスターを作成・管理します。
* これにより、**「課金」や「管理権限」をチームごとに切り離したまま**にできます。


2. **IPアドレスだけ共有（一元管理）**
* VMが使うプライベートIPは、ホストプロジェクトが管理する「共有VPC」のサブネットから割り当てられます。
* そのため、**VM A と VM B は別プロジェクトですが、同じLAN内にいるように**セキュアに通信できます。


3. **なぜ「作り直し」は毒なのか？**
* 既存のVPCを共有VPCに「後から合体」させることはできません。
* **「共有VPCの配線に繋ぎ直した新しいVM」**を作る必要があるため、試験や実務では「最初から共有VPCを設計しておく」のがベストプラクティスとされます。



---

### 🗣️ PMO的・決め台詞

もし現場（旭化成など）で「共有VPCって、リソースを全部1つのプロジェクトにまとめること？」と聞かれたら、こう答えてください。

> **「いいえ、管理の境界（プロジェクト）は分けたまま、ネットワークという土台だけを共有します。これにより、チームの独立性を保ちつつ、セキュアな相互通信を実現できるんです。」**

---

# 🗣️ 声に出して覚える「IAPの掟」

> **「公開IP（外の顔）がなくても、IAP（トンネル）で中に入る！」**
> **「踏み台（Bastion）はもう古い！ 認証（Identity）で直接SSH！」**

#### **なぜ IAP が最強なのか？**

* **理由1**: **「公開IP」が不要**。＝ 外部からの直接攻撃を受ける窓口を完全に閉じることができます。
* **理由2**: **「踏み台サーバー」が不要**。＝ 踏み台自体のパッチ当てや管理コスト（PMOが嫌うムダ）をゼロにできます。
* **理由3**: **「Googleアカウント」で制御**。＝ IAM権限がある人だけが、Googleの暗号化されたトンネルを通ってVMに届きます。

---

### 🛡️ IAP（トンネル）のAA図：可視化

```text
 [ あなたのPC ] (gcloud compute ssh --tunnel-through-iap)
      ｜
      ｜ ( HTTPS / 443ポートで通信 )
      ↓
 [ Identity-Aware Proxy ] <--- Googleの最強の門番
      ｜  ( 「お前は本人か？」をIAMでチェック )
      ↓
 [   VPC 内部   ]
      ｜
      ｜ ( 内部ネットワークを通る )
      ↓
 [  Linux VM  ] <--- ★公開IPなし (Private IPのみ)
   ( 22ポート )

```

---

### 💡 試験での「見極め」チートシート

| シチュエーション | 正解のキーワード | 毒（NG）キーワード |
| --- | --- | --- |
| **「公開IPなし」でSSH** | **IAP (TCP forwarding)** | Bastion Host (踏み台), VPN |
| **接続に必要なFWルール** | **35.235.240.0/20** からの許可 | 0.0.0.0/0 (全開放) |

---

### 🗣️ PMO的・夜の「ととのい」メモ

「85万案件」で、セキュリティに厳しいクライアント（金融や大手製造業など）には、このIAPを提案するのが鉄板です。

> **「踏み台サーバーを立てると、その管理コストがかさみます。GoogleのIAPを使えば、インフラ管理ゼロで、かつ強固な認証付きのSSH経路が作れます。」**

この「管理コスト削減 ＋ セキュリティ向上」のセット提案は、まさにACE試験が求めている「最適解」です。

---

### 🗣️ 本日の「フィニッシュ」音読

> **「IAP（アイエーピー）は、秘密のトンネル！
> 公開IPなし、踏み台なし、リスクなし！」**

---

# 🗣️ 声に出して覚える「HA VPNの掟」

> **「止まらないVPNなら HA VPN（エイチエー・ブイピーエヌ）！」**
> **「道を教え合うのは Cloud Router（クラウド・ルーター）の BGP（ビージーピー）！」**

#### **なぜ「Cloud Router / BGP」なのか？**

* **理由**: ネットワークの道順（ルート）を手書き（静的）で設定するのは、変更のたびにミスが起きる「毒」です。**BGP** というプロトコルを使えば、障害時に Cloud Router が「こっちの道はダメだから、あっちの道を通れ！」と自動で切り替えてくれます。

---

### 🛡️ HA VPN + BGP のAA図：可視化

```text
 [ Google Cloud VPC ]
          |
  [ Cloud Router ] <--- ★ナビゲーター (BGPで道を交換)
          |
  +-------+-------+
  | (Tunnel 0)    | (Tunnel 1)  <--- 常に2本のトンネルで冗長化
  +-------+-------+
          |
          | ( インターネット経由 )
          |
  [ オンプレミス GW ] <--- データセンターの玄関

```

---

### 💡 試験での「見極め」チートシート

| 要求スペック | 正解のキーワード | 理由 |
| --- | --- | --- |
| **高可用性 (99.99%)** | **HA VPN** | 標準で2本のトンネルを持つから。 |
| **動的ルーティング** | **Cloud Router / BGP** | 手動設定なしでルートを同期するから。 |
| **オンプレ接続** | **VPC Custom Mode** | IP帯域が重ならないよう自分で設計するから。 |

---

# 🗣️ 声に出して覚える「情報の隠し場所」

> **「ファイルに書けば ログに残る！ 環境変数なら ログに残らない！」**
> **「大事なパスワードは `config set` するな！ `export`（環境変数）でメモリに載せろ！」**

#### **なぜ「環境変数」なのか？**

* **理由**: `gcloud config set ...` を実行すると、その値は設定ファイル（ディスク）に書き込まれ、さらに実行時の履歴（コマンドログ）にも残ってしまいます。**環境変数（CLOUDSDK_PROXY_...）**を使えば、そのセッションの間だけメモリ上で有効になり、ファイルやログに足跡を残しません。

---

### 🛡️ 秘匿のAA図：可視化

```text
 【ダメな例：ログに残る「毒」】
 [ コマンド入力 ] ➔ gcloud config set proxy/password "SECRET123"
      ｜
 [ 設定ファイル ] ➔ディスクに保存（丸見え！）
      ｜
 [ CLIログ ]     ➔履歴に保存（丸見え！）


 【良い例：セキュアな正解】
 [ 環境変数 ] ➔ export CLOUDSDK_PROXY_PASSWORD="SECRET123"
      ｜
 [ メモリ上 ] ➔ gcloudが実行時だけ「こっそり」参照
      ｜
 [ CLIログ ] ➔ ログには何も残らない（クリーン！）

```

---

### 💡 試験での「見極め」チートシート

| 操作 | ログ・ファイルへの影響 | セキュリティ評価 |
| --- | --- | --- |
| **gcloud config set ...** | **残る** (configファイルに永続化) | ❌ 低い (共有PC等で危険) |
| **環境変数 (CLOUDSDK_...)** | **残らない** (一時的なメモリ保持) | ✅ 高い (推奨) |
| **コマンド引数 (--password)** | **残る** (シェル履歴に残る) | ❌ 危険 |

---
