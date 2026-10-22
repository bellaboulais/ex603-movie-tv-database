# Unit 4 Finding

## The Breakdown

#### What is the true failure rate, how does it vary across movies, and which two or three producers would you actually investigate? Report by identifier. Write for a reader who does not write SQL.

Across 200 rating events, 34 were withdrawn, so the true failure rate is 17.0%.

| Movie ID | Withdrawn ratings | Total ratings | Failure rate |
|---:|---:|---:|---:|
| 1 | 2 | 11 | 18.2% |
| 2 | 4 | 16 | 25.0% |
| 3 | 3 | 13 | 23.1% |
| 4 | 2 | 6 | 33.3% |
| 5 | 3 | 18 | 16.7% |
| 6 | 4 | 21 | 19.0% |
| 7 | 3 | 18 | 16.7% |
| 8 | 1 | 20 | 5.0% |
| 9 | 4 | 14 | 28.6% |
| 10 | 0 | 19 | 0.0% |
| 11 | 5 | 16 | 31.3% |
| 12 | 2 | 17 | 11.8% |
| 13 | 1 | 11 | 9.1% |

I would investigate movie_id's 2, 10 and 11. I classified high-volume movies as movies with more distinct ratings by user than the average. These movies each have more user-distinct rating than the average (11.8), and therefore cover a larger area of users interactinf with the system. They also have rating-withdrawal rates that are either significantly lower or higher than the average (17%). Movie 10 has a 0.0% withdrawal rate and movie 11 has 31.3%.
