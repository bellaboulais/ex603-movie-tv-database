-- Task 3.1 — all exploration queries, each under a numbered comment header. 

-- 1. Find active movies released after 2015. Requirements: SELECT, JOIN,
-- WHERE, GROUP BY, ORDER BY, LIMIT
SELECT movie_id, title, release_year
FROM movies
WHERE is_available = TRUE
  AND release_year > 2015
ORDER BY release_year DESC, title
LIMIT 10;

-- 2. Find all possible rating statuses. I did not expect the flagged status. 
-- Requirements:  SELECT, DISTINCT, ORDER BY
SELECT DISTINCT rating_status
FROM ratings
ORDER BY rating_status;

-- 3. First, filter ratings on scores greater than or equal to 4.0. Then, filter
-- ratings based on rating_status being flagged or withdrawn. Requirements: 
-- SELECT, JOIN, WHERE, IN
SELECT m.title, r.score
FROM movies AS m
JOIN ratings AS R ON r.movie_id = m.movie_id
WHERE r.score >= 4.0

SELECT m.movie_id, r.rating_status, r.withdrawn_reason
FROM movies AS m
JOIN ratings AS r ON r.movie_id = m.movie_id 
WHERE r.rating_status in ('flagged', 'withdrawn')

-- 4. Find flagged and withdrawn rating statuses from movies whose title has a
-- '3' in it and populate the withdrawn_reason with 'No reason provided' if
-- NULL. Requirements: SELECT, JOIN, WHERE, IN, LIKE
SELECT m.title, r.rating_status,
       COALESCE(r.withdrawn_reason, 'No reason provided') AS withdrawn_reason
FROM movies AS m
JOIN ratings AS r ON r.movie_id = m.movie_id
WHERE r.rating_status IN ('flagged', 'withdrawn') AND m.title LIKE '%3%';

-- 5. Make a rating_category coloumn that labels ratings Excelled, Good,
-- Average, or Poor based on their score. Make sure the rating is published. 
-- Requirements: SELECT, CASE, WHEN, THEN, ELSE, JOIN, WHERE, ORDER BY, DESC
SELECT m.title,
       r.score,
       CASE
           WHEN r.score >= 4.5 THEN 'Excellent'
           WHEN r.score >= 3.5 THEN 'Good'
           WHEN r.score >= 2.5 THEN 'Average'
           ELSE 'Poor'
       END AS rating_category
FROM movies AS m
JOIN ratings AS r ON r.movie_id = m.movie_id
WHERE r.rating_status = 'published'
ORDER BY r.score DESC, m.title;
