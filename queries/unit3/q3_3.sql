-- Task 3.3 - Hand the team a corrected query

-- Two-step question: Which users have at least one flagged or withdrawn rating?

-- 1. First as a subquery using IN or NOT IN.
SELECT u.user_id, u.user_name
FROM users AS u
WHERE u.user_id IN (
    SELECT r.user_id
    FROM ratings AS r
    WHERE r.rating_status IN ('flagged', 'withdrawn')
)
ORDER BY u.user_id;

-- 2. Then as a Common Table Expression using WITH.
WITH disputed_users AS (
    SELECT DISTINCT user_id
    FROM ratings
    WHERE rating_status IN ('flagged', 'withdrawn')
)
SELECT u.user_id, u.user_name
FROM users AS u
JOIN disputed_users AS d ON d.user_id = u.user_id
ORDER BY u.user_id;

-- 3.Then a third way, distinct from both — a different subquery form, a
-- CASE-based construction, or a set-based approach.
SELECT u.user_id, u.user_name
FROM users AS u
WHERE EXISTS (
    SELECT 1
    FROM ratings AS r
    WHERE r.user_id = u.user_id
      AND r.rating_status IN ('flagged', 'withdrawn')
)
ORDER BY u.user_id;

-- 4. Demonstrate that all three return identical result sets. Matching row 
-- counts is not enough: show that the rows themselves match.

-- See `3.3.4_3_queries_user_flagged_withdrawn_ratings` screenshot for matching
-- rows.

-- 5. Name one input condition under which the three would not be equivalent.

-- As written, these three return the same users, even if a user has multiple
-- disputed ratings. If DISTINCT were removed from the CTE and a user had
-- multiple flagged or withdrawn ratings, the JOIN would return that user more 
-- than once, while the IN and EXISTS queries would return the user only once.