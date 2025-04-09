function exportToFormattedSheet() {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const summarySheet = ss.getSheetByName('Summary');
    const exportSheet = ss.getSheetByName('Export');
  
    const values = summarySheet.getRange('D2:M110').getValues();
    exportSheet.clearContents();
    exportSheet.getRange(1, 1, values.length, values[0].length).setValues(values);
  
    Logger.log('Exported formatted data from Summary to Export sheet.');
  }
  