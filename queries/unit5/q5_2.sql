/* 
5.2 Find Records That Joins May Exclude

Part A: Compare INNER JOIN and LEFT JOIN
*/

/*
1. Use LEFT JOIN to return all producers, including those who have never had an
event. REQUIREMENT: LEFT JOIN
*/

SELECT m.movie_id, m.title, COUNT(r.rating_id) as rating_count
FROM movies m
LEFT JOIN ratings r ON r.movie_id = m.movie_id
GROUP BY m.movie_id
ORDER BY m.movie_id;

-- 2. Write an equivalent query using INNER JOIN. REQUIREMENT: INNER JOIN

SELECT m.movie_id, m.title, COUNT(r.rating_id) as rating_count
FROM movies m
JOIN ratings r ON r.movie_id = m.movie_id
GROUP BY m.movie_id
ORDER BY m.movie_id;

/* 
3. Compare the results and determine how many producers are excluded by the 
inner join.

2 movies were excluded. 
*/

/*
4. Explain which producers are missing and why.

In the second query, movie_id's 14 and 15 were excluded because their count was
0, meaning they did not have any associated ratings. The inner join only keeps
rows with matching keys. Since movie_id 14 and movie_15 didn't have a rating in
the ratings table, they were excluded from the join.
*/


-- Part B: Explore RIGHT JOIN and FULL OUTER JOIN

/*
1. Write a RIGHT JOIN that returns the same records as your LEFT JOIN from Part 
A. REQUIREMENT: RIGHT JOIN

2. Compare the results to confirm that they match. ✓
*/ 

SELECT m.movie_id, m.title, COUNT(r.rating_id) as rating_count
FROM ratings r
RIGHT JOIN movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id
ORDER BY m.movie_id;

/*
3. Write a FULL OUTER JOIN that includes matching and unmatched records from 
both tables. REQUIREMENT: FULL OUTER JOIN
*/

SELECT COALESCE(m.movie_id, r.movie_id) AS movie_id,
       m.title,
       COUNT(r.rating_id) AS rating_count
FROM movies m
FULL OUTER JOIN ratings r ON r.movie_id = m.movie_id
GROUP BY COALESCE(m.movie_id, r.movie_id), m.title
ORDER BY movie_id;

/*
4. Explain what a full outer join can reveal that a left join or 
right join alone may not show. 

Be sure to verify your results rather than assuming the queries are equivalent.

A LEFT JOIN preserves every movie while a RIGHT JOIN preserves every rating. A
FULL OUTER JOIN preserves both, so it can also reveal ratings without a
matching movie. The foreign key from ratings.movie_id to movies.movie_id 
prevents orphan ratings while enforced, so the full join should return the same
movies and rating counts as the LEFT JOIN here.
*/

/*
Part C: Find Producers with No Events Using Two Approaches

Write two queries that identify producers who have never had an event and 
compare them.

✓  NOT EXISTS.
✓  EXCEPT.

Run both queries and compare their results. In one or two sentences, explain how
the approaches differ and confirm whether they identify the same producers.
*/

-- NOT EXISTS
SELECT m.movie_id, m.title
FROM movies m
WHERE NOT EXISTS (
    SELECT 1
    FROM ratings r
    WHERE r.movie_id = m.movie_id
)
ORDER BY m.movie_id;

-- EXCEPT
SELECT movie_id, title
FROM movies
EXCEPT
SELECT m.movie_id, m.title
FROM movies m
JOIN ratings r ON r.movie_id = m.movie_id
ORDER BY movie_id;

/* 
NOT EXISTS checks each movie for a matching rating, while EXCEPT removes rated
movies from the full movie list. Both return movie IDs 14 and 15.
*/