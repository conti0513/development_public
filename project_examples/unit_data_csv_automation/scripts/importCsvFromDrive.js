function importCsvFromDrive() {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const configSheet = ss.getSheetByName('Config');
    const outputSheet = ss.getSheetByName('RawData');
  
    const fileName = configSheet.getRange('B2').getValue();
    if (!fileName) throw new Error('Please enter a file name in cell B2 of Config sheet.');
  
    const files = DriveApp.getFilesByName(fileName);
    if (!files.hasNext()) throw new Error(`File "${fileName}" not found in Google Drive.`);
  
    const file = files.next();
    const blob = file.getBlob();
    const csv = Utilities.parseCsv(blob.getDataAsString('Shift_JIS')); // or 'UTF-8' if needed
  
    outputSheet.clearContents();
    outputSheet.getRange(1, 1, csv.length, csv[0].length).setValues(csv);
  
    Logger.log(`Imported CSV "${fileName}" into RawData sheet.`);
  }
  