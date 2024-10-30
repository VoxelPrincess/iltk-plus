// MoviesList.js
import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { fetchMovies } from "./api";
import "./MoviesList.css";

const MoviesList = () => {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    const loadMovies = async () => {
      try {
        const moviesData = await fetchMovies();
        setMovies(moviesData);
      } catch (error) {
        console.error("Error fetching movies:", error);
      }
    };
    loadMovies();
  }, []);

  return (
    <div className="movies-list-container">
      <h1>Movies List</h1>
      <div className="movies-grid">
        {movies.map((movie) => (
          <div key={movie.id} className="movie-card">
            <Link to={`/movie/${movie.id}`}>
              <img src={movie.url} alt={movie.title} className="movie-poster" />
            </Link>
            <h3 className="movie-title">{movie.title}</h3>
          </div>
        ))}
      </div>

      <footer>
        <Link to="/admin" className="admin-link">
          Admin Panel
        </Link>
      </footer>
    </div>
  );
};

export default MoviesList;
