#!/bin/bash

# Create new directories
mkdir -p /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows
mkdir -p /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows
mkdir -p /workspaces/development_public/scripts

# Move files if they exist
[ -f /workspaces/development_public/infra_pjt/python_projects/project1/app.py ] && mv /workspaces/development_public/infra_pjt/python_projects/project1/app.py /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project1/app.py_bkup1 ] && mv /workspaces/development_public/infra_pjt/python_projects/project1/app.py_bkup1 /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project1/app.py_bkup2 ] && mv /workspaces/development_public/infra_pjt/python_projects/project1/app.py_bkup2 /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project1/requirements.txt ] && mv /workspaces/development_public/infra_pjt/python_projects/project1/requirements.txt /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project1/scripts/create_normal_workflow.sh ] && mv /workspaces/development_public/infra_pjt/python_projects/project1/scripts/create_normal_workflow.sh /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project1/scripts/create_rollback_workflow.sh ] && mv /workspaces/development_public/infra_pjt/python_projects/project1/scripts/create_rollback_workflow.sh /workspaces/development_public/infra_pjt/python_projects/project1/.github/workflows/

[ -f /workspaces/development_public/infra_pjt/python_projects/project2/app.py ] && mv /workspaces/development_public/infra_pjt/python_projects/project2/app.py /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project2/app.py_bkup ] && mv /workspaces/development_public/infra_pjt/python_projects/project2/app.py_bkup /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project2/requirements.txt ] && mv /workspaces/development_public/infra_pjt/python_projects/project2/requirements.txt /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project2/urls.csv ] && mv /workspaces/development_public/infra_pjt/python_projects/project2/urls.csv /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project2/scripts/create_normal_workflow.sh ] && mv /workspaces/development_public/infra_pjt/python_projects/project2/scripts/create_normal_workflow.sh /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows/
[ -f /workspaces/development_public/infra_pjt/python_projects/project2/scripts/create_rollback_workflow.sh ] && mv /workspaces/development_public/infra_pjt/python_projects/project2/scripts/create_rollback_workflow.sh /workspaces/development_public/infra_pjt/python_projects/project2/.github/workflows/

# Remove old scripts directories if they exist
[ -d /workspaces/development_public/infra_pjt/python_projects/project1/scripts ] && rm -rf /workspaces/development_public/infra_pjt/python_projects/project1/scripts
[ -d /workspaces/development_public/infra_pjt/python_projects/project2/scripts ] && rm -rf /workspaces/development_public/infra_pjt/python_projects/project2/scripts

# Confirm the new structure
echo "New directory structure:"
tree /workspaces/development_public

