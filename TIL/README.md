# Today I Learned (TIL)

## Overview
Welcome to the **Today I Learned (TIL)** repository!
This repository is a collection of concise notes on various topics that I have learned each day.
It serves as a personal learning journal and a way to share knowledge with others.

## Structure
The repository is organized by date in a nested folder structure.
Each day has its own Markdown file containing the learnings of that day.

```
entries/
├── 2024/
│   ├── 07/
│   │   ├── 2024-07-01.md
│   │   ├── 2024-07-02.md
│   │   ├── ...
│   │   └── 2024-07-31.md
│   └── ...
└── ...
```

## Sample Entry

Here is an example of what a typical entry looks like:

```
# Today I Learned

## 2024-07-05

### Today's Learnings
- UoPeople ENGL0008 Unit 4 Learning Guide
- Unit 4 Self-Quiz
- Created a TIL (Today I Learned) repository and Setting up



## Setup Instructions
Note: Steps 1-4 are only for the first time.

1. Create a GitHub Account
   - Go to the GitHub official site (https://github.com) and create an account.

2. Create a TIL Repository
   - Sign in to GitHub, click on the "+" icon in the upper right corner, and select "New repository".
   - Name the repository "TIL" and enter the necessary information, then click "Create repository".

3. Set Up Local Repository
   - If Git is not installed, download and install it from the [Git official site](https://git-scm.com/).
   - Open the terminal and run the following commands to clone the repository:
     ```sh
     git clone <GitHub repository URL>
     cd TIL
     ```

4. Add Daily Outputs
   - Create new directories and files for the date. For example, to create an entry for July 5, 2024:
     ```sh
     mkdir -p entries/2024/07
     echo "# Today I Learned" > entries/2024/07/2024-07-05.md
     ```
   - Open the file in your text editor and write what you learned that day.

5. Commit Changes
   - In the terminal, run the following commands to commit the changes:
     ```sh
     git add entries/2024/07/2024-07-05.md
     git commit -m "Add TIL for 2024-07-05"
     ```

6. Push to Remote Repository
   - Run the following command to push the changes to the remote repository:
     ```sh
     git push origin main
     ```

## Make Daily Outputs a Habit

- Daily Reminders
  - Use a calendar app or reminder app to set reminders for writing your daily TIL entries.

- Consistent Commits
  - Write at least one TIL entry each day, then commit and push using the steps above.

## Additional Tips

- File Structure
  - Customize the file structure to suit your needs. For example, you can create directories for different categories.

- Using Markdown
  - Writing in Markdown makes the entries easy to read on GitHub. Refer to the [Markdown Guide](https://www.markdownguide.org/) for basic syntax.
```
---

Happy learning and sharing!
```
