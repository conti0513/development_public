「ディレクトリ内の全ファイル内容をファイル名付きで一覧表示するコマンド」
構成確認や一括レビューに便利です。

🇺🇸 English
"A command to list all file contents in a directory with filenames as headers."
Useful for structure checks and quick batch reviews.

find . -type f -exec echo "===== {} =====" \; -exec cat {} \;

---