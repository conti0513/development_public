# IP Design Tool

A web-based tool for network IP address design management, replacing manual Excel workflows.

## Problem

Network engineers currently manage IP address design in Excel, which causes:
- Manual overlap detection (error-prone)
- No visibility into mixed redundant/single-site configurations
- DHCP range management done by hand

## Planned Features

- **Subnet input**: site name, subnet (address/mask), purpose (WAN/LAN/management)
- **Redundancy flag**: mark each site as redundant or single
- **DHCP range management**: toggle on/off per subnet; auto-calculate range (e.g., /24 → 50 addresses)
- **Overlap detection**: warn on conflicting subnet assignments
- **Export**: generate design sheet (CSV/Excel)

## Data Model (Draft)

```ts
type SubnetEntry = {
  siteName: string;
  subnet: string;        // e.g. "192.168.1.0/24"
  purpose: "LAN" | "WAN" | "management";
  redundant: boolean;
  dhcp: {
    enabled: boolean;
    rangeSize?: number;  // number of addresses, e.g. 50
  };
};
```

## Tech Stack (Planned)

- Next.js (App Router) + TypeScript
- Tailwind CSS
- IP calculation: `ip-cidr` or `netmask` npm package
- Export: `xlsx` or CSV via browser download

## Status

Design phase. Not yet implemented.

## Target Use Case

Small to mid-size MSPs and SIers managing multi-site network designs with mixed redundancy configurations.
