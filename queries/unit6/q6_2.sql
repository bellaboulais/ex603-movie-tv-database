/*
actor = users
producer = movies
events = ratings
catalogue = genres
junction = movies_genres
metric = score

Task 6.2: Compare each row to its neighbors
Part A: Row to row
Is a producer’s metric going up or down over time, not just high or low overall? 
For each event, show the metric from the previous event and the next event, in 
time order.

✓  LAG() and LEAD(), partitioned by producer and ordered by timestamp.

✓  A delta column: the current metric minus the previous metric.

✓  In the final output, filter to one producer of your choice so the trend is 
   easy to read.



Part B: Cumulative and smoothed
How is the platform doing over time, both in total and on a recent average? 
Leadership wants to see where things stand now and how they got there.

✓  SUM(...) OVER (ORDER BY ... ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   for a running total.

✓	AVG(...) OVER (... ROWS BETWEEN n PRECEDING AND CURRENT ROW) for a moving 
    average. Note: ROWS counts rows, not days. If some days have no events, a 
    7-row window covers more than 7 days.

✓	Choose a target (for example, a total for the quarter), state it, and show 
    how close the running total gets to it.

✓	One or two sentences on how ROWS differs from RANGE when two rows have the 
    same ORDER BY value.



Part C: Where the series stops
One producer stops for a while and then starts again. Find that gap. Then think 
about what you cannot tell yet: did the producer leave, or did your data lose 
them?

✓  LAG() or LEAD() comparing adjacent rows.

✓  A CTE or subquery that computes the gap, and a WHERE in the outer query that 
   keeps only the gaps. (You cannot filter a window function result with WHERE 
   or HAVING in the same query, because the window function runs after them.)

*/