import TodoList from './components/TodoList';

export default function Home() {
  return (
    <main className="max-w-lg mx-auto mt-16 px-4">
      <h1 className="text-2xl font-bold mb-6 text-gray-800">TODO App</h1>
      <TodoList />
    </main>
  );
}
