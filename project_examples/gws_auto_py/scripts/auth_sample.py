# scripts/auth_sample.py

"""
🔐 Google Workspace Auth Sample (OAuth / Service Account)
This script checks connectivity to Gmail and Google Drive using either:
- OAuth credentials (for user-level operations)
- Service Account credentials (for backend/system operations)
"""

import os
import json
from google.oauth2 import service_account
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build

# === Config ===
USE_SERVICE_ACCOUNT = False  # ← True にすると Service Account を使う
SCOPES = [
    'https://www.googleapis.com/auth/gmail.readonly',
    'https://www.googleapis.com/auth/drive.metadata.readonly'
]
SERVICE_ACCOUNT_FILE = 'service_account.json'
OAUTH_CLIENT_SECRET_FILE = 'credentials.json'
OAUTH_TOKEN_FILE = 'token.json'


def get_credentials():
    if USE_SERVICE_ACCOUNT:
        creds = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_FILE,
            scopes=SCOPES
        )
    else:
        if os.path.exists(OAUTH_TOKEN_FILE):
            from google.oauth2.credentials import Credentials
            creds = Credentials.from_authorized_user_file(OAUTH_TOKEN_FILE, SCOPES)
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                OAUTH_CLIENT_SECRET_FILE, SCOPES)
            creds = flow.run_local_server(port=0)
            # Save the credentials
            with open(OAUTH_TOKEN_FILE, 'w') as token:
                token.write(creds.to_json())
    return creds


def check_gmail(creds):
    print("📩 Checking Gmail API...")
    service = build('gmail', 'v1', credentials=creds)
    profile = service.users().getProfile(userId='me').execute()
    print(f"✅ Gmail authenticated as: {profile['emailAddress']}")


def check_drive(creds):
    print("📁 Checking Drive API...")
    service = build('drive', 'v3', credentials=creds)
    results = service.files().list(pageSize=5).execute()
    files = results.get('files', [])
    print("✅ Drive files fetched:")
    for f in files:
        print(f" - {f['name']} ({f['id']})")


if __name__ == '__main__':
    creds = get_credentials()
    check_gmail(creds)
    check_drive(creds)
