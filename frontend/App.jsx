import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import MoviesList from "./MoviesList";
import MovieDetails from "./MovieDetails";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<MoviesList />} />
        <Route path="/movie/:id" element={<MovieDetails />} />
      </Routes>
    </Router>
  );
}

export default App;
