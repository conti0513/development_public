"use client";

import { useState } from "react";
import type { LambdaFunction } from "../api/functions/route";
import type { InvokeLog } from "../api/invoke/route";

type Props = {
  selectedFn: LambdaFunction | null;
  onInvoked: (log: InvokeLog) => void;
};

export default function InvokePanel({ selectedFn, onInvoked }: Props) {
  const [eventJson, setEventJson] = useState('{\n  "key": "value"\n}');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleInvoke() {
    if (!selectedFn) return;
    setError(null);

    let event: unknown;
    try {
      event = JSON.parse(eventJson);
    } catch {
      setError("Invalid JSON");
      return;
    }

    setLoading(true);
    const res = await fetch("/api/invoke", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ functionId: selectedFn.id, event }),
    });
    const log: InvokeLog = await res.json();
    setLoading(false);
    onInvoked(log);
  }

  return (
    <div className="flex flex-col gap-3">
      <h2 className="text-sm font-semibold text-gray-400 uppercase tracking-wider">Invoke</h2>

      {!selectedFn ? (
        <p className="text-gray-500 text-sm">Select a function to invoke</p>
      ) : (
        <>
          <div className="bg-gray-800 rounded px-3 py-2 text-orange-400 text-sm font-mono">
            λ {selectedFn.name}
          </div>

          <div className="flex flex-col gap-1">
            <label className="text-xs text-gray-400">Event (JSON)</label>
            <textarea
              className="bg-gray-800 text-white text-xs font-mono rounded px-2 py-1 outline-none h-28 resize-none"
              value={eventJson}
              onChange={(e) => setEventJson(e.target.value)}
            />
          </div>

          {error && <p className="text-red-400 text-xs">{error}</p>}

          <button
            onClick={handleInvoke}
            disabled={loading}
            className="bg-green-600 hover:bg-green-700 disabled:opacity-50 text-white text-sm rounded py-2"
          >
            {loading ? "Invoking..." : "▶ Invoke"}
          </button>

          <div className="flex flex-col gap-1">
            <label className="text-xs text-gray-400">Code</label>
            <pre className="bg-gray-800 text-gray-300 text-xs font-mono rounded px-3 py-2 overflow-auto max-h-40">
              {selectedFn.code}
            </pre>
          </div>
        </>
      )}
    </div>
  );
}
