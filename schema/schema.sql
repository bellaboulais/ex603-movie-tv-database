-- ============================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: Movie/Tv
-- Author: Isabella Boulais
-- Target: PostgreSQL 14+
-- ============================================================================
-- Reset. Reverse creation order, so no dependency blocks a drop.
DROP TABLE IF EXISTS movie_genres   CASCADE;
DROP TABLE IF EXISTS genres         CASCADE;
DROP TABLE IF EXISTS ratings        CASCADE;
DROP TABLE IF EXISTS movies         CASCADE;
DROP TABLE IF EXISTS users          CASCADE;

-- ----------------------------------------------------------------------------
-- 1. user — first, because it references nothing.
-- ----------------------------------------------------------------------------
CREATE TABLE users
(
    user_id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username    VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    date_joined TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- ----------------------------------------------------------------------------
-- 2. movies — second, because it references nothing.
-- ----------------------------------------------------------------------------
CREATE TABLE movies
(
    movie_id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title           VARCHAR(100) NOT NULL,
    duration_min    INTEGER NOT NULL,
    release_date    DATE NOT NULL
);
-- ----------------------------------------------------------------------------
-- 3. ratings — third, because it references the user table and movies table.
-- ----------------------------------------------------------------------------
CREATE TABLE ratings
(
    rating_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    movie_id    INTEGER NOT NULL,
    rating      NUMERIC(3,2) NOT NULL,
    comment     VARCHAR(255),
    date        TIMESTAMP NOT NULL,
    CONSTRAINT chk_ratings_movie_user
        UNIQUE (user_id, movie_id),
    CONSTRAINT fk_ratings_user
        FOREIGN KEY (user_id) REFERENCES users (user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ratings_movie
        FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_valid_rating
        CHECK (rating <= 5 and rating >= 0)
);
-- ----------------------------------------------------------------------------
-- 4. genres — fourth, because it does not reference user, movies, or ratings
-- ----------------------------------------------------------------------------
CREATE TABLE genres
(
    genre_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    genre    VARCHAR(100) UNIQUE NOT NULL,
    subgenre TEXT[]
);
-- ----------------------------------------------------------------------------
-- 5. movie_genres — fifth, because it references movies and genres
-- ----------------------------------------------------------------------------
CREATE TABLE movie_genres
(
    genre_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    CONSTRAINT pk_movie_genres PRIMARY KEY(genre_id, movie_id),
    CONSTRAINT fk_movie_genres_genre
        FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_movie_genres_movie
        FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
        ON DELETE CASCADE
)