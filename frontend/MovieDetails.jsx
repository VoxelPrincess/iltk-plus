// MovieDetails.js
import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { fetchMovieDetails } from "./api";
import "./MovieDetails.css";

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
    <div className="movie-details-container">
      <h1 className="movie-title">{movie.title}</h1>
      <img src={movie.url} alt={movie.title} className="movie-poster-large" />
      <p className="movie-year">Year: {movie.publish_year}</p>
      <h2 className="actors-title">Actors:</h2>
      <ul className="actors-list">
        {movie.actors.map((actor) => (
          <li key={actor.id} className="actor-item">
            <strong>{actor.person_name}</strong> as {actor.role_name}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default MovieDetails;
