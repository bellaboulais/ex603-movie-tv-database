## 6. 1

1. Write a question that needs each row shown next to its group’s average. Explain why the group average alone (GROUP BY) cannot answer it.

Are there a significant number of outlier ratings that are not represented by the average? 

2. Ranking is never neutral: someone is being ordered, and tie handling decides who counts as equal. Name a platform feature that would use your ranking, and explain which of the three functions it should use and why.

A platform feature that would utilize ranking would be showing the most rated (which could imply most watched) movies on the platform as highlights and suggested movies. I would use RANK() so that ties get the same rank number, but the ranks skip after ties. For example, if the fourth rank position has 2 movies in it, the next rank position is 6 instead of 5. I would use this over DENSE_RANK() that doesn't skip positions, because if a ranking count changes and the second movie, for example, becomes rank 5, the other rankings don't get shifted as well which can help maintain clarity and consistency in the leaderboard. 


## 6.2 
1. What would a large delta tell someone about your platform, and what should they do about it?

2. Why does a running total answer a question that a plain SUM cannot?

3. Why did you pick your moving-average window size? A different size tells a different story.

4. What does a gap mean in your platform: a data quality problem, a real stop in activity, or a side effect of how events were recorded? Each needs a different response. Say which one yours is and how you know.

## 6.3 

1. Name the feature in your platform that top-N would power. Explain why three is the right number, rather than one or ten.
2. What would a large month-over-month change mean in your domain, and what should someone do about it? A number nobody acts on is not a metric.

## Reflection (150–250 words)
Write this at the end of /analysis/unit6.md. Window functions keep rows; aggregates collapse them. Describe a reporting question in your theme that is easy with a window function but awkward or impossible with GROUP BY alone. Explain why.