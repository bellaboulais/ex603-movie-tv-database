-- Task 3.2 — the broken query, the count of what it dropped, and the repair. 

-- Part A: The rows that vanished

-- Inequality predicate on withdrawn_reason: 22 rows
SELECT COUNT(*) AS returned_rows
FROM ratings
WHERE withdrawn_reason <> 'Spam detected';

-- Count the rows silently omitted: 166
SELECT COUNT(*) AS omitted_null_rows
FROM ratings
WHERE withdrawn_reason IS NULL;

-- Compare counts: 22 returned + 166 omitted is less than the 200 rows.
SELECT COUNT(*) AS total_rows
FROM ratings;

-- Repair to include NULL reasons: 188
SELECT withdrawn_reason
FROM ratings
WHERE withdrawn_reason <> 'Spam detected'
   OR withdrawn_reason IS NULL;


-- Part B: The alias that did not exist yet

-- 1. Repeat expression in WHERE.
SELECT rating_id, score, weight, score * weight AS weighted_score
FROM ratings
WHERE score * weight > 4;

-- 2. Wrap the query in a subquery
SELECT rating_id, score, weight, weighted_score
FROM (
    SELECT rating_id, score, weight, score * weight AS weighted_score
    FROM ratings
) AS rated_scores
WHERE weighted_score > 4;
