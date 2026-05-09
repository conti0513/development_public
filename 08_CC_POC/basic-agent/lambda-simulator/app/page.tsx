"use client";

import { useEffect, useState } from "react";
import type { LambdaFunction } from "./api/functions/route";
import type { InvokeLog } from "./api/invoke/route";
import FunctionPanel from "./components/FunctionPanel";
import InvokePanel from "./components/InvokePanel";
import LogViewer from "./components/LogViewer";

export default function Home() {
  const [functions, setFunctions] = useState<LambdaFunction[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [logs, setLogs] = useState<InvokeLog[]>([]);

  useEffect(() => {
    fetch("/api/functions").then((r) => r.json()).then((data) => {
      setFunctions(data);
      if (data.length > 0) setSelectedId(data[0].id);
    });
    fetch("/api/logs").then((r) => r.json()).then(setLogs);
  }, []);

  const selectedFn = functions.find((f) => f.id === selectedId) ?? null;

  return (
    <div className="min-h-screen bg-gray-900 text-white flex flex-col">
      <header className="border-b border-gray-700 px-6 py-3 flex items-center gap-3">
        <span className="text-orange-400 text-xl">λ</span>
        <h1 className="text-sm font-semibold tracking-wide">Lambda Simulator</h1>
        <span className="text-gray-500 text-xs ml-auto">Node.js runtime — in-memory</span>
      </header>

      <div className="flex flex-1 overflow-hidden">
        <aside className="w-56 border-r border-gray-700 p-4 overflow-y-auto">
          <FunctionPanel
            functions={functions}
            selectedId={selectedId}
            onSelect={setSelectedId}
            onCreated={(fn) => {
              setFunctions((prev) => [...prev.filter((f) => f.id !== fn.id), fn]);
              setSelectedId(fn.id);
            }}
            onDeleted={(id) => {
              setFunctions((prev) => prev.filter((f) => f.id !== id));
              if (selectedId === id) setSelectedId(null);
            }}
          />
        </aside>

        <main className="flex-1 p-4 overflow-y-auto border-r border-gray-700">
          <InvokePanel
            selectedFn={selectedFn}
            onInvoked={(log) => setLogs((prev) => [log, ...prev])}
          />
        </main>

        <aside className="w-80 p-4 overflow-y-auto">
          <LogViewer logs={logs} />
        </aside>
      </div>
    </div>
  );
}
