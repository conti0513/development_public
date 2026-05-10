# JTC Task CLI

JTC案件向けのPowerShell製タスク管理CLI。Excelベースの運用を置き換える。

## なぜ作るか

情報がTeams・メール・口頭・SharePointに散在し、キャッチしきれずタスクが落ちる。
Excelで管理しようとしたが更新コストが高く詰んだ。
このツールは**1行コマンドで即記録**することで、取りこぼしをなくす。

## 特徴

- **外部依存ゼロ** — .ps1ファイルのみ。npm install不要、DB不要
- **GitHubからDLして即使える** — PowerShellはWindows標準搭載
- **IT承認不要** — ローカル完結、外部SaaS不使用
- **1行入力** — 情報が来たその場でキャプチャできる

## 主なコマンド（予定）

```powershell
# タスク追加
add-task -title "FW設定確認" -keyword "SASE,FW" -deadline 2026-05-15

# 一覧表示
list-tasks

# キーワード絞り込み
list-tasks -keyword "SASE"

# 期限3日以内
list-tasks -soon 3

# 工程依存で止まってるもの
list-tasks -blocked

# 完了
done 003
```

## データ項目

| 項目 | 説明 |
|------|------|
| title | タスク名 |
| keywords | 関連キーワード（複数可） |
| teamsLink | 関連チャットのURL |
| spPath | SharePointのフォルダ/ファイルパス |
| deadline | 納期 |
| dependsOn | 前工程のタスクID |
| status | open / done |

## 動作環境

- PowerShell 5.1以上（Windows標準）
- 追加インストール不要

## ステータス

設計フェーズ。アーキテクチャ詳細は [DESIGN_MEMO.md](./DESIGN_MEMO.md) を参照。
