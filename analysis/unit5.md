## 5.1 

1. What feature or report on your platform could use the three-table join from Question 1? What information would it display?

The three table join could be used for a feature that summarizes a users ratings. It provided the movie title and the date of the rating, which can be used for a timeline-structured summary to show the user which movies they have rated. 

2. Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

The junction table is important for answering question 2 because there is a many to many relationship between movies and genres, and having the junction table allows us to query for movies with specific genres. Without the junction table, we would have to store the genres as a list in the movie table, making it harder to query if we are looking for a specific genre. 

## 5.2

1. Which producers were excluded by the inner join? Report their identifiers.

The movies excluded by the inner join were id's 14 and 15. 

2. What does it mean when a producer has no events? What are some possible explanations?

When a producer has no events this mean a movie has no ratings. This is possible when no users rate the movie or it could be a new movie that hasn't been watched or rated yet by the users. 

3. How could a report based only on an inner join give leadership an incomplete picture of the platform?

A report based only on the inner join would leave out movies with no ratings. This would give an incomplete picture, because there could be reasons the movie has no ratings, maybe an error of the platform, an unpopular movie, bad marketing, or just a new movie release. These are important aspects to investigate, and if the report did not present the movies with no ratings, then leadership would not investigate. 

4. Why might leadership want to identify producers who have never been active?

As stated above, leadership might want to identify movies who have no ratings, because it could be bad marketing or a lack of exposure to the movie. It could also be a fault of the system, where we are actually losing ratings on those movies due to a bug. 

5. What action could leadership take based on these findings. Distinguish between what your data shows and what would require further investigation. For example, a producer with no events may be inactive, but the data alone may not explain why.

Leadership could investigate that if a rating is made on those producers that they get recorded to make sure there is no bug. Once that is confirmed, further investigation would be needed that the data can't show. How are the movies presented on the platform? Are they easily accessed or searched? Is it a new movie? 

## 5. 3

1. Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.

It could pair every user with every movie to create a test matrix. It is only useful when all combinations are wanted.

2. Which join algorithms did PostgreSQL choose for your query?

PostgreSQL used a Hash Join for users and ratings, then a Nested Loop to find matching movies.

3. What information in the execution plan helps explain those choices?

The plan scanned 200 ratings and 30 users, built a small hash table for users, and used the movie primary-key index. Memoize reused movie lookups, with 187 hits and 13 misses.

4. Why is it useful to understand the selected join algorithms?

It helps explain query performance and identify what could slow down as the data grows.

5. What changes to the data or database might make another join algorithm more appropriate?
Support your explanation with observations from your execution plan.

With many more ratings, a hash join may be more efficient than repeated nested-loop lookups. The current plan uses a Nested Loop with an indexed movie lookup and Memoize, which works well here because there are only 13 distinct movie IDs among 200 ratings.