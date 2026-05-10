# JTC Task CLI — Design Memo

## Problem

Information scattered across Teams / Email / verbal / SharePoint.
Excel-based task tracking failed due to high update cost → tasks dropped.

---

## Data Flow (AA)

```
[ Input Sources ]
  Teams chat ──┐
  Email ────────┼──► PS CLI (add-task / update-task / done)
  Verbal ──────┘         │
  SharePoint ────────────┘
                         │
                         ▼
                  [ tasks.json ]
          (local file, 1 file per project)

          {
            id, title, keywords[],
            teamsLink, spPath,
            deadline, dependsOn[],
            status: "open|done"
          }

                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
     list-tasks     filter-tasks    done <id>
   (全件一覧)      (keyword/期限)   (完了フラグ)
          │
          ▼
     コンソール出力 or CSV export
```

---

## CLI イメージ

```powershell
# タスク追加
add-task -title "FW設定確認" -keyword "SASE,FW" -deadline 2026-05-15 -sp "https://..."

# 一覧
list-tasks

# キーワード絞り込み
list-tasks -keyword "SASE"

# 期限が近いもの
list-tasks -soon 3   # 3日以内

# 完了
done 003

# 依存確認
list-tasks -blocked   # dependsOnが未完のもの
```

---

## 対話モード（インタラクティブCLI）

起動するとバナーを表示し、コマンド待ち受け状態になる。

```
========================================
  JTC Task CLI v1.0
========================================
  add     : タスク追加
  list    : 一覧表示
  find    : キーワード検索
  soon    : 期限が近いもの（日数指定）
  blocked : 前工程待ちのもの
  done    : 完了
  open    : TeamsリンクをブラウザまたはTeamsで開く
  exit    : 終了
========================================
>
```

コマンド例：

```
> add FW設定確認 SASE,FW 2026-05-15
> list
> find SASE
> soon 3
> done 003
> open 003   ← タスク003のTeamsリンクを即起動
```

---

## TeamsリンクのURLハンドリング

TeamsのチャットURLは非常に長い。以下の方針で対処する。

- **保存**: JSON内にそのまま文字列で保持（長さ制限なし）
- **表示**: 一覧では truncate して末尾を `...` で省略
- **呼び出し**: `open <id>` で `Start-Process` を実行 → ブラウザまたはTeamsアプリが起動

```
[003] FW設定確認 | 期限:05-15 | SASE,FW
      Teams: https://teams.microsoft.com/l/message/19:xxx... (truncated)

> open 003
→ Teamsアプリでチャットが開く
```

URLを目で読む必要がない。コピペで登録・`open`で呼び出すだけ。

---

## 運用フロー

```
朝：list-tasks -soon 3 で今日やること確認
　　　　│
情報入ってきたら即 add-task（口頭もその場で）
　　　　│
完了したら done <id>
　　　　│
夕：list-tasks で残件確認
```

---

## Trello との ROI 比較

| 観点 | Trello | JTC Task CLI (PS) |
|------|--------|-------------------|
| 導入 | ブラウザで即起動 | PS環境あれば即 |
| 入力コスト | ブラウザ開く→カード作る→項目埋める | 1行コマンド |
| JTC環境の制約 | 外部SaaSでブロックされる可能性あり | ローカル完結、制約なし |
| SharePointリンク管理 | 手動でカードに貼る | パラメータで構造化保存 |
| 工程依存の可視化 | Power-Up（有料）が必要 | dependsOn フィールドで対応 |
| 検索 | GUI検索 | grep / filter-tasks |
| 更新コスト | GUI操作（高い） | 1コマンド（低い） |
| オフライン | 不可 | 完全ローカル |
| カスタマイズ | 有料プランか諦め | PS自由に改造 |

**結論：JTC環境でTrelloは外部SaaSブロックと入力コストで詰む可能性が高い。**
PSはローカル完結・1行入力・JTC制約なしで優位。

---

## エラー設計方針

**基本方針：落ちない。エラーコードで原因を明示する。**

- 必須項目が空 → デフォルト値で補完してコマンド続行
- JSONが壊れてた → バックアップから復元を試みる
- 想定外のエラー → クラッシュさせず、エラーコードをコンソールに表示

朝活でエラーコードを検索して対処できるようにする。

### エラーコード一覧

| コード | 原因 | 対処 |
|--------|------|------|
| E001 | tasks.jsonが見つからない | 新規作成して続行 |
| E002 | tasks.jsonのパースに失敗 | バックアップから復元 |
| E003 | 指定IDのタスクが存在しない | メッセージ表示して続行 |
| E004 | deadlineの日付形式が不正 | 未設定として登録して警告 |
| E005 | dependsOnに存在しないIDを指定 | 警告のみ、登録は続行 |
| E006 | TeamsリンクのURLが開けない | URLをコンソールに表示して手動対処 |
| E007 | バックアップからの復元に失敗 | 空のtasks.jsonで初期化 |

### 実装イメージ

```powershell
try {
    $tasks = Get-Content tasks.json | ConvertFrom-Json
} catch {
    Write-Host "[E002] tasks.json の読み込みに失敗しました。バックアップから復元します。"
    # 復元処理
}
```

---

## 開発・運用体制

**CC（朝活・自宅）**
- 設計・実装・ロジックの構築
- エラーコード対応・デバッグ

**Copilot（JTC現場）**
- 軽微な修正・構文エラーの対処
- ハルシネーションが多いため、ロジック判断はしない

**現場でのエラー対処フロー：**

```
現場でエラー発生
      ↓
エラーコードをメモ
      ↓
軽い → Copilotで即対処
重い → 翌朝CCで解決
```

**前提確認済み：**
- JTC環境でPS起動・簡単なスクリプト動作を確認済み
- 権限（ExecutionPolicy）問題なし

---

## Status

Design phase. Not yet implemented.
