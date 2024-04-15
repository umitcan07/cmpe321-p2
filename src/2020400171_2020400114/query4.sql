-- ✅ Query 4
-- Find the maximum rating across all match sessions in a subquery and select the assigned_jury_username and stadium_name columns from MatchSession where the rating is equal to the maximum rating. Sort the result by assigned_jury_username in descending order.
;
SELECT
	assigned_jury_username,
	stadium_name
FROM
	MatchSession
WHERE
	rating = (
		SELECT	MAX(rating)
		FROM MatchSession )
ORDER BY
	assigned_jury_username DESC;