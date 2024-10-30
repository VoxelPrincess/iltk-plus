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

app.post("/movie", async (req, res) => {
  const { title, publish_year, picture_url } = req.body;

  try {
    // Шаг 1: Добавляем изображение в таблицу picture
    const [newPicture] = await db
      .insertInto("picture")
      .values({
        picture_description: `Image for ${title}`,
        picture_filename: picture_url
      })
      .returning("id")
      .execute();

    const picture_id = newPicture.id;

    // Шаг 2: Добавляем фильм в таблицу movie с ссылкой на picture_id
    const [newMovie] = await db
      .insertInto("movie")
      .values({
        title,
        publish_year,
        primary_picture: picture_id // Используем ID добавленной картинки
      })
      .returning(["id", "title", "publish_year", "primary_picture"])
      .execute();

    res.status(201).send(newMovie);
  } catch (e) {
    console.error("Error:", e);
    res
      .status(500)
      .send({ message: "Error creating movie with picture", error: e.message });
  }
});

app.delete("/movie/:id", async (req, res) => {
  try {
    await db.deleteFrom("movie").where("id", "=", req.params.id).execute();
    res.status(204).send();
  } catch (e) {
    console.log(e);
    res.status(500).send({ message: "Error deleting movie" });
  }
});

app.post("/actor", async (req, res) => {
  try {
    const { person_name, date_of_birth, date_of_death, movie_ids, role_name } =
      req.body;

    // Проверка обязательных данных
    if (!person_name || !Array.isArray(movie_ids) || movie_ids.length === 0) {
      return res.status(400).send({
        message: "Invalid data: person_name and movie_ids are required"
      });
    }

    // Создаём новую запись в таблице person и получаем person_id
    const [newPerson] = await db
      .insertInto("person")
      .values({
        person_name,
        date_of_birth: date_of_birth || null,
        date_of_death: date_of_death || null
      })
      .returning("id")
      .execute();

    const person_id = newPerson.id;

    // Подготавливаем данные для вставки связей актёра с фильмами
    const actorEntries = movie_ids.map((movie_id) => ({
      person_id,
      movie_id,
      role_name
    }));

    // Вставляем связи актёра с выбранными фильмами
    await db.insertInto("actor").values(actorEntries).execute();

    res.status(201).send({
      message: "Actor created and movies linked successfully",
      person_id
    });
  } catch (e) {
    console.error("Error:", e);
    res.status(500).send({
      message: "Error creating actor and linking movies",
      error: e.message
    });
  }
});

app.delete("/actor", async (req, res) => {
  const { person_id, movie_id } = req.body;
  try {
    await db
      .deleteFrom("actor")
      .where("person_id", "=", person_id)
      .where("movie_id", "=", movie_id)
      .execute();
    res.status(204).send();
  } catch (e) {
    console.log(e);
    res.status(500).send({ message: "Error deleting actor" });
  }
});

app.get("/actors", async (req, res) => {
  try {
    const actors = await db.selectFrom("person").selectAll().execute();
    res.send(actors);
  } catch (e) {
    console.log(e);
    res.status(500).send({ message: "Error fetching actors" });
  }
});
