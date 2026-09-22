# Schema Definition

## users

`users(user_id: integer, username: string, email: string, date_joined: date)`

- **PK:** `user_id`

## movies

`movies(movie_id: integer, title: string, duration_min: integer, release_date: date)`

- **PK:** `movie_id`

## ratings

`ratings(rating_id: integer, user_id: integer, movie_id: integer, rating: float, comment: string, date: date)`

- **PK:** `rating_id`
- **FK:** `user_id → users(user_id)`
- **FK:** `movie_id → movies(movie_id)`

## genres

`genres(genre_id: integer, genre: string)`

- **PK:** `genre_id`

## movie_genres

`movie_genres(movie_id: integer, genre_id: integer)`

- **PK:** `(movie_id, genre_id)`
- **FK:** `movie_id → movies(movie_id)`
- **FK:** `genre_id → genres(genre_id)`