/*  Task 6.3: Build the reporting patterns

actor = users
producer = movies
events = ratings
catalogue = genres
junction = movie_genres
metric = rating
*/

/*
Part A: Top N per category
Return the top three events by score for each movie.

✓   A ranking window function, partitioned by movie.
✓	A CTE or subquery that filters to rank <= 3.
✓   FIRST_VALUE() or LAST_VALUE() used somewhere in your solution. If you use 
    LAST_VALUE(), add ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING; 
    with the default frame it returns the wrong value.
✓	A comment saying how ties at third place are handled, and why.

RANK includes every rating tied at third place, even if a movie has more
than three results, because we do not want to eliminate a random movie tied at 
third place and lose that data. 
*/

WITH ranked_ratings AS (
    SELECT r.rating_id,
           r.movie_id,
           r.user_id,
           r.rated_at,
           r.score,
           RANK() OVER (
               PARTITION BY r.movie_id
               ORDER BY r.score DESC
           ) AS score_rank,
           FIRST_VALUE(r.score) OVER (
               PARTITION BY r.movie_id
               ORDER BY r.score DESC, r.rating_id
           ) AS highest_score
    FROM ratings AS r
    JOIN movies AS m ON m.movie_id = r.movie_id
)
SELECT rating_id,
       movie_id,
       user_id,
       rated_at,
       score,
       score_rank,
       highest_score
FROM ranked_ratings
WHERE score_rank <= 3
ORDER BY movie_id, score DESC, rating_id;

/*
Part B: Period over period
Is the platform getting better or worse each month? Group your events by 
calendar month, then compare each month with the month before.

✓	Group events into months (for example, with DATE_TRUNC('month', ...)).
✓	LAG() over the monthly series.
✓	A percent-change column that avoids division by zero (for example, with 
    NULLIF(..., 0)).
✓	A check for missing months. LAG counts rows, so a missing month makes it 
    compare the wrong months.

*/

WITH monthly_ratings AS (
    SELECT DATE_TRUNC('month', r.rated_at)::date AS month,
           COUNT(*) AS count,
           AVG(r.score) AS avg_score
    FROM ratings AS r
    GROUP BY DATE_TRUNC('month', r.rated_at)::date
),
month_comparison AS (
    SELECT month,
           count,
           avg_score,
           LAG(month) OVER (ORDER BY month) AS prev_month,
           LAG(avg_score) OVER (ORDER BY month) AS prev_avg
    FROM monthly_ratings
)
SELECT month,
       count,
       ROUND(avg_score, 2) AS avg_score,
       prev_month,
       ROUND(prev_avg, 2) AS prev_avg,
       CASE
           WHEN month = (prev_month + INTERVAL '1 month')::date
           THEN ROUND(
               100.0 * (avg_score - prev_avg)
               / NULLIF(prev_avg, 0),
               2
           )
           END AS percent_change
FROM month_comparison
ORDER BY month;