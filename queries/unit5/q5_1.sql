/*
5.1 Connect Producers to their Data

1. Who are the people behind the events? Write a query that joins three tables
to display the user who performed each rating, the movie associated with the
rating, and the rating's date and time. REQUIREMENT: JOIN
*/

SELECT u.user_id, u.user_name, m.movie_id, m.title, r.rated_at
FROM users u
JOIN ratings r ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
ORDER BY u.user_id, m.movie_id;

/*
2. Do the producers identified in Assignment 4 share certain catalog credentials
or tags? Write a query that connects the movie table to the genre table through
the junction table. Return the producers associated with your theme's catalog
tag. REQUIREMENT: JOIN
*/

SELECT m.movie_id, m.title, g.genre_name, mg.tagged_on
FROM movies m
JOIN movie_genres mg ON mg.movie_id = m.movie_id
JOIN genres g ON g.genre_id = mg.genre_id
ORDER BY m.movie_id;

/*
3. How do the producers compare with one another? Write a self join to compare
records within the movie table. Use the results to explore whether the movies
identified in Assignment 4 share characteristics with other movies or whether
differences in activity levels may explain their performance. REQUIREMENT: LEFT 
JOIN
*/

SELECT child.movie_id, child.title, parent.movie_id, parent.title, child.origin_country
FROM movies child
LEFT JOIN movies parent ON child.origin_country = parent.origin_country
ORDER BY child.movie_id, parent.movie_id;

/*
