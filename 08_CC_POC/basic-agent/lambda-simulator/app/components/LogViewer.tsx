"use client";

import type { InvokeLog } from "../api/invoke/route";

type Props = {
  logs: InvokeLog[];
};

export default function LogViewer({ logs }: Props) {
  return (
    <div className="flex flex-col gap-3">
      <h2 className="text-sm font-semibold text-gray-400 uppercase tracking-wider">
        Execution Logs
        <span className="ml-2 text-gray-600 font-normal normal-case">({logs.length})</span>
      </h2>

      {logs.length === 0 ? (
        <p className="text-gray-500 text-sm">No invocations yet</p>
      ) : (
        <ul className="flex flex-col gap-2">
          {logs.map((log) => (
            <li key={log.id} className="bg-gray-800 rounded p-3 text-xs font-mono flex flex-col gap-1">
              <div className="flex items-center justify-between">
                <span className={`font-semibold ${log.error ? "text-red-400" : "text-green-400"}`}>
                  {log.error ? "✗ ERROR" : "✓ OK"} — {log.functionName}
                </span>
                <span className="text-gray-500">{log.durationMs}ms</span>
              </div>
              <div className="text-gray-400 text-[10px]">{log.invokedAt}</div>
              {log.error ? (
                <div className="text-red-300 mt-1">{log.error}</div>
              ) : (
                <pre className="text-gray-300 mt-1 overflow-auto max-h-24">
                  {JSON.stringify(log.result, null, 2)}
                </pre>
              )}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
