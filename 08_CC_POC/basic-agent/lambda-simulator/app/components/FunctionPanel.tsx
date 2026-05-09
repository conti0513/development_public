"use client";

import { useState } from "react";
import type { LambdaFunction } from "../api/functions/route";

type Props = {
  functions: LambdaFunction[];
  selectedId: string | null;
  onSelect: (id: string) => void;
  onCreated: (fn: LambdaFunction) => void;
  onDeleted: (id: string) => void;
};

const DEFAULT_CODE = `exports.handler = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello!", event }),
  };
};`;

export default function FunctionPanel({ functions, selectedId, onSelect, onCreated, onDeleted }: Props) {
  const [newName, setNewName] = useState("");
  const [newCode, setNewCode] = useState(DEFAULT_CODE);
  const [creating, setCreating] = useState(false);

  async function handleCreate() {
    if (!newName.trim()) return;
    const res = await fetch("/api/functions", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name: newName, code: newCode }),
    });
    const fn = await res.json();
    onCreated(fn);
    setNewName("");
    setNewCode(DEFAULT_CODE);
    setCreating(false);
  }

  async function handleDelete(id: string) {
    await fetch("/api/functions", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ id }),
    });
    onDeleted(id);
  }

  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center justify-between">
        <h2 className="text-sm font-semibold text-gray-400 uppercase tracking-wider">Functions</h2>
        <button
          onClick={() => setCreating(!creating)}
          className="text-xs bg-orange-500 hover:bg-orange-600 text-white px-2 py-1 rounded"
        >
          + New
        </button>
      </div>

      {creating && (
        <div className="bg-gray-800 rounded p-3 flex flex-col gap-2">
          <input
            className="bg-gray-700 text-white text-sm rounded px-2 py-1 outline-none"
            placeholder="function-name"
            value={newName}
            onChange={(e) => setNewName(e.target.value)}
          />
          <textarea
            className="bg-gray-700 text-white text-xs font-mono rounded px-2 py-1 outline-none h-32 resize-none"
            value={newCode}
            onChange={(e) => setNewCode(e.target.value)}
          />
          <button
            onClick={handleCreate}
            className="bg-orange-500 hover:bg-orange-600 text-white text-xs rounded py-1"
          >
            Deploy
          </button>
        </div>
      )}

      <ul className="flex flex-col gap-1">
        {functions.map((fn) => (
          <li
            key={fn.id}
            className={`flex items-center justify-between rounded px-3 py-2 cursor-pointer text-sm ${
              selectedId === fn.id ? "bg-orange-500 text-white" : "bg-gray-800 text-gray-300 hover:bg-gray-700"
            }`}
            onClick={() => onSelect(fn.id)}
          >
            <span className="font-mono">{fn.name}</span>
            <button
              onClick={(e) => { e.stopPropagation(); handleDelete(fn.id); }}
              className="text-xs opacity-50 hover:opacity-100"
            >
              ✕
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}
