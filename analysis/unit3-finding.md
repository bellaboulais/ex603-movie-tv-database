# Task 3.4: Write the finding

### The memo

The dashboard showed 22 ratings whose withdrawal reason was not “Spam detected.” The data shows there are actually 188 ratings whose withdrawal reason was not "Spam detected." The full set contains 200 total ratings, with 166 that have no reason recorded (NULL). 12 are marked “Spam detected”, and the 22 the dashboard cited are ratings with other defined reasons. If the goal is to find every rating that was not marked as spam, the actual total is 188, including the 166 with no recorded reason.

The dashboard missed those 166 because SQL will treat a NULL value as unknown, and queries trying to find equality/inequality against a NULL will not be correct and could fail. Instead, we must query with IN/NOT IN, filter out NULL values, or use EXISTS to correctly handle NULL values. The frozen payout should be lifted, as this was a querying mistake and not a system or database mistake. 