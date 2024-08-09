#!/bin/zsh

# コピー元とコピー先のパスをハードコードで指定する
## コピー元
src_dir=~/Development/development_public/tutorial_docker/docker-LEMP/php/src

## コピー先
dest_dir=~/Development/src/docker-LEMP/php/

# コピー元のファイルが存在しない場合はエラーを表示して終了する
if [ ! -d "$src_dir" ]; then
  echo "コピー元のディレクトリが存在しません。"
  exit 1
fi

# コピー先のファイルが存在する場合は、更新日時を比較して上書きするかどうかの確認をする
if [ -d "$dest_dir" ]; then
  src_mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$src_dir")
  dest_mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$dest_dir")

  if [ "$src_mtime" != "$dest_mtime" ]; then
    read -p "コピー先のディレクトリはすでに存在します。上書きしますか？(Y/N): " confirm
    if [ "$confirm" != "Y" -a "$confirm" != "y" ]; then
      echo "コピーを中止しました。"
      exit 1
    fi
  fi
fi

# ディレクトリを再帰的にコピーする
cp -r "$src_dir" "$dest_dir"

# コピーが成功した場合に、メッセージを表示する
if [ $? -eq 0 ]; then
  echo "コピーが完了しました。"
fi
