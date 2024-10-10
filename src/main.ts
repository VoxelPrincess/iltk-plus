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

app.get("/movie", async (req, res) => {
  const movies = await db
    .selectFrom("movie")
    .leftJoin("picture", "picture.id", "movie.primary_picture")
    .select([
      "movie.id",
      "movie.title",
      "movie.publish_year",
      "picture.picture_filename as url"
    ])
    .orderBy("id", "asc")
    .execute();
  // await db.selectFrom("movie").execute()

  res.send(
    movies.map((movie) => {
      return {
        ...movie,
        link: `http://localhost:10000/movie/${movie.id}`
      };
    })
  );
});

app.get<{
  Params: { id: string };
}>("/movie/:id", async (req, res) => {
  try {
    const movie = await db
      .selectFrom("movie")
      .where("movie.id", "=", req.params.id)
      .leftJoin("picture", "picture.id", "movie.primary_picture")
      .select([
        "movie.id",
        "movie.title",
        "movie.publish_year",
        "picture.picture_filename as url"
      ])
      .orderBy("id", "asc")
      .executeTakeFirstOrThrow();

    const actors = await db
      .selectFrom("actor")
      .innerJoin("person", "actor.person_id", "person.id")
      .select([
        "person.id",
        "person.person_name",
        "actor.role_name",
        "actor.role_name"
      ])
      .where("actor.movie_id", "=", movie.id)
      .orderBy("person.id")
      .execute();

    res.send({
      ...movie,
      actors
    });
  } catch (e) {
    console.log(e);
    res.status(404).send({ message: "Movie not found" });
  }
});

app.get("/person/:id", async (req, res) => {
  res.send({});
});

app.listen({ port: parseInt(process.env.PORT as string, 10) }, () => {
  console.log(`LISTENING IN PORT ${process.env.PORT}`);
});
