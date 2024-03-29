# DIR構成
development_private
 ├──.gitignore
 ├──.git
 ├──tutorial_blog
 ├──tutorial_php_michael  
 ├──webkatsu_infra
 ├──webkatsu_php
 ├──README.md



# 運用方法
・mainブランチとissueに応じたfeatureブランチで運用



# 運用の流れ

1 GitHubで、リポジトリのイシュータブを開き、新しいイシューを作成
　イシューには、新しい機能の説明や必要なタスクのリストなど、作業に必要な情報を記載

2 イシューの詳細に応じて、新しいブランチを作成
　「feature/イシュー番号」という名前
　ex) イシュー番号が1の場合、ブランチ名は「feature/1」
　このブランチを作成すると、現在のブランチが自動的にその新しいブランチに切り替わる

3 ローカルで必要な変更を行い、コミット
　ブランチでの作業は、イシューに記載されたタスクに基づいて行われるべき

4 新しいブランチをリモートにプッシュ
　これにより、他の人がこのブランチを参照できるようになります。

5 作業が完了したら、GitHubで新しいプルリクエストを作成
　このプルリクエストには、新しい機能の説明や必要なテスト、コードレビューを依頼する人など、必要な情報を記載
　プルリクエストを作成すると、関連するイシューに自動的にリンクが追加される

6 レビュワーがプルリクエストを確認し、必要に応じてコメントを追加
　コードの変更が必要な場合は、その変更を行い、再度コミット

7 レビュワーが承認したら、マージ


# issueと連動したブランチを作りたい

1 GitHub上で、該当のリポジトリの「Issues」タブから、対象のIssueを選択

2 Issueのページ上で、「Branchを作成」ボタンをクリック
　「Branch名」欄に、新しく作成するブランチの名前を入力
　ex) 「fix-123」

「Create branch」ボタンをクリックします。

3 ローカル環境にリポジトリをクローンします。
  git fetch    # リモートリポジトリの情報を更新
  git checkout # 作成したブランチに切り替え

---





テンプレート
# My Awesome Project

## Overview

My Awesome Project is a project that does something amazing.

## Features

- Feature 1: Does something amazing
- Feature 2: Does something even more amazing
- Feature 3: You won't believe what it does

## Installation

To install My Awesome Project, follow these steps:

1. Clone the repository: `git clone https://github.com/username/my-awesome-project.git`
2. Install the dependencies: `npm install`
3. Run the project: `npm start`

## Usage

To use My Awesome Project, follow these steps:

1. Open the project in your favorite text editor
2. Make some changes to the code
3. Run the project: `npm start`

## Contributing

To contribute to My Awesome Project, follow these steps:

1. Fork the repository
2. Create a new branch: `git checkout -b my-feature-branch`
3. Make some changes to the code
4. Push the branch to your forked repository: `git push origin my-feature-branch`
5. Create a pull request

## License

My Awesome Project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

