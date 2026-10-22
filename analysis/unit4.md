# Unit 4 Analysis

## Task 4.1 Write Up
Name the person who would act on the per-producer breakdown, and say what the 
aggregate hides — an average conceals its distribution, a count conceals who 
is counted. What would you need to see next?

Leadership is looking at the per-movie breakdown to determine movie performance 
based on user perferences. The aggregate AVG hides NULL values as well as 
multiple ratings by one user. Some user recorded ratings might have NULL scores 
due to system issues with recording ratings, or maybe they did not enter a 
score. Either way, leadership needs to know how many ratings were 'dropped' 
because they were NULL in case there is an issue in the rating service that 
needs to be remedied. Additionally, there is nothing currently blocking a user 
from submitting multiple ratings for a movie. The next thing I would like to see 
is how many unique ratings there are for each movie, and if we can only take the 
latest rating for the AVG scores. 

## Task 4.2 Write Up
For Part A, state the two questions your conditional aggregation answers side by
side.

For Part B, name the reader who needs subtotals rather than detail rows, and say
what decision the grand total supports that the group rows do not.

For Part C, state the question the pipeline answers.