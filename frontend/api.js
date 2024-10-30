// api.js
const API_URL = "http://localhost:10000";

export const fetchMovies = async () => {
  const response = await fetch(`${API_URL}/movie`);
  if (!response.ok) {
    throw new Error("Failed to fetch movies");
  }
  return await response.json();
};

export const fetchMovieDetails = async (id) => {
  const response = await fetch(`${API_URL}/movie/${id}`);
  if (!response.ok) {
    throw new Error("Failed to fetch movie details");
  }
  return await response.json();
};

export const addMovie = async (movieData) => {
  const response = await fetch(`${API_URL}/movie`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(movieData)
  });
  if (!response.ok) {
    throw new Error("Failed to add movie");
  }
  return await response.json();
};

export const deleteMovie = async (id) => {
  const response = await fetch(`${API_URL}/movie/${id}`, {
    method: "DELETE"
  });
  if (!response.ok) {
    throw new Error("Failed to delete movie");
  }
};

export const fetchActors = async () => {
  const response = await fetch(`${API_URL}/actors`);
  if (!response.ok) {
    throw new Error("Failed to fetch actors");
  }
  return await response.json();
};

export const addActor = async (actorData) => {
  const response = await fetch(`${API_URL}/actor`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(actorData)
  });
  if (!response.ok) {
    throw new Error("Failed to update actor movies");
  }
  return await response.json();
};

export const deleteActor = async (person_id, movie_id) => {
  const response = await fetch(`${API_URL}/actor`, {
    method: "DELETE",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ person_id, movie_id })
  });
  if (!response.ok) {
    throw new Error("Failed to delete actor");
  }
};
