請求書取込スクリプト

動作概要:
    Google Drive内のinvoice.pdfを読み込む。
    PDFのテキストデータを抽出し、環境変数で指定されたキーワード（例："請求額"）を含む行をフィルタリング。
    請求額の合計を計算し、2つのヘッダー行を追加:
    1行目: 「請求額の合計」 → 抽出した請求額の正の合計。
    2行目: 「請求額の合計（仕分けの消し込み用）」 → 抽出した請求額の負の合計。
    抽出したデータをフォーマットし、CSVファイルに出力。
    Google Driveにinvoice_formatted.csvとして保存。

README:
    目的:
        このプロジェクトは、Google Driveに保存されたPDF請求書を処理し、請求額を抽出して整形し、CSV形式でエクスポートするためのGoogle Apps Scriptです。

    要件:
        Google Driveフォルダ内にあるinvoice.pdfを読み込む。
        PDFからテキストデータを抽出し、環境変数で指定されたキーワード（例: "請求額"）を含む行のみをフィルタリング。
        請求額行の合計を計算し、以下のヘッダー行をCSVの1行目と2行目に追加する:
        ヘッダー1: 請求額の合計 → 抽出した請求額の合計（例: 5,000円）。
        ヘッダー2: 請求額の合計（仕分けの消し込み用） → 合計金額の負の値（例: -5,000円）。
        抽出された請求額の行をCSVに追加し、Google Driveにinvoice_formatted.csvとして保存する。

    環境変数の設定:
        以下のCONFIGオブジェクトを使って、環境に応じた設定を行います。

        javascript
        コードをコピーする
        var CONFIG = {
        FOLDER_ID: 'your-folder-id',  // Google DriveフォルダID
        FILE_NAME: 'invoice.pdf',     // 読み込むPDFファイル名
        OUTPUT_FILE_NAME: 'invoice_formatted.csv',  // 出力するCSVファイル名
        BILLING_KEYWORD: '請求額'  // 検索する請求額のキーワード
        };
        FOLDER_ID: Google Drive内のフォルダIDを指定します。
        FILE_NAME: 読み込む請求書PDFのファイル名を指定します。
        OUTPUT_FILE_NAME: 出力するCSVファイル名を指定します。
        BILLING_KEYWORD: 請求額を示すキーワードを指定します（例: "請求額"）。
        スクリプトの実行フロー:
        PDFの読み込み:

        Google Driveからinvoice.pdfを取得し、PDFをGoogle Docs経由でテキストとして読み込む。
        
    請求額行の抽出:

        テキストデータからCONFIG.BILLING_KEYWORDで指定されたキーワード（例: "請求額"）を含む行のみをフィルタリングし、請求額の合計を計算。
        ヘッダー行の追加:

        1行目に「請求額の合計」を、2行目に「請求額の合計（仕分けの消し込み用）」をそれぞれ表示。
    
    CSV出力:
    　　抽出された請求額行をCSVフォーマットに追加し、invoice_formatted.csvとしてGoogle Driveに保存。


