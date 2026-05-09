'use client';

type Todo = {
  id: number;
  text: string;
  done: boolean;
};

type Props = {
  todo: Todo;
  onToggle: (id: number) => void;
  onDelete: (id: number) => void;
};

export default function TodoItem({ todo, onToggle, onDelete }: Props) {
  return (
    <li className="flex items-center gap-3 py-2 border-b border-gray-100">
      <input
        type="checkbox"
        checked={todo.done}
        onChange={() => onToggle(todo.id)}
        className="w-4 h-4 cursor-pointer"
      />
      <span className={`flex-1 text-sm ${todo.done ? 'line-through text-gray-400' : ''}`}>
        {todo.text}
      </span>
      <button
        onClick={() => onDelete(todo.id)}
        className="text-red-400 hover:text-red-600 text-xs"
      >
        削除
      </button>
    </li>
  );
}
