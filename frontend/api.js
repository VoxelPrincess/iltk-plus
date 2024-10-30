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
