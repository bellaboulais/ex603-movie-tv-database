## 6. 1

1. Write a question that needs each row shown next to its group’s average. Explain why the group average alone (GROUP BY) cannot answer it.

Are there a significant number of outlier ratings that are not represented by the average? 

2. Ranking is never neutral: someone is being ordered, and tie handling decides who counts as equal. Name a platform feature that would use your ranking, and explain which of the three functions it should use and why.

A platform feature that would utilize ranking would be showing the most rated (which could imply most watched) movies on the platform as highlights and suggested movies. I would use RANK() so that ties get the same rank number, but the ranks skip after ties. For example, if the fourth rank position has 2 movies in it, the next rank position is 6 instead of 5. I would use this over DENSE_RANK() that doesn't skip positions, because if a ranking count changes and the second movie, for example, becomes rank 5, the other rankings don't get shifted as well which can help maintain clarity and consistency in the leaderboard. 

## 6.2 

1. What would a large delta tell someone about your platform, and what should they do about it?

A large change between consecutive ratings for a movie could reflect a rapid shift in user opinion or a recording error. I would review the ratings and comments around the change and check the data for errors.

2. Why does a running total answer a question that a plain SUM cannot?

A running total shows how rating points accumulate over time and when the platform reaches its target. A plain `SUM` gives only the final total, not the progress or when the target was reached.

3. Why did you pick your moving-average window size? A different size tells a different story.

I used the most recent seven ratings to smooth individual fluctuations while still responding to recent changes. A shorter window would be more reactive, while a longer one would smooth the recent chanegs more.

4. What does a gap mean in your platform: a data quality problem, a real stop in activity, or a side effect of how events were recorded? Each needs a different response. Say which one yours is and how you know.

The query finds gaps longer than 50 days between ratings for a movie, so I would describe this as a pause in recorded activity. I would look at logs of the system to determine whether ratings were missing or the movie became unavailable to rate.

## 6.3 

1. Name the feature in your platform that top-N would power. Explain why three is the right number, rather than one or ten.

A top-three feature could power a "best ratings" section on each movie’s page. Three is more useful than one because it shows a small range of positive feedback. 10 could overwhelm users and cause them to ignore the feature altogether. 

2. What would a large month-over-month change mean in your domain, and what should someone do about it? A number nobody acts on is not a metric.

A large increase could mean a movie or the platform is receiving better user ratings, while a large decrease could indicate poor reception or a data issue. We should investigate the most-rated or lowest-rated movies from that month and compare them with releases or marketing campaigns.

## Reflection (150–250 words)

Write this at the end of /analysis/unit6.md. Window functions keep rows; aggregates collapse them. Describe a reporting question in your theme that is easy with a window function but awkward or impossible with GROUP BY alone. Explain why.

A reporting question might ask, “Which specific ratings are unusually high or low for the movie they belong to?” The window function keeps every rating, user, and rating date while placing the movie average beside each value. This allows the platform to investigate unusual ratings and determine whether they come from an unusual reviewer, a recent change in audience opinion, or a possible data issue.

A `GROUP BY` query can calculate the average for each movie, but it collapses all of that movie’s ratings into one row. It cannot show how an individual rating compares to the average or retain the `rating_id`, `user_id`, and date needed for further analysis. Although `GROUP BY` is useful for final totals and summaries, it is awkward for individual-to-group comparisons because each original row is needed. For example, the team could identify a rating that is much higher than its movie’s average and then review that user’s comments. It could also rank the highest ratings or compare the rating with the next rating in time. 
