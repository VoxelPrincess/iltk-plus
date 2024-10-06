# ILTK

Internet Leffa Tietokanta.

A practice application for db course.

## Database

You should use the database you created on the last lesson, as long as you are happy with it. If you decide to do so, you can skip this section.

If you don't have your own database or are not happy with it, my own version is located in `docs/movies.sql`

- In shell, `cd` to the project directory (the same where this README is located)
- `dropdb movies`
- `createdb movies`
- `psql movies < docs/movies.sql`

## Development

- `npm i`
- `cp .env.example .env`
- open and edit `.env` file as necessary
- `npm run dev`
- open http://localhost:10000/ in your browser and assert that you get some frightening database meta information to your screen.
