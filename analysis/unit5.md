## 5.1 

1. What feature or report on your platform could use the three-table join from Question 1? What information would it display?

The three table join could be used for a feature that summarizes a users ratings. It provided the movie title and the date of the rating, which can be used for a timeline-structured summary to show the user which movies they have rated. 

2. Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

The junction table is important for answering question 2 because there is a many to many relationship between movies and genres, and having the junction table allows us to query for movies with specific genres. Without the junction table, we would have to store the genres as a list in the movie table, making it harder to query if we are looking for a specific genre. 

## 5.2

1. Which producers were excluded by the inner join? Report their identifiers.



2. What does it mean when a producer has no events? What are some possible explanations?



3. How could a report based only on an inner join give leadership an incomplete picture of the platform?



4. Why might leadership want to identify producers who have never been active?



5. What action could leadership take based on these findings. Distinguish between what your data shows and what would require further investigation. For example, a producer with no events may be inactive, but the data alone may not explain why.



## 5. 3

1. Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.

2. Which join algorithms did PostgreSQL choose for your query?

3. What information in the execution plan helps explain those choices?

4. Why is it useful to understand the selected join algorithms?

5. What changes to the data or database might make another join algorithm more appropriate?
Support your explanation with observations from your execution plan.