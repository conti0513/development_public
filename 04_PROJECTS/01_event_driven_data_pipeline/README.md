# Event-Driven Data Pipeline and External SFTP Integration  
(GCP / Serverless / Terraform)

## Overview

This document summarizes architecture patterns for integrating Google Cloud serverless workloads with external systems such as SFTP / FTPS servers.

The examples focus on real-world constraints frequently encountered in enterprise environments:

- outbound IP address restrictions
- credential management limitations
- stateless serverless execution
- operational recovery and reprocessing

The goal of this document is to describe a practical architecture that maintains security, reproducibility, and operational simplicity.

---

# Example 01  
## Serverless Integration with External SFTP / FTPS

### Problem

A serverless workload must transfer files to an external SFTP / FTPS environment while satisfying the following constraints:

- outbound IP address must be fixed
- credentials must not be embedded in application code
- workloads must remain stateless
- failures must allow easy retry and rollback

These conditions are common when integrating cloud services with legacy or external enterprise systems.

---

### Architecture Approach

The following architecture was designed to satisfy the above requirements.

**Key components**

- Cloud Run (serverless compute)
- VPC Connector
- Cloud NAT (fixed outbound IP)
- SFTP client implemented in Go

---

### Key Design Points

**Controlled outbound connectivity**

Cloud Run traffic is routed through a VPC connector and exits via Cloud NAT, allowing the external system to whitelist a static IP address.

**Stateless processing**

The application performs only lightweight file processing and transfer.  
No internal state is maintained, allowing easy redeployment or retry.

**Credential handling**

Private keys and authentication material are not embedded in the container image or application source.

---

### Operational Considerations

**Infrastructure as Code**

Infrastructure resources are managed using Terraform to ensure reproducibility across environments.

**Configuration separation**

Environment-specific parameters such as destination paths and user IDs are externalized into configuration files (JSON), allowing redeployment without code changes.

---

### Architecture Diagram

```mermaid
graph LR
    subgraph GCP
        CR[Cloud Run] --> VC[VPC Connector]
        VC --> NAT[Cloud NAT - Static Outbound IP]
    end
    NAT --> EXT[External SFTP / FTPS Server]
````

---

# Example 02

## Event-Driven Data Processing and Delivery

### Problem

Data exported from analytical systems must be processed and delivered to external environments automatically.

Key requirements:

* event-driven execution
* idempotent processing
* simple operational recovery
* minimal operational overhead

---

### Processing Flow

1. Data is exported from **BigQuery** on a scheduled basis
2. A file is written to **Cloud Storage**
3. **Eventarc** triggers **Cloud Run** when the file is uploaded
4. Processing is performed (e.g., encoding conversion such as SJIS)
5. The processed file is transferred to an external SFTP server

---

### Architecture Considerations

**Idempotency**

Processing can be safely re-executed by re-uploading the file.

**Stateless execution**

The application does not maintain internal processing state.

**Operational logging**

Application and system logs are centralized in **Cloud Logging** to simplify troubleshooting and operational review.

**Error handling**

Failures are recorded in logs and can be reprocessed without complex recovery procedures.

---

### Architecture Diagram

```mermaid
graph TD
    BQ[(BigQuery)] -->|Scheduled Export| GCS[Cloud Storage]
    GCS -->|Eventarc Trigger| CR[Cloud Run]
    CR -->|File Processing| SFTP[External SFTP Server]
    CR -.->|Error| LOG[Cloud Logging]
    LOG -.->|Operational Notes| NOTE[Recovery Documentation]
```

---

# Design Principles

Across these examples, the following principles were prioritized.

**Reproducibility**

All environments should be reproducible from CLI and IaC.

**Minimal credential exposure**

Authentication material should not be duplicated across systems.

**Operational simplicity**

Systems should recover through redeployment or retry rather than complex manual procedures.

---

# Notes

This document summarizes architectural patterns derived from personal experience and technical exploration.

It does not represent any specific organization or production environment.

```

---