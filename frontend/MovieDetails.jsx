import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { fetchMovieDetails } from "./api";

const MovieDetails = () => {
  const { id } = useParams();
  const [movie, setMovie] = useState(null);

  useEffect(() => {
    const loadMovieDetails = async () => {
      try {
        const movieData = await fetchMovieDetails(id);
        setMovie(movieData);
      } catch (error) {
        console.error("Error fetching movie details:", error);
      }
    };
    loadMovieDetails();
  }, [id]);

  if (!movie) {
    return <p>Loading...</p>;
  }

  return (
    <div>
      <h1>{movie.title}</h1>
      <img src={movie.url} alt={movie.title} style={{ width: "300px" }} />
      <p>Year: {movie.publish_year}</p>
      <h2>Actors:</h2>
      <ul>
        {movie.actors.map((actor) => (
          <li key={actor.id}>
            <strong>{actor.person_name}</strong> as {actor.role_name}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default MovieDetails;
