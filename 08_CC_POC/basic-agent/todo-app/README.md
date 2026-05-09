# Todo App

A minimal TODO app built with Next.js, TypeScript, and Tailwind CSS.

## Features

- Add, complete, and delete TODO items
- Client-side state management with React hooks

## Getting Started

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Project Structure

```
src/app/
├── layout.tsx              # Root HTML wrapper
├── page.tsx                # Top-level page (Server Component)
├── globals.css             # Tailwind CSS import
└── components/
    ├── TodoList.tsx        # State management + renders list (Client Component)
    ├── TodoItem.tsx        # Single TODO item with toggle/delete (Client Component)
    └── TodoForm.tsx        # Input form for adding TODOs (Client Component)
```

## Tech Stack

- [Next.js](https://nextjs.org/) (App Router)
- TypeScript
- Tailwind CSS
