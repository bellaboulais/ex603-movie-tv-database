/* Task 6.1: Compute across a window without collapsing */

/*
1. Compare each individual rating to the movie's average. Is an event unusual 
for its own producer? How many rows does each return, and what is lost? 

REQUIREMENTS: AVG(...) OVER (PARTITION BY ...), GROUP BY

One unusal rating is rating_ID 36 that scored a perfect 5.0 on a movie with an 
average score of 2.24. The window query returns 200 rows and we can see how each
rating compares to the average rating for the movie. The GROUP BY query just 
shows 13 rows and we can only see the average rating for each movie.  
*/

-- Window, 200 rows
SELECT r.rating_id,
       r.movie_id,
       r.user_id,
       r.score,
       AVG(r.score) OVER (PARTITION BY r.movie_id) AS movie_avg_rating
FROM ratings AS r
JOIN movies AS m ON m.movie_id = r.movie_id
ORDER BY r.movie_id, r.rating_id;

-- GROUP BY, 13 rows
SELECT r.movie_id,
       AVG(r.score) AS movie_avg_rating
FROM ratings AS r
JOIN movies AS m ON m.movie_id = r.movie_id
GROUP BY r.movie_id, m.title
ORDER BY r.movie_id;

/*
2. Rank producers by number of ratings using.

REQUIREMENTS: ROW_NUMBER(), RANK(), and DENSE_RANK()
*/

WITH movie_ratings_counts AS (
    SELECT r.movie_id,
           COUNT(*) AS ratings_count
    FROM ratings AS r
    JOIN movies AS m ON m.movie_id = r.movie_id
    GROUP BY r.movie_id
)
SELECT movie_id,
       ratings_count,
       ROW_NUMBER() OVER (
           ORDER BY ratings_count DESC, movie_id ASC
       ) AS row_number,
       RANK() OVER (
           ORDER BY ratings_count DESC
       ) AS rank,
       DENSE_RANK() OVER (
           ORDER BY ratings_count DESC
       ) AS dense_rank
FROM movie_ratings_counts
ORDER BY ratings_count DESC, movie_id ASC;

/*
3. Sort movies into four bands by number of ratings.

REQUIREMENTS: NTILE(4)
*/

WITH movie_ratings_counts AS (
    SELECT r.movie_id,
           m.title,
           COUNT(*) AS ratings_count
    FROM ratings AS r
    JOIN movies AS m ON m.movie_id = r.movie_id
    GROUP BY r.movie_id, m.title
)
SELECT movie_id,
       title,
       ratings_count,
       NTILE(4) OVER (
           ORDER BY ratings_count DESC, movie_id ASC
       ) AS ratings_band
FROM movie_ratings_counts
ORDER BY ratings_band, ratings_count DESC, movie_id ASC;
