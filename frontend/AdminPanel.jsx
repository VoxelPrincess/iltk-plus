// AdminPanel.js
import React, { useEffect, useState } from "react";
import {
  addMovie,
  deleteMovie,
  fetchMovies,
  addActor,
  deleteActor,
  fetchActors
} from "./api";
import "./AdminPanel.css";

const AdminPanel = () => {
  const [movies, setMovies] = useState([]);
  const [actors, setActors] = useState([]);
  const [movieData, setMovieData] = useState({
    title: "",
    publish_year: "",
    picture_url: ""
  });
  const [actorData, setActorData] = useState({
    person_name: "",
    date_of_birth: "",
    date_of_death: "",
    movie_ids: [],
    role_name: ""
  });

  useEffect(() => {
    const loadMoviesAndActors = async () => {
      try {
        const moviesData = await fetchMovies();
        setMovies(moviesData);
        const actorsData = await fetchActors();
        setActors(actorsData);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };
    loadMoviesAndActors();
  }, []);

  const handleAddMovie = async () => {
    try {
      await addMovie(movieData);
      alert("Movie added successfully!");
    } catch (error) {
      console.error("Error adding movie:", error);
      alert("Failed to add movie");
    }
  };

  const handleDeleteMovie = async (id) => {
    try {
      await deleteMovie(id);
      setMovies(movies.filter((movie) => movie.id !== id));
      alert("Movie deleted successfully!");
    } catch (error) {
      console.error("Error deleting movie:", error);
      alert("Failed to delete movie");
    }
  };

  const handleAddActor = async () => {
    try {
      await addActor(actorData);
      setActors([...actors, actorData]);
      alert("Actor movies updated successfully!");
    } catch (error) {
      console.error("Error updating actor movies:", error);
      alert("Failed to update actor movies");
    }
  };

  const handleDeleteActor = async (person_id) => {
    try {
      await deleteActor(person_id);
      setActors(actors.filter((actor) => actor.id !== person_id));
      alert("Actor deleted successfully!");
    } catch (error) {
      console.error("Error deleting actor:", error);
      alert("Failed to delete actor");
    }
  };

  return (
    <div className="admin-panel">
      <h1>Admin Panel</h1>

      <div className="section">
        <h2>Add Movie</h2>
        <label>Title</label>
        <input
          type="text"
          value={movieData.title}
          onChange={(e) =>
            setMovieData({ ...movieData, title: e.target.value })
          }
        />

        <label>Publish Year</label>
        <input
          type="text"
          value={movieData.publish_year}
          onChange={(e) =>
            setMovieData({ ...movieData, publish_year: e.target.value })
          }
        />

        <label>Picture URL</label>
        <input
          type="text"
          value={movieData.picture_url}
          onChange={(e) =>
            setMovieData({ ...movieData, picture_url: e.target.value })
          }
        />

        <button onClick={handleAddMovie} className="primary-btn">
          Add Movie
        </button>
      </div>

      <div className="section">
        <h2>Movies List</h2>
        {movies.map((movie) => (
          <div key={movie.id} className="movie-item">
            <span>{movie.title}</span>
            <button
              onClick={() => handleDeleteMovie(movie.id)}
              className="delete-btn"
            >
              Delete
            </button>
          </div>
        ))}
      </div>

      <div className="section">
        <h2>Add Actor with Movies</h2>
        <label>Name</label>
        <input
          type="text"
          value={actorData.person_name}
          onChange={(e) =>
            setActorData({ ...actorData, person_name: e.target.value })
          }
        />

        <label>Date of Birth</label>
        <input
          type="date"
          value={actorData.date_of_birth}
          onChange={(e) =>
            setActorData({ ...actorData, date_of_birth: e.target.value })
          }
        />

        <label>Date of Death</label>
        <input
          type="date"
          value={actorData.date_of_death}
          onChange={(e) =>
            setActorData({ ...actorData, date_of_death: e.target.value })
          }
        />

        <label>Role Name</label>
        <input
          type="text"
          value={actorData.role_name}
          onChange={(e) =>
            setActorData({ ...actorData, role_name: e.target.value })
          }
        />

        <label>Movies</label>
        <select
          multiple
          value={actorData.movie_ids}
          onChange={(e) =>
            setActorData({
              ...actorData,
              movie_ids: Array.from(
                e.target.selectedOptions,
                (option) => option.value
              )
            })
          }
        >
          {movies.map((movie) => (
            <option key={movie.id} value={movie.id}>
              {movie.title}
            </option>
          ))}
        </select>

        <button onClick={handleAddActor} className="primary-btn">
          Add Actor with Movies
        </button>
      </div>

      <div className="section">
        <h2>Actors List</h2>
        {actors.map((actor) => (
          <div key={actor.id} className="actor-item">
            <span>{actor.person_name}</span>
            <button
              onClick={() => handleDeleteActor(actor.id)}
              className="delete-btn"
            >
              Delete
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default AdminPanel;
