import type { LambdaFunction } from "./functions/route";

export const functionsStore = new Map<string, LambdaFunction>([
  [
    "hello-world",
    {
      id: "hello-world",
      name: "hello-world",
      runtime: "nodejs",
      code: `exports.handler = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello from Lambda!", event }),
  };
};`,
      createdAt: new Date().toISOString(),
    },
  ],
]);
