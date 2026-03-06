# Monitoring Automation Case  
## Auto Scaling and Event-driven Incident Notification

## Overview

This case describes operational improvements for a web hosting platform used for advertising campaign sites.

Traffic spikes during campaign launches frequently caused service instability.  
To address this, an **event-driven monitoring and notification system** was implemented.

The architecture combined:

- AWS Auto Scaling
- CloudWatch monitoring
- Lambda-based notification workflows

---

## Architecture

```mermaid
graph TD

Users --> ALB[Application Load Balancer]

ALB --> ASG[Auto Scaling Group]

ASG --> EC2[EC2 Instances]

EC2 --> Metrics[CloudWatch Metrics]

Metrics --> Alarm[CloudWatch Alarm]

Alarm --> Lambda[AWS Lambda]

Lambda --> Notify[Sales Team Notification]
````

---

## Monitoring Targets

Key metrics included:

* CPU utilization
* memory usage
* disk usage
* ALB health checks
* HTTP 5xx errors

---

## Notification Design

Campaign sites were managed by subdomain.

Example:

```
aa.example.com
bb.example.com
campaign-x.example.com
```

A routing table was used to identify the responsible sales representative for each domain.

The Lambda function performed:

1. identify affected domain
2. retrieve customer and sales owner
3. generate alert message
4. notify sales team

---

## Operational Improvements

Before

```
Customer detects issue
↓
Sales contacted
↓
Engineering investigates
```

After

```
CloudWatch detects anomaly
↓
Lambda sends alert
↓
Sales team immediately informed
↓
Engineering response initiated
```

---

## Outcome

* faster incident detection
* reduced recovery time
* improved campaign stability
* improved coordination between engineering and sales teams

---

## Key Technical Elements

* AWS Auto Scaling
* Application Load Balancer
* CloudWatch monitoring
* Lambda-based event automation

```

---
