-- ✅ Query 3
-- Find the minimum rating across all matchsessions in a subquery and select all columns from MatchSession where the rating is equal to the minimum rating.
-- Finding Min in a subquery is similar to Query 1 syntax-wise. The only difference is MIN(rating) is used instead of COUNT(*).
;
SELECT
	*
FROM
	MatchSession
WHERE
	rating = (
		SELECT
			MIN(rating)
		FROM
			MatchSession);