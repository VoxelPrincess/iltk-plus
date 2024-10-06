import "dotenv/config";
import express from "express";
import cors from "cors";
import { db } from "./services/db";

const app = express();

app.use(
  cors({
    origin: process.env.CLIENT_URL,
    credentials: true
  })
);

app.get("/", async (req, res, next) => {
  try {
    const tables = await db.introspection.getTables();

    res.send(tables);
  } catch (e) {
    next(e);
  }
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

app.listen(process.env.PORT, () => {
  console.log(`LISTENING IN PORT ${process.env.PORT}`);
});
