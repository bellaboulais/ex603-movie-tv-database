/* 
Task 6.3: Build the reporting patterns
Two patterns you will meet in nearly every analytics job.
actor = users
producer = movies
events = ratings
catalogue = genres
junction = movie_genres
metric = rating


Part A: Top N per category
Return the top three events by metric for each producer. Most leaderboards and 
recommendation features are built this way.

✓   A ranking window function, partitioned by producer.

✓	A CTE or subquery that filters to rank <= 3.

✓   FIRST_VALUE() or LAST_VALUE() used somewhere in your solution. If you use 
    LAST_VALUE(), add ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING; 
    with the default frame it returns the wrong value.

✓	A comment saying how ties at third place are handled, and why.



Part B: Period over period
Is the platform getting better or worse each month? This is the founder’s real 
question. Group your events by calendar month, then compare each month with the 
month before.

✓	Group events into months (for example, with DATE_TRUNC('month', ...)).

✓	LAG() over the monthly series.

✓	A percent-change column that avoids division by zero (for example, with 
    NULLIF(..., 0)).

✓	A check for missing months. LAG counts rows, so a missing month makes it 
    compare the wrong months.
*/