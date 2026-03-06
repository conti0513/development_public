# Case Study 03  
## Corporate IT Operations Modernization  
(Microsoft 365 / Active Directory / Automation)

## Overview

This case study describes operational improvements implemented within a rapidly growing healthcare technology company.

As the organization expanded, IT operations became increasingly dependent on manual processes and individual knowledge.  
The goal of this project was to transition these operations into **structured and repeatable workflows**.

The focus was not on introducing complex technologies, but on establishing operational processes that could scale with the organization.

---

## Role

My role involved organizing and stabilizing corporate IT operations, including:

- identity management processes
- device provisioning workflows
- SaaS access management
- operational documentation and standardization

The primary objective was to reduce operational risk while maintaining business continuity.

---

## Environment

Industry: Healthcare / Medical Technology  
Organization stage: Rapid growth phase

Core technologies included:

- Microsoft 365
  - Entra ID
  - SharePoint
  - Power Automate
- On-premises Active Directory
  - Hybrid identity configuration with Entra ID

Automation and operational tooling:

- PowerShell
- Google Apps Script (HR integration)
- Microsoft Deployment Toolkit (MDT)

---

## Challenges

Rapid organizational growth created several operational challenges:

- account provisioning depended on individual operators
- device setup relied on manual processes
- password and credential management lacked structure
- governance and DLP considerations were not clearly defined

The IT team needed to introduce operational improvements **without interrupting ongoing business operations**.

---

## What I Did

The approach focused on structuring operational workflows rather than introducing heavy system changes.

Key improvements included:

- organizing identity lifecycle processes
- establishing repeatable device provisioning workflows
- connecting HR information with identity provisioning processes
- documenting operational procedures for knowledge transfer

Automation was used selectively to reduce repetitive work while maintaining operational transparency.

---

## Operational Architecture Overview

The operational structure centered around HR information triggering identity and device management workflows.

```mermaid
graph LR
    subgraph Input
        HR[HR Database / Spreadsheet]
    end

    subgraph Automation
        Script[PowerShell / Google Apps Script]
        Script --> ID[Identity Provisioning]
        Script --> MDT[Device Deployment]
    end

    subgraph Platform
        ID --> Entra[Entra ID]
        Entra --> SaaS[SharePoint / SaaS Applications]
        MDT --> PC[PC Provisioning]
    end
````

This structure allowed identity creation and device provisioning to follow consistent operational rules.

---

## Security and Governance Considerations

Operational design considered realistic governance requirements rather than theoretical security models.

Key considerations included:

* minimal permission assignment
* password-based authentication aligned with existing policies
* SharePoint data loss prevention considerations
* clearly defined credential storage and access rules

The goal was to achieve **practical security improvements within the organization's operational capabilities**.

---

## Operational Design Principles

Several operational principles guided the project.

### Document Everything

Automation scripts and operational procedures were documented to ensure knowledge transfer.

### Maintain Partial Automation

Not every process was fully automated.
Manual steps were retained where necessary, but clearly documented.

### Design for Handover

The operational model assumed that IT personnel would change over time, requiring processes to remain understandable and maintainable.

---

## Outcome

The improvements resulted in several operational benefits:

* reduced workload for routine account management tasks
* simplified device provisioning processes
* fewer operational errors and support requests

Operational workload was estimated to decrease by approximately **30–50%** in routine identity and device management tasks.

---

## Multi-Company Support Perspective

The IT organization supported multiple healthcare-related companies within the same corporate group.

The design therefore prioritized:

* shared operational standards
* flexible identity and device management processes
* avoiding overly specialized configurations for a single company

---

## Notes

This project represents an example of improving IT operations through **process structure rather than technology complexity**.

It reinforced the importance of viewing IT operations as a system of processes rather than isolated tasks.

---

## Summary

> Structuring previously ad-hoc IT operations into repeatable and sustainable operational workflows.

````

---

# README.md（短い概要）

03のREADMEはこうしておくと  
**ポートフォリオとして綺麗です。**

```md
# IT Process Automation

Operational improvement project for corporate IT infrastructure in a growing healthcare organization.

Focus areas included:

- Microsoft 365 operations
- identity lifecycle management
- device provisioning automation
- operational workflow standardization

See detailed documentation:

- [CASE_STUDY.md](./CASE_STUDY.md)
````

