# API Documentation

## Base URL

All endpoints are prefixed by the base URL:

```
http://localhost:10000
```

## Endpoints

### GET `/`

**Description**: Returns a list of tables in the database (introspection).

**Response**:

- `200 OK`: Returns an array of table names.

---

### GET `/movie`

**Description**: Retrieves a list of movies with their details, including the primary picture URL.

**Response**:

- `200 OK`: Returns an array of movie objects.
  - **movie.id**: `number` - The ID of the movie.
  - **movie.title**: `string` - The title of the movie.
  - **movie.publish_year**: `number` - The year the movie was published.
  - **url**: `string` - URL to the movie's primary picture.

**Example Response**:

```json
[
  {
    "id": 1,
    "title": "The Matrix",
    "publish_year": 1999,
    "url": "https://example.com/image.jpg",
    "link": "http://localhost:10000/movie/1"
  },
  ...
]
```

---

### GET `/movie/:id`

**Description**: Retrieves details of a specific movie by its ID, along with its actors.

**URL Parameters**:

- `id` - The ID of the movie to retrieve.

**Response**:

- `200 OK`: Returns a movie object with details.
  - **id**: `number` - The movie's ID.
  - **title**: `string` - The title of the movie.
  - **publish_year**: `number` - The year the movie was published.
  - **url**: `string` - URL to the movie's primary picture.
  - **actors**: `array` - List of actors in the movie.
    - **person_name**: `string` - Name of the actor.
    - **role_name**: `string` - Name of the role played.

**Example Response**:

```json
{
  "id": 1,
  "title": "The Matrix",
  "publish_year": 1999,
  "url": "https://example.com/image.jpg",
  "actors": [
    {
      "person_name": "Keanu Reeves",
      "role_name": "Neo"
    },
    ...
  ]
}
```

**Error Response**:

- `404 Not Found`: If the movie with the specified ID does not exist.
  ```json
  { "message": "Movie not found" }
  ```

---

### POST `/actor`

**Description**: Adds a new actor to the database and associates them with selected movies.

**Request Body**:

- `person_name` - `string` - Name of the actor.
- `date_of_birth` - `string` - Birthdate of the actor (optional).
- `date_of_death` - `string` - Death date of the actor (optional).
- `movie_ids` - `array` - Array of movie IDs to associate with the actor.
- `role_name` - `string` - The role the actor plays in each movie.

**Example Request**:

```json
{
  "person_name": "Keanu Reeves",
  "date_of_birth": "1964-09-02",
  "movie_ids": [1, 2, 3],
  "role_name": "Neo"
}
```

**Response**:

- `201 Created`: Returns a confirmation message and the new actor's ID.
  ```json
  { "message": "Actor created and movies linked successfully", "person_id": 10 }
  ```

**Error Response**:

- `400 Bad Request`: If the request body is missing required fields.
  ```json
  { "message": "Invalid data: person_name and movie_ids are required" }
  ```
- `500 Internal Server Error`: If there is an error while processing the request.

---

### POST `/movie`

**Description**: Adds a new movie to the database and uploads its primary picture.

**Request Body**:

- `title` - `string` - Title of the movie.
- `publish_year` - `number` - Year the movie was published.
- `picture_url` - `string` - URL of the primary picture for the movie.

**Example Request**:

```json
{
  "title": "Avatar",
  "publish_year": 2009,
  "picture_url": "https://example.com/avatar.jpg"
}
```

**Response**:

- `201 Created`: Returns the created movie object with ID and details.
  ```json
  {
    "id": 5,
    "title": "Avatar",
    "publish_year": 2009,
    "primary_picture": 15
  }
  ```

**Error Response**:

- `500 Internal Server Error`: If there is an error during movie creation.

---

### DELETE `/movie/:id`

**Description**: Deletes a movie by its ID.

**URL Parameters**:

- `id` - The ID of the movie to delete.

**Response**:

- `200 OK`: Returns a confirmation message.
  ```json
  { "message": "Movie deleted successfully" }
  ```

**Error Response**:

- `404 Not Found`: If the movie with the specified ID does not exist.

---

### DELETE `/actor/:id`

**Description**: Deletes an actor by their ID.

**URL Parameters**:

- `id` - The ID of the actor to delete.

**Response**:

- `200 OK`: Returns a confirmation message.
  ```json
  { "message": "Actor deleted successfully" }
  ```

**Error Response**:

- `404 Not Found`: If the actor with the specified ID does not exist.
