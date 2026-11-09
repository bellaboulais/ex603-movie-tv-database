## The memo

You now know which producers fail often and which never started. Recommend a concrete action for each group. The producers who never started demand a different response from the ones who fail often, and saying so precisely is the point. Write for a non-technical reader.

Movie 11 had the most withdrawn ratings with 5 out of 16 (31.3%). Movie 2 had 4 out of 16 (25%), also above the platform-wide rate of 17%. Leadership should review the withdrawal reasons and rating process for these movies to see whether there is a recurring issue. Movies 14 and 15 had no ratings. Leadership should first check that they are available and easy to find, then consider whether they need more visibility. 

## Reflection (150–250 words)

In Task 5.3, you examined the execution plan for your three-table join. Reflect on the following question: What changes to your data or database schema might cause PostgreSQL to choose a different join algorithm?

The plan used a Hash Join to connect users with ratings, then a Nested Loop to find the movies. The ratings table had 200 rows, and the movie primary-key index plus Memoize made repeated movie lookups efficient. If the ratings table grew much larger, PostgreSQL might use a Hash Join to connect ratings and movies rather than performing repeated index lookups. If only a small number of ratings matched, an indexed Nested Loop could also be faster. Adding indexes to the ratings foreign-key columns might also change the cost of lookups, while indexes that keep join columns ordered could use a Merge Join. In this plan, the final sort handled 200 rows using 35 kB. With many more results, sorting could take more time and memory.