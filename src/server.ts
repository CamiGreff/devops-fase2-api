import { createServer } from "./app.ts";

const port = Number(process.env.PORT ?? 3000);

createServer().listen(port, () => {
  console.log(`Server running on port ${port}`);
});
