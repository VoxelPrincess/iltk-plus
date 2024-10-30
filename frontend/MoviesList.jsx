import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { fetchMovies } from "./api";

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
    <div>
      <h1>Movies List</h1>
      <div style={{ display: "flex", flexWrap: "wrap" }}>
        {movies.map((movie) => (
          <div key={movie.id} style={{ margin: "20px" }}>
            <Link to={`/movie/${movie.id}`}>
              <img
                src={movie.url}
                alt={movie.title}
                style={{ width: "150px", height: "220px", objectFit: "cover" }}
              />
            </Link>
            <h3>{movie.title}</h3>
          </div>
        ))}
      </div>
    </div>
  );
};

export default MoviesList;
