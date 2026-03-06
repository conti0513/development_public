# Case Study 05  
## Identity and Device Management Support Framework  
(Microsoft 365 / Entra ID / Intune / SSO)

---

## Overview

This project involved providing technical support within a large telecommunications group supporting enterprise customers.

My role functioned as a **Level 2 technical escalation point**, supporting both presales and operational support teams.

The focus areas included:

- Microsoft 365
- Entra ID identity platform
- Intune device management
- SAML / SSO integration

The goal was to help frontline teams resolve technical issues by organizing underlying system behaviors and operational constraints.

---

## Role

Responsibilities included supporting both presales and post-sales operations.

Typical responsibilities:

- validating technical feasibility during presales discussions
- analyzing authentication and device behavior issues
- identifying root causes through log analysis
- documenting reproducible troubleshooting procedures

Rather than directly interacting with customers, the role focused on **technical clarification behind customer-facing teams**.

---

## Environment

Industry: Telecommunications (enterprise customer support)

Key technologies:

- Microsoft 365
- Entra ID
- Microsoft Intune
- SAML / SSO integrations
- Salesforce (case tracking)

The support model involved multiple layers:

- presales engineers
- frontline support teams (L1)
- technical escalation support (L2)

---

## Challenges

Cloud adoption significantly increased the complexity of identity and device management environments.

Common challenges included:

- identity federation issues
- device enrollment inconsistencies
- SSO configuration errors
- unclear responsibility boundaries between support layers

Frontline teams required technical guidance to diagnose and resolve these issues efficiently.

---

## What I Did

### Presales Support

During the presales phase:

- reviewed technical feasibility of proposed architectures
- identified potential limitations early
- suggested alternative approaches when necessary

This helped prevent technical issues from appearing after deployment.

---

### Post-Sales Technical Analysis

For operational issues escalated from frontline support:

- investigated identity and authentication behavior
- analyzed system logs
- identified reproducible failure conditions
- clarified configuration constraints

This allowed frontline teams to resolve incidents more quickly.

---

### Knowledge Base Development

To reduce repeated escalations, common operational procedures were documented.

Examples included:

- troubleshooting steps
- configuration validation checklists
- small operational scripts

The objective was to allow frontline teams to operate more independently.

---

## Support Architecture

```mermaid
graph TD

Sales[Sales / Presales] --> PoC[Technical Validation]

PoC --> Delivery[Implementation]

Delivery --> L1[Frontline Support]

L1 --> L2[Technical Escalation (L2)]

L2 --> Analysis[Log Analysis / Behavior Investigation]

Analysis --> Knowledge[Documentation / Automation]

Knowledge --> Entra[Entra ID]

Knowledge --> Intune[Intune Device Management]

Knowledge --> SSO[SAML / SSO Integration]
````

---

## Outcome

The support structure helped:

* reduce escalation frequency
* clarify identity and authentication behavior
* improve frontline troubleshooting capability
* support stable enterprise identity environments

---

## Technical Perspective Gained

This experience provided deeper insight into:

* enterprise identity architecture
* operational realities of SSO systems
* the difference between **configuration correctness** and **operational sustainability**

These perspectives later influenced how I approach cloud architecture and identity system design.

---
