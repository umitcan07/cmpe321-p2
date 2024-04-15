-- ✅ Query 13
-- Join the MatchSession table with the Team and Coach tables by matching the team_ID and coach_username columns.
-- Return the stadium_name, name, surname, and the number of sessions directed by each coach in each stadium.
-- Filter the results to include only the coaches who directed the most sessions in each stadium.
-- Sort the result by stadium_name in ascending order, and then by the number of directed sessions in descending order.
-- Uses a subquery to determine the maximum number of directed sessions for each stadium before filtering the results to include only the coaches with that maximum count.
;
SELECT
	MS.stadium_name,
	C.name,
	C.surname,
	COUNT(*) AS directed_count
FROM
	MatchSession MS
	JOIN Team T ON T.team_ID = MS.team_ID
	JOIN Coach C ON C.username = T.coach_username
GROUP BY
	MS.stadium_name,
	C.name,
	C.surname
HAVING
	COUNT(*) = (
		SELECT
			MAX(directed_count)
		FROM (
			SELECT
				COUNT(*) AS directed_count
			FROM
				MatchSession MS2
				JOIN Team T2 ON T2.team_ID = MS2.team_ID
				JOIN Coach C2 ON C2.username = T2.coach_username
			WHERE
				MS2.stadium_name = MS.stadium_name
			GROUP BY
				C2.username) AS Subquery)
	ORDER BY
		MS.stadium_name,
		directed_count DESC;