import "dotenv/config";

import Fastify from "fastify";
import { db } from "./services/db";
import cors from "@fastify/cors";

const app = Fastify({
  logger: true
});

app.register(cors, {
  origin: true
});

app.get("/", async (req, res) => {
  const tables = await db.introspection.getTables();
  res.send(tables);
});

app.get("/movie", (req, res) => {
  res.send([]);
});

app.get("/movie/:id", (req, res) => {
  res.send({});
});

app.get("/person/:id", (req, res) => {
  res.send({});
});

app.listen({ port: parseInt(process.env.PORT as string, 10) }, () => {
  console.log(`LISTENING IN PORT ${process.env.PORT}`);
});
