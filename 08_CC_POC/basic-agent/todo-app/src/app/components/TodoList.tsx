'use client';

import { useState } from 'react';
import TodoForm from './TodoForm';
import TodoItem from './TodoItem';

type Todo = {
  id: number;
  text: string;
  done: boolean;
};

export default function TodoList() {
  const [todos, setTodos] = useState<Todo[]>([]);

  const addTodo = (text: string) => {
    setTodos([...todos, { id: Date.now(), text, done: false }]);
  };

  const toggleTodo = (id: number) => {
    setTodos(todos.map((t) => (t.id === id ? { ...t, done: !t.done } : t)));
  };

  const deleteTodo = (id: number) => {
    setTodos(todos.filter((t) => t.id !== id));
  };

  return (
    <div>
      <TodoForm onAdd={addTodo} />
      {todos.length === 0 ? (
        <p className="text-gray-400 text-sm text-center py-4">TODOがありません</p>
      ) : (
        <ul>
          {todos.map((todo) => (
            <TodoItem
              key={todo.id}
              todo={todo}
              onToggle={toggleTodo}
              onDelete={deleteTodo}
            />
          ))}
        </ul>
      )}
    </div>
  );
}
