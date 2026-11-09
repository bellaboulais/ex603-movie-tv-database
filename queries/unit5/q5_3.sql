-- 5.3 Understand Join Performance and Execution Plans

/*
Part A: Explore CROSS JOIN
Write a CROSS JOIN between two small tables.
*/ 

WITH sample_users AS (
    SELECT user_id
    FROM users
    ORDER BY user_id
    LIMIT 5
),
sample_movies AS (
    SELECT movie_id, title
    FROM movies
    ORDER BY movie_id
    LIMIT 5
)
SELECT u.user_id, m.movie_id, m.title
FROM sample_users u
CROSS JOIN sample_movies m
ORDER BY u.user_id, m.movie_id;

/*
1. Count the rows in each source table. 5, 5

2. Run the CROSS JOIN and count the resulting rows. 25

3. Show how the result matches the multiplication of the two source table 
counts. 

5 x 5 = 25

4. Explain when a Cartesian product might be useful and when it could indicate 
a query error. 

A CROSS JOIN is useful when intentionally generating every combination, such
as pairing each user with each movie for a test matrix. It can indicate a query
error when a join condition is accidentally omitted.
*/

/* 
Part B: Examine a Query Execution Plan

Return to your three-table join from Task 5.1, Part A. Use PostgreSQL's EXPLAIN
command to examine how the database plans to execute the query.

EXPLAIN
SELECT ...    -- your three-table join from 5.1
;
-- EXPLAIN ANALYZE also runs the query and reports actual timings.
-- Safe here; be careful with it on statements that modify data.
*/ 

EXPLAIN ANALYZE
SELECT u.user_id, u.user_name, m.movie_id, m.title, r.rated_at
FROM users u
JOIN ratings r ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
ORDER BY u.user_id, m.movie_id;

/*
Review the execution plan and complete the following:

1. Capture the full execution plan.

Sort  (cost=35.98..36.48 rows=200 width=532) (actual time=1.498..1.511 rows=200.00 loops=1)
"  Sort Key: u.user_id, m.movie_id"
  Sort Method: quicksort  Memory: 35kB
  Buffers: shared hit=30
  ->  Nested Loop  (cost=12.40..28.34 rows=200 width=532) (actual time=0.536..0.754 rows=200.00 loops=1)
        Buffers: shared hit=30
        ->  Hash Join  (cost=12.25..17.80 rows=200 width=274) (actual time=0.378..0.468 rows=200.00 loops=1)
              Hash Cond: (r.user_id = u.user_id)
              Buffers: shared hit=4
              ->  Seq Scan on ratings r  (cost=0.00..5.00 rows=200 width=16) (actual time=0.079..0.108 rows=200.00 loops=1)
                    Buffers: shared hit=3
              ->  Hash  (cost=11.00..11.00 rows=100 width=262) (actual time=0.276..0.276 rows=30.00 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 10kB
                    Buffers: shared hit=1
                    ->  Seq Scan on users u  (cost=0.00..11.00 rows=100 width=262) (actual time=0.015..0.021 rows=30.00 loops=1)
                          Buffers: shared hit=1
        ->  Memoize  (cost=0.15..0.41 rows=1 width=262) (actual time=0.001..0.001 rows=1.00 loops=200)
              Cache Key: r.movie_id
              Cache Mode: logical
              Hits: 187  Misses: 13  Evictions: 0  Overflows: 0  Memory Usage: 2kB
              Buffers: shared hit=26
              ->  Index Scan using movies_pkey on movies m  (cost=0.14..0.40 rows=1 width=262) (actual time=0.011..0.011 rows=1.00 loops=13)
                    Index Cond: (movie_id = r.movie_id)
                    Index Searches: 13
                    Buffers: shared hit=26
Planning Time: 3.722 ms
Execution Time: 3.009 ms

2. Identify the join algorithm or algorithms used, such as Nested Loop, Hash 
Join, or Merge Join.

Hash Join and Nested Loop.

3. Explain why PostgreSQL may have selected these algorithms, considering table 
sizes and available indexes.

PostgreSQL used a hash join for ratings and users, scanning the small tables and 
building a hash table for users. It then used a nested loop to look up each 
matching movie through the movies primary-key index. Memoize cached those 
lookups. It had 187 hits and only 13 misses across 200 ratings, because the 
ratings referred to just 13 distinct movie IDs. These choices fit the small 
tables and repeated movie IDs in this data. 

4. Predict which part of the query might become less efficient as the dataset 
grows.

As the number of ratings grows, the sequential scan of ratings and the
ratings to users hash join will have more rows to process. The final sort will
also become more expensive as the joined result grows.
*/