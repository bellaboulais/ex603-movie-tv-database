/* Task 6.2: Compare each row to its neighbors */

/*
Part A: Row to row
Is a movie's score going up or down over time, not just high or low overall? 

✓  LAG() and LEAD(), partitioned by producer and ordered by timestamp.
✓  A delta column: the current metric minus the previous metric.
✓  In the final output, filter to one producer of your choice so the trend is 
   easy to read.
   
REQUIREMENT: LAG(), LEAD()
*/

SELECT r.rating_id,
       r.movie_id,
       r.rated_at,
       r.score,
       LAG(r.score) OVER (
           PARTITION BY r.movie_id
           ORDER BY r.rated_at, r.rating_id
       ) AS previous_rating,
       LEAD(r.score) OVER (
           PARTITION BY r.movie_id
           ORDER BY r.rated_at, r.rating_id
       ) AS next_rating,
       r.score - LAG(r.score) OVER (
           PARTITION BY r.movie_id
           ORDER BY r.rated_at, r.rating_id
       ) AS delta
FROM ratings AS r
WHERE r.movie_id = 6
ORDER BY r.rated_at, r.rating_id;

/*
Part B: Cumulative and smoothed
How is the platform doing over time, both in total and on a recent average? 

✓  SUM(...) OVER (ORDER BY ... ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   for a running total.
✓  AVG(...) OVER (... ROWS BETWEEN n PRECEDING AND CURRENT ROW) for a moving 
   average. Note: ROWS counts rows, not days. If some days have no events, a 
   7-row window covers more than 7 days.
✓  Choose a target (for example, a total for the quarter), state it, and show 
   how close the running total gets to it.
✓  One or two sentences on how ROWS differs from RANGE when two rows have the 
   same ORDER BY value.

   Target: 600 total rating points.

   Using ROWS means the tied row(s) will include the tied row before it, so 
   the running totals differ. Tied rows with RANGE includes each other in the 
   frame, so they share the same running total.
*/

WITH platform_trends AS (
    SELECT r.rating_id,
           r.rated_at,
           r.score,
           SUM(r.score) OVER (
               ORDER BY r.rated_at, r.rating_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS running_total,
           ROUND(AVG(r.score) OVER (
               ORDER BY r.rated_at, r.rating_id
               ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
           ), 2) AS avg_ratings
    FROM ratings AS r
)
SELECT rating_id,
       rated_at,
       score,
       running_total,
       avg_ratings,
       600 - running_total AS points_to_target
FROM platform_trends
ORDER BY rated_at, rating_id;

/*
Part C: Where the series stops
One producer stops for a while and then starts again. Find that gap. Then think 
about what you cannot tell yet: did the producer leave, or did your data lose 
them?

✓  LAG() or LEAD() comparing adjacent rows.
✓  A CTE or subquery that computes the gap, and a WHERE in the outer query that 
   keeps only the gaps. (You cannot filter a window function result with WHERE 
   or HAVING in the same query, because the window function runs after them.)

*/

WITH rating_gaps AS (
    SELECT r.movie_id,
           LAG(r.rated_at) OVER (
               PARTITION BY r.movie_id
               ORDER BY r.rated_at, r.rating_id
           ) AS previous_rated_at,
           r.rated_at AS current_rated_at,
           r.rated_at - LAG(r.rated_at) OVER (
               PARTITION BY r.movie_id
               ORDER BY r.rated_at, r.rating_id
           ) AS gap
    FROM ratings AS r
    JOIN movies AS m ON m.movie_id = r.movie_id
)
SELECT movie_id,
       previous_rated_at,
       current_rated_at,
       gap
FROM rating_gaps
WHERE gap > INTERVAL '50 days'
ORDER BY gap DESC