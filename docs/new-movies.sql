INSERT INTO movie
  (title, publish_year)
  VALUES ('The Matrix Reloaded', 2003);

INSERT INTO movie (title, publish_year)
  VALUES ('The Matrix Revolutions', 2003);

INSERT INTO movie (title, publish_year)
  VALUES ('The Matrix Resurrections', 2021);

INSERT INTO actor (person_id, movie_id, role_name)
VALUES (1, 2, 'Neo');

INSERT INTO actor (person_id, movie_id, role_name)
VALUES (1, 3, 'Neo');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (1, 4, 'Neo');

INSERT INTO picture (picture_description, picture_filename)
  VALUES('Matrix poster', 'https://image.tmdb.org/t/p/original/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg')

INSERT INTO picture (picture_description, picture_filename)
  VALUES('Matrix Reloaded poster', 'https://image.tmdb.org/t/p/original/9TGHDvWrqKBzwDxDodHYXEmOE6J.jpg');

INSERT INTO picture (picture_description, picture_filename)
  VALUES('Matrix Revolutions poster', 'https://image.tmdb.org/t/p/original/tyXwreXv4pfo4T4aplTKIp7f9GI.jpg');

INSERT INTO picture (picture_description, picture_filename)
  VALUES('Matrix Resurrections poster', 'https://image.tmdb.org/t/p/original/8c4a8kE7PizaGQQnditMmI1xbRp.jpg');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (2, 1, 'Trinity');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (2, 2, 'Trinity');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (2, 3, 'Trinity');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (2, 4, 'Trinity');

INSERT INTO person (person_name, date_of_birth)
  VALUES ('Laurence Fishburne', '1961-07-30');

INSERT INTO person (person_name, date_of_birth)
  VALUES ('Yahya Abdul-Mateen II', '1986-07-15');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (5, 1, 'Morpheus');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (5, 2, 'Morpheus');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (5, 3, 'Morpheus');

INSERT INTO actor (person_id, movie_id, role_name)
  VALUES (7, 4, 'Morpheus');

UPDATE movie SET primary_picture = 3 WHERE id = 2;
UPDATE movie SET primary_picture = 4 WHERE id = 3;
UPDATE movie SET primary_picture = 5 WHERE id = 4;


