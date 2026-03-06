# Project A
## SQL Monitoring and Failure Detection

### Overview

Implemented monitoring scripts that analyzed SQL Server logs to detect failures and processing interruptions.

When abnormal events were detected, alerts were automatically generated and sent to the operations team.

### Architecture

```text
SQL Server
│
▼
Log / Error Output
│
▼
Monitoring Script (Shell)
│
▼
Alert System
│
▼
Operations Team
````

### Technologies

* SQL
* Shell scripting
* Linux
* monitoring automation

---

# Project B

## User Data Analysis and Extraction

### Overview

SQL queries were used to extract and analyze operational data from user management databases.

The extracted data supported operational reporting and infrastructure deployment tracking.

### Architecture

```text
User Database
│
▼
SQL Query
│
▼
Microsoft Access
│
▼
Analysis / Reporting
```

### Technologies

* SQL
* Microsoft Access
* operational data analysis

---

# Project C

## Redmine Infrastructure Deployment (MySQL)

### Overview

Built and operated a self-hosted Redmine project management environment including database configuration.

Responsibilities included database setup, application configuration, and operational maintenance.

### Architecture

```text
Users
│
▼
Redmine (Ruby on Rails)
│
▼
MySQL Database
│
▼
Linux Server
```

### Technologies

* MySQL
* Ruby on Rails
* Linux
* middleware configuration

---

# Project D

## BigQuery Event-Driven Data Pipeline

### Overview

Designed and implemented a cloud-based data processing pipeline using Google Cloud services.

The system automated data extraction, transformation, and transfer to an external legacy system.

### Business Problem

Previously the data transfer process relied on manual operations:

```text
Manual Export
↓
Local Storage
↓
Shared Folder
↓
External System Processing
```

This resulted in:

* operational mistakes
* processing delays
* high operational workload

### Improved Architecture

An **event-driven cloud pipeline** was introduced.

```text
BigQuery
│
│ Scheduled Query
▼
Cloud Storage
│
│ Event Trigger
▼
Cloud Function / Cloud Run
│
│ Data Transform
▼
FTPS Transfer
│
▼
Legacy System
```

### Data Flow

```text
BigQuery
↓
SQL Extraction
↓
CSV Generation
↓
Cloud Storage
↓
Event Trigger
↓
Python / Go Processing
↓
Encoding Conversion
↓
FTPS Transfer
```

### Technologies

* Google BigQuery
* SQL
* Python
* Go
* Cloud Functions
* Cloud Run
* Google Cloud Storage
* event-driven architecture

---

# Technical Perspective

Across these projects, SQL was not used in isolation.

Instead it was integrated into broader **data pipeline architecture**, combining:

```text
Data
↓
Cloud Platform
↓
Automation
↓
External System Integration
```

This experience established a foundation for designing **cloud-native data processing systems and automated data integration pipelines**.

```

---
