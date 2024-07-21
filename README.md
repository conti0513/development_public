# Development Public Repository

## Overview
This repository contains various projects and tutorials related to different technologies, including Python, Docker, PowerShell, PHP, and infrastructure projects.

## Structure
The repository is organized into different directories for each topic. Here's a brief overview of the structure:
- infra_pjt: Infrastructure projects, including EC2 and WordPress setups.
- tutorial_PowerShell: PowerShell scripts and tutorials.
- tutorial_docker: Docker-related projects and scripts.
- tutorial_php: PHP tutorials and scripts.

## Submodules
This repository includes the TIL (Today I Learned) repository as a submodule. The TIL submodule contains daily learning entries and documentation. You can find the TIL repository at the following URL:

https://github.com/conti0513/TIL

### Adding the TIL Submodule
To add the `TIL` repository as a submodule, the following commands were used:

```bash
git submodule add https://github.com/conti0513/TIL.git tutorial_sh/TIL
git submodule init
git submodule update

```bash
git submodule status
