-- 4.1 Measure the platform - Calculate the platform's actual performance
-- metrics and examine how they vary across producers.

-- 1. Calculate the the count, total, average, minimum, and maximum, and how 
-- many distinct actors (users) appear across the entire ratings table using 
-- score as the metric. REQUIREMENTS: COUNT, SUM, AVG, MIN, MAX, COUNT(DISTINCT)

SELECT COUNT(*) AS count_ratings,
       SUM(score) AS total,
       AVG(score) AS average,
       MIN(score) AS minimum,
       MAX(score) AS maximum,
       COUNT(DISTINCT user_id) AS count_users
FROM ratings

-- 2. Write a query that calculates the ratings count and average score for each 
-- movie. Sort the results from the movie with the most events to the movie with
-- the fewest. REQUIREMENTS: COUNT, AVG, GROUP BY, ORDER BY

SELECT movie_id, COUNT(*) AS ratings_count, 
       ROUND(AVG(score), 2) AS average_score
FROM ratings
GROUP BY movie_id
ORDER BY ratings_count DESC

-- 3. Choose a minimum event-count threshold and use HAVING to include only 
-- producers who meet that threshold. REQUIREMENTS: HAVING

-- Minimum event-count: 15
-- I chose 15 because this is the average rating count for each movie. I got 
-- this by adding the ratings_count coloumn together and divided by the total 
-- ratings count from question 1. 

SELECT movie_id, COUNT(*) AS ratings_count, 
       ROUND(AVG(score), 2) AS average_score
FROM ratings
GROUP BY movie_id
HAVING COUNT(*) > 15
ORDER BY ratings_count DESC

-- 4. Write a query that groups the data by two dimensions, including region, 
-- and calculates the relevant summary statistics. REQUIREMENTS: COUNT, AVG,
-- MIN, MAX, GROUP BY

SELECT movie_id,
       device_country AS region,
       COUNT(*) AS ratings_count,
       ROUND(AVG(score), 2) AS average_score,
       MIN(score) AS minimum_score,
       MAX(score) AS maximum_score,
       COUNT(DISTINCT user_id) AS distinct_users
FROM ratings
GROUP BY movie_id, device_country