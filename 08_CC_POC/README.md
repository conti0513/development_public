# 08_CC_POC: AI Agent Driven Development Kit

## 概要 (Overview)
本ディレクトリは、Claude Codeを用いた自律型開発プロセスの研究用POCパッケージです。
GitHub Codespaces Secretsを活用したセキュアな開発環境を前提としています。

## セキュリティ & 運用 (Security)
- **Secrets Management:** APIキーは `.env` に直書きせず、GitHubの `Repository secrets` で管理します。
- **Portability:** Codespaces Secretsに `ANTHROPIC_API_KEY` を登録することで、どの環境からでも即座にCCを起動可能です。

## 使い方 (How to use)
1. GitHubの Settings > Codespaces > Secrets に `ANTHROPIC_API_KEY` を登録。
2. `sh setup.sh` を実行。
3. `claude` を起動。

---
*Note: This project prioritizes secure AI integration.*
