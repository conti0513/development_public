# Operational Procedure Plan

## 1. Project Structure
Each project contains its own CI/CD workflow, Terraform configuration, Docker files, etc., within its respective directory. Workflows are independent for each project, and dependencies between projects are appropriately managed.

```

@conti0513 ➜ .../projects/infra_pjt/curation/hello-world (main) $ tree -I 'node_modules|.git|.next|coverage'
.
├── README.md
├── app
│   ├── favicon.ico
│   ├── globals.css
│   ├── layout.tsx
│   ├── page.tsx
│   └── page.tsx.bkup
├── next-env.d.ts
├── next.config.mjs
├── package-lock.json
├── package.json
├── postcss.config.mjs
├── public
│   ├── next.svg
│   └── vercel.svg
├── tailwind.config.ts
└── tsconfig.json

2 directories, 15 files

Summary of Development
Next.js Setup and Testing:

Successfully set up a Next.js project using npx create-next-app.
Tested the "Hello World" page by modifying the page.tsx file.
Managed Node.js system files effectively using .gitignore.
Utilized tree command to view the directory structure, excluding unnecessary system files.
Git Workflow:

Ensured that untracked files and changes are correctly managed using git status and .gitignore.
Development Details
Created a new Next.js application and initialized the environment.
Made modifications to the page.tsx file for a simple "Hello World" test.
Configured .gitignore to exclude node_modules/ and other unnecessary files from version control.
Used tree command with exclusion options to view the clean project structure.





## 2. CI/CD Workflow Setup

### 2.1 Workflow for Each Project
Each project has its own GitHub Actions workflow. This ensures that when changes are made to a specific project, only the workflow for that project is triggered.

### 2.2 Reusing Common Workflows
If there are processes shared across multiple projects, define them as a common workflow separately and call them from each project's workflow. This avoids duplication of settings.

```yaml
# Example of calling a common workflow
jobs:
  use-common-workflow:
    uses: ./.github/workflows/common_workflow.yml
```

## 3. Dependency Management

### 3.1 Documenting Dependencies
If there are dependencies between projects, clearly document these dependencies in the `README.md`. This helps ensure the correct order of builds and tests.

### 3.2 Managing Order
If there are dependent projects, manage their build order within the workflow and ensure the correct sequence for building or deploying.

```yaml
jobs:
  build-dependent-project:
    needs: build-project-a
```

## 4. Execution Steps

1. **Update the Code**: Make changes to the code within the project directory.
2. **Commit and Push**: Commit the changes locally and push them to the remote repository.
3. **Trigger the Workflow**: The GitHub Actions workflow corresponding to the pushed project will automatically trigger.
4. **Check the Build and Deployment**: Confirm the results of the workflow to ensure that the build and deployment were successful.

## 5. Maintenance

- **Updating Common Workflows**: When updating common workflows used by multiple projects, carefully check the impact on each project's workflow.
- **Managing Dependency Changes**: If there are changes in dependencies, update the `README.md` and reflect the changes in the workflow.

---

