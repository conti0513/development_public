// 環境変数の定義
var CONFIG = {
    FOLDER_ID: 'your-folder-id',  // Google DriveのフォルダID
    FILE_NAME: 'invoice.pdf',     // 読み込む請求書PDFのファイル名
    OUTPUT_FILE_NAME: 'invoice_formatted.csv',  // 出力するCSVファイル名
    BILLING_KEYWORD: '請求額'  // 検索する請求額のキーワード
  };
  
  // メイン処理
  function processInvoice() {
    var text = extractTextFromPDF();  // PDFからテキストを抽出
    if (text) {
      var formattedData = formatInvoiceData(text);  // データをフォーマット
      saveCSV(formattedData);  // CSVとして保存
    }
  }
  
  // PDFのテキスト抽出
  function extractTextFromPDF() {
    var folder = DriveApp.getFolderById(CONFIG.FOLDER_ID);
    var files = folder.getFilesByName(CONFIG.FILE_NAME);  // PDFファイルを検索
  
    if (files.hasNext()) {
      var file = files.next();
      var blob = file.getBlob();
      
      // PDFをGoogle Docsとして一時的に開いてテキストを取得
      var doc = DocumentApp.openById(Docs.create(blob).getId());
      var text = doc.getBody().getText();
      
      Logger.log(text);  // テキストをログに出力（デバッグ用）
      
      // ドキュメントを削除
      DriveApp.getFileById(doc.getId()).setTrashed(true);
      
      return text;  // 抽出したテキストを返す
    } else {
      Logger.log(CONFIG.FILE_NAME + ' が見つかりませんでした。');
      return null;
    }
  }
  
  // データのフォーマット
  function formatInvoiceData(text) {
    // 請求額が含まれる行を抽出
    var lines = text.split('\n');  // テキストを行単位で分割
    var invoiceLines = lines.filter(function(line) {
      return line.includes(CONFIG.BILLING_KEYWORD);  // 設定されたキーワードを使用して行を抽出
    });
  
    // 請求額の合計を計算
    var totalAmount = invoiceLines.reduce(function(sum, line) {
      var amount = parseFloat(line.match(/([\d,\.]+)/)[0].replace(/,/g, ''));  // 請求額を抽出し数値に変換
      return sum + amount;
    }, 0);
  
    // マイナスの合計を計算
    var negativeTotal = -totalAmount;
  
    // ヘッダ行を追加
    var csvData = [
      ['請求額の合計', totalAmount + '円'],  // 1行目（正の値）
      ['請求額の合計（仕分けの消し込み用）', negativeTotal + '円']  // 2行目（負の値）
    ];
  
    // 請求額の各行をCSVデータに追加
    invoiceLines.forEach(function(line) {
      var columns = line.split(/\s+/);  // スペースで列を分割（請求書の実際のフォーマットに応じて調整）
      csvData.push(columns);
    });
  
    return csvData;
  }
  
  // CSVファイルとして保存
  function saveCSV(csvData) {
    var folder = DriveApp.getFolderById(CONFIG.FOLDER_ID);
    
    // CSVデータを文字列に変換
    var csvString = csvData.map(function(row) {
      return row.join(',');
    }).join('\n');
    
    // CSVファイルとして保存
    var file = folder.createFile(CONFIG.OUTPUT_FILE_NAME, csvString, MimeType.CSV);
    Logger.log('CSVファイルが作成されました: ' + file.getUrl());
  }
  