# Lambda Simulator

A browser-based AWS Lambda simulator built with Next.js. Write, deploy, and invoke JavaScript functions locally — no AWS account needed.

## Features

- Register JavaScript functions (`exports.handler` style)
- Invoke functions with custom JSON event payloads
- View execution logs with duration and error output
- Sandboxed execution via Node.js `vm` module

## Getting Started

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Usage

1. Select a function from the left panel (a sample `hello-world` is preloaded)
2. Edit the JSON event payload in the center panel
3. Click **Invoke** to execute
4. View results and execution time in the right log panel

To add a new function, click **+ New**, enter a name and write your handler code, then click **Deploy**.

## Project Structure

```
app/
├── api/
│   ├── store.ts          # Shared in-memory function registry
│   ├── functions/        # GET / POST / DELETE functions
│   ├── invoke/           # POST — execute a function in vm sandbox
│   └── logs/             # GET execution history
├── components/
│   ├── FunctionPanel.tsx # Left: function list + create/delete
│   ├── InvokePanel.tsx   # Center: event input + invoke button
│   └── LogViewer.tsx     # Right: execution log stream
└── page.tsx              # Root layout — three-column UI

```

## Tech Stack

- [Next.js](https://nextjs.org/) (App Router)
- TypeScript
- Tailwind CSS
- Node.js `vm` module (sandboxed function execution)
