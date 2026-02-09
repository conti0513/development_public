/**
 * 📦 CONFIG – Environment settings for Gmail/GCS integration
 */
const CONFIG = {
    gmailQuery: 'subject:"CSV Report"',
    targetExtension: '.csv',
    fileNameKeyword: 'CSV Report',
    bucketName: 'your_gcs_bucket_name',
    gcsFolderPath: 'your/folder/path/',
    driveFolderId: 'your_google_drive_folder_id'
  };
  
  /**
   * 📥 Main function: Extract latest matching CSV and upload to GCS + Drive
   */
  function saveLatestCsvToGCSAndDrive() {
    const threads = GmailApp.search(CONFIG.gmailQuery);
    if (threads.length === 0) return;
  
    const csvFiles = [];
  
    threads.forEach(thread => {
      thread.getMessages().forEach(message => {
        message.getAttachments().forEach(file => {
          const name = file.getName();
          if (
            name.toLowerCase().endsWith(CONFIG.targetExtension) &&
            name.includes(CONFIG.fileNameKeyword)
          ) {
            csvFiles.push({
              blob: file.copyBlob(),
              name: name,
              date: message.getDate()
            });
          }
        });
      });
    });
  
    if (csvFiles.length === 0) return;
  
    csvFiles.sort((a, b) => b.date - a.date);
    const latestFile = csvFiles[0];
    const latestPath = CONFIG.gcsFolderPath + latestFile.name;
  
    const uploadSuccess = uploadToGCS(latestFile.blob, CONFIG.bucketName, latestPath);
  
    // Optionally save to Drive
    // saveToDrive(latestFile.blob, latestFile.name);
  
    if (uploadSuccess) {
      deleteOldFilesInGCS(CONFIG.bucketName, CONFIG.gcsFolderPath, latestFile.name);
    }
  }
  
  /**
   * ☁️ Upload file to GCS
   */
  function uploadToGCS(blob, bucket, path) {
    const url = `https://storage.googleapis.com/upload/storage/v1/b/${bucket}/o?uploadType=media&name=${encodeURIComponent(path)}`;
    const options = {
      method: 'POST',
      contentType: blob.getContentType(),
      payload: blob.getBytes(),
      headers: {
        Authorization: 'Bearer ' + ScriptApp.getOAuthToken()
      }
    };
    const response = UrlFetchApp.fetch(url, options);
    return [200, 201].includes(response.getResponseCode());
  }
  
  /**
   * 🧹 Delete old files in GCS (except latest)
   */
  function deleteOldFilesInGCS(bucket, prefix, keepFileName) {
    const listUrl = `https://storage.googleapis.com/storage/v1/b/${bucket}/o?prefix=${encodeURIComponent(prefix)}`;
    const listOptions = {
      method: 'get',
      headers: {
        Authorization: 'Bearer ' + ScriptApp.getOAuthToken()
      }
    };
    const response = UrlFetchApp.fetch(listUrl, listOptions);
    const files = JSON.parse(response.getContentText()).items || [];
  
    files.forEach(file => {
      const fileName = file.name.split('/').pop();
      if (fileName !== keepFileName) {
        const deleteUrl = `https://storage.googleapis.com/storage/v1/b/${bucket}/o/${encodeURIComponent(file.name)}`;
        const deleteOptions = {
          method: 'delete',
          headers: {
            Authorization: 'Bearer ' + ScriptApp.getOAuthToken()
          }
        };
        UrlFetchApp.fetch(deleteUrl, deleteOptions);
      }
    });
  }
  
  /**
   * 🗂 Save to Drive as backup (optional)
   */
  function saveToDrive(blob, fileName) {
    const folder = DriveApp.getFolderById(CONFIG.driveFolderId);
    folder.createFile(blob).setName(fileName);
  }
  
  /**
   * 🔐 Trigger OAuth authorization for first-time setup
   */
  function authorizeStorageAccess() {
    const token = ScriptApp.getOAuthToken();
    const response = UrlFetchApp.fetch("https://www.googleapis.com/storage/v1/b", {
      headers: {
        Authorization: "Bearer " + token
      }
    });
    Logger.log("Auth Test Response: " + response.getContentText());
  }
  