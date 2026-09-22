# Constraints 

## Primary Key Constraints

- `users.user_id` -> UNIQUE, NOT NULL
- `movies.movie_id` -> UNIQUE, NOT NULL
- `ratings.rating_id` -> UNIQUE, NOT NULL
- `genres.genre_id` -> UNIQUE, NOT NULL
- `movie_genres(movie_id, genre_id)` -> UNIQUE, NOT NULL

## users

`users(user_id: integer, username: string, email: string, date_joined: date)`

- user_id: UNIQUE, NOT NULL
- username: NOT NULL
- email:  UNIQUE, NOT NULL
- date_joined: NOT NULL, CHECK valid date, not in the future

## movies

`movies(movie_id: integer, title: string, duration_min: integer, release_date: date)`

- movie_id: UNIQUE, NOT NULL
- title: NOT NULL
- duration: NOT NULL, CHECK greater than 0
- release_date: NOT NULL, CHECK valid date

## ratings

`ratings(rating_id: integer, user_id: integer, movie_id: integer, rating: float, comment: string, date: date)`

- rating_id: UNIQUE, NOT NULL
- user_id: NOT NULL
- movie_id: NOT NULL
- (user_id, movie_id): UNIQUE, NOT NULL
- rating: NOT NULL, CHECK between 0.0 and 5.0
- date: NOT_NULL, CHECK valid date, not in the future
- FK user_id: ON DELETE CASCADE
- FK movie_id: ON DELETE CASCADE

## genres

`genres(genre_id: integer, genre: string)`

- genre_id: UNIQUE, NOT NULL
- genre: UNIQUE, NOT NULL

## movie_genres

`movie_genres(movie_id: integer, genre_id: integer)`

- (movie_id, genre_id): UNIQUE, NOT NULL
- FK movie_id: ON DELETE CASCADE
- FK genre_id: ON DELETE CASCADE