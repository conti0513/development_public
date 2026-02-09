#!/bin/bash

# --- SPF Lookup Counter (Full Recursive & All Mechanisms) ---
# RFC 7208 Section 4.6.4 に基づき、DNS通信が発生する全要素をカウントします。

count_lookups() {
    local record="$1"
    local count=0
    
    # 1. ルックアップを発生させるメカニズムを抽出
    # include, a, mx, ptr, exists, redirect
    # 単体での "a" "mx" "ptr" も含めて抽出する正規表現
    local mechs=$(echo "$record" | grep -oE "((include|a|mx|ptr|exists)(:[^ ]+)?| (a|mx|ptr)( |$)|redirect=[^ ]+)")

    for mech in $mechs; do
        # 空白を除去
        mech=$(echo "$mech" | xargs)
        ((count++))
        
        # include または redirect の場合は、そのドメインのSPFをさらに引きに行く（再帰）
        if [[ $mech == include:* ]] || [[ $mech == redirect=* ]]; then
            local target_domain=$(echo "$mech" | cut -d':' -f2 | cut -d'=' -f2)
            
            # 外部ドメインのレコードを実際に引きに行く
            local sub_record=$(dig +short TXT "$target_domain" | grep "v=spf1" | head -n 1)
            
            if [[ -n "$sub_record" ]]; then
                # 再帰呼び出し
                local sub_count=$(count_lookups "$sub_record")
                count=$((count + sub_count))
            fi
        fi
    done
    echo "$count"
}

echo "--------------------------------------------------"
echo "SPFレコード解析 (RFC 7208 準拠チェック)"
echo "--------------------------------------------------"
read -p "SPF文字列を貼り付けてください: " USER_SPF

if [[ ! "$USER_SPF" =~ ^v=spf1 ]]; then
    echo -e "\033[31m[ERROR]\033[0m 有効なSPFレコードではありません。"
    exit 1
fi

echo -e "\n審判(受信サーバー)の視点で再帰ルックアップを計算中..."
TOTAL=$(count_lookups "$USER_SPF")

echo "--------------------------------------------------"
echo "結果: 合計 $TOTAL DNSルックアップ"

# RFC 7208 の制限値 10 に基づく判定
if [ "$TOTAL" -le 10 ]; then
    echo -e "\033[32m[PASS]\033[0m RFC 7208 Compliance: OK (10以下)"
    echo "解説: 受信サーバーは正常にこのレコードを処理できます。"
else
    echo -e "\033[31m[FAIL]\033[0m RFC 7208 Compliance: NG (10超え！)"
    echo "解説: 受信サーバーで PermError となり、メールが不達になるリスクが高いです。"
fi
echo "--------------------------------------------------"