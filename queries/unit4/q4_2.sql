-- 4.2 Build the breakdown leadership asked from

-- Part A: Two numbers in one pass
-- Computer the total number of ratings and the total number of ratings 
-- classified as withdrawn for each movie. REQUIREMENTS: CASE WHEN

SELECT movie_id,
       COUNT(*) AS ratings_count,
       SUM(CASE WHEN rating_status = 'withdrawn' THEN 1 ELSE 0 END) 
        AS failure_count
FROM ratings
GROUP BY movie_id
ORDER BY failure_count DESC, movie_id

-- Part B: Subtotals and a grand total
-- Lists ratings count by region and total ratings count across all regions.
-- REQUIREMENTS: GROUP BY, ROLLUP

-- Each device_country row is a regional subtotal. 
-- The NULL row is the grand total.

SELECT device_country AS region,
       COUNT(*) AS ratings_count
FROM ratings
GROUP BY ROLLUP (device_country)
ORDER BY device_country NULLS LAST

-- Part C: A two-step pipeline
-- List movies with more distinct rating users than the average per movie. 
-- REQUIREMENTS: WITH, WHERE

WITH movie_user_counts AS (
    SELECT movie_id,
           COUNT(DISTINCT user_id) AS distinct_ratings
    FROM ratings
    GROUP BY movie_id
),
summary AS (
    SELECT AVG(distinct_ratings) AS avg_ratings
    FROM movie_user_counts
)
SELECT m.movie_id,
       m.distinct_ratings
FROM movie_user_counts AS m
CROSS JOIN summary AS s
WHERE m.distinct_ratings > s.avg_ratings