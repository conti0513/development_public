import subprocess
import logging
import os
from datetime import datetime

# 日付を取得してフォーマット
current_date = datetime.now().strftime("%Y%m%d")

# ログディレクトリのパスを指定
log_dir = '/workspaces/development_public/tutorial_python/projects/updatelog'
os.makedirs(log_dir, exist_ok=True)

# ログファイル名を指定
log_file = os.path.join(log_dir, f'update_system_{current_date}.log')

# ログ設定
logging.basicConfig(filename=log_file, level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def update_system():
    # 実行するコマンドのリスト
    commands = [
        ["sudo", "apt-get", "update", "-y"],
        ["sudo", "apt-get", "upgrade", "-y"],
        ["sudo", "apt-get", "autoremove", "-y"],
        ["sudo", "apt-get", "clean"]
    ]

    for command in commands:
        try:
            # コマンドをログに記録
            logging.info(f"Running command: {' '.join(command)}")
            # コマンドを実行
            subprocess.run(command, check=True)
            # コマンドが成功したことをログに記録
            logging.info(f"Command succeeded: {' '.join(command)}")
        except subprocess.CalledProcessError as e:
            # コマンドが失敗した場合、エラーをログに記録
            logging.error(f"Command failed: {' '.join(command)}. Error: {e}")

if __name__ == "__main__":
    update_system()
    print(f"System update completed. Check {log_file} for details.")

