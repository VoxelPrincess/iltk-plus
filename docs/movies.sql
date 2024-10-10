/* todo: createdb movies */

/* käännetty järjestys */
DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS premiere CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS actor CASCADE;
DROP TABLE IF EXISTS director CASCADE;
DROP TABLE IF EXISTS picture CASCADE;
DROP TABLE IF EXISTS person_picture CASCADE;

DROP TABLE IF EXISTS viewer CASCADE;
DROP TABLE IF EXISTS review CASCADE;

CREATE TABLE viewer (
  id BIGINT GENERATED ALWAYS AS IDENTITY,
  email varchar(255) NOT NULL UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE picture (
  id BIGINT GENERATED ALWAYS AS IDENTITY,
  picture_description VARCHAR(255) NOT NULL,
  picture_filename VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(id)
);

INSERT INTO picture (picture_description, picture_filename)
VALUES ('Keanu Reeves istuu puiston penkillä, mutustaen sämpylää', '/1/1/1/1-keanu.jpg');

CREATE TABLE person (
  id bigint GENERATED ALWAYS AS IDENTITY,
  primary_picture BIGINT NULL REFERENCES picture(id) ON DELETE SET NULL,
  person_name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  date_of_death DATE NULL,
  PRIMARY KEY(id)
);

CREATE TABLE person_picture (
    person_id BIGINT NOT NULL REFERENCES person(id) ON DELETE CASCADE,
    picture_id BIGINT NOT NULL REFERENCES picture(id) ON DELETE CASCADE,
    order_id INTEGER NOT NULL,
    PRIMARY KEY(person_id, picture_id)
);

/* premature optimization */
/*
CREATE TABLE person_death (
  person_id BIGINT NOT NULL REFERENCES person(id) ON DELETE CASCADE,
  death_date DATE NOT NULL,
  PRIMARY KEY(person_id)
);
*/

/* OLD WAY: id BIGSERIAL PRIMARY KEY, */
CREATE TABLE movie (
  id bigint GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) NOT NULL,
  primary_picture BIGINT NULL REFERENCES picture(id) ON DELETE SET NULL,
  publish_year INTEGER NOT NULL, /* in different countries */
  PRIMARY KEY(id)
);

CREATE TABLE review (
  movie_id BIGINT NOT NULL REFERENCES movie(id) ON DELETE CASCADE,
  viewer_id BIGINT NOT NULL REFERENCES viewer(id) ON DELETE CASCADE,
  score INTEGER NOT NULL CHECK(score BETWEEN 1 AND 10),
  PRIMARY KEY(movie_id, viewer_id)
);

CREATE TABLE premiere (
   movie_id BIGINT NOT NULL REFERENCES movie(id) ON DELETE CASCADE,
   country_code CHAR(2) NOT NULL,
   premiere_date DATE NOT NULL,
   PRIMARY KEY(movie_id, country_code)
);

CREATE TABLE actor (
  person_id BIGINT NOT NULL REFERENCES person(id) ON DELETE CASCADE,
  movie_id BIGINT NOT NULL REFERENCES movie(id) ON DELETE CASCADE,
  role_name VARCHAR(255) NOT NULL,
  PRIMARY KEY(person_id, movie_id, role_name)
);

/* remember to drop me in the beginning */
CREATE TABLE director (
  person_id BIGINT NOT NULL REFERENCES person(id) ON DELETE CASCADE,
  movie_id BIGINT NOT NULL REFERENCES movie(id) ON DELETE CASCADE,
  PRIMARY KEY(person_id, movie_id)
);

INSERT INTO movie (title, publish_year) VALUES ('The Matrix', 1999);

INSERT INTO premiere
(movie_id, country_code, premiere_date)
VALUES (1, 'FI', '1999-06-11');

INSERT INTO premiere
(movie_id, country_code, premiere_date)
VALUES (1, 'SE', '1999-06-11');

INSERT INTO person (person_name, primary_picture, date_of_birth)
VALUES ('Keanu Reeves', 1, '1964-09-02');

INSERT INTO person (person_name, date_of_birth)
VALUES ('Carrie-Anne Moss', '1967-08-21');

INSERT INTO person (person_name, date_of_birth)
VALUES ('Lana Wachowski', '1965-06-21');

INSERT INTO person (person_name, date_of_birth)
VALUES ('Lilly Wachowski', '1967-12-29');

INSERT INTO actor (person_id, movie_id, role_name) VALUES (1, 1, 'Neo');
INSERT INTO director (person_id, movie_id) VALUES (3, 1);
INSERT INTO director (person_id, movie_id) VALUES (4, 1);

INSERT INTO viewer (email) VALUES ('pekkisx@gmail.com');
INSERT INTO viewer (email) VALUES ('puhemies@diktaattoriporssi.com');

INSERT INTO review (movie_id, viewer_id, score) VALUES (1, 1, 9);
INSERT INTO review (movie_id, viewer_id, score) VALUES (1, 2, 10);

/* after live */

