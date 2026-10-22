# Unit 4 Analysis

## Task 4.1 Write Up

### Name the person who would act on the per-producer breakdown, and say what the aggregate hides — an average conceals its distribution, a count conceals who is counted. What would you need to see next?

Leadership is looking at the per-movie breakdown to determine movie performance based on user perferences. The aggregate AVG hides NULL values as well as multiple ratings by one user. Some user recorded ratings might have NULL scores due to system issues with recording ratings, or maybe they did not enter a score. Either way, leadership needs to know how many ratings were 'dropped' because they were NULL in case there is an issue in the rating service that needs to be remedied. Additionally, there is nothing currently blocking a user from submitting multiple ratings for a movie. The next thing I would like to see is how many unique ratings there are for each movie, and if we can only take the latest rating for the AVG scores. 

## Task 4.2 Write Up

### For Part A, state the two questions your conditional aggregation answers side by side.

The two questions my conditional aggregation answers are how many total ratings are there for this movie, and how many of those ratings were withdrawn. 

### For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not.

The reader who would need the subtotals per region would be the Leadership and teams of that region making decisions about its users. The grand total supports decisions having to do with system performance, where the group rows provide insights into user activity in the region.

### For Part C, state the question the pipeline answers.

The pipeline answers the question which movies have a higher-than-average number of ratings by distinct users. 

## Reflection (150–250 words)

#### Conditional aggregation computes several answers in one pass over the data. Contrast that with running two separate filtered queries. At a million rows, why does the difference matter?

Conditional aggregation combines several calculations into a single query, meaning the database only needs one pass through to calculate multiple answers. For example, my query to find the total ratings and ratings that were withdrawn can be combined into a single select statement such as “SELECT COUNT(*), SUM(CASE WHEN rating_status = ‘withdrawn’ THEN 1 ELSE 0 END)”. At each row, it calculates both the count and the sum. With two separate queries, we would first pass through the database to calculate COUNT(*), and then we would have to do a second pass to calculate the SUM(...). With just 2 calculations, there is not much performance difference between a conditional aggregation statement vs multiple queries. At a million rows, this can add unnecessary processing time and decrease the efficiency of your system, because you would have to pass through a million rows of the database twice. For large datasets, it is better to use conditional aggregation, in order to simplify the query and reduce DB passes as much as possible. 