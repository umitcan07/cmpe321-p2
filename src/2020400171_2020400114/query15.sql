-- ✅ Query 15
-- Group match sessions by juries and then count rated sessions for each jury in a subquery. Order within the subquery by the number of rated sessions in descending order and limit the result to 1 to get the maximum number of rated sessions by a jury.
-- Then, join the jury table with the match session table and group by the assigned jury username. Filter the results to include only the juries who have rated the maximum number of sessions.
;
SELECT
	J.name,
	J.surname,
	COUNT(*) AS rated_sessions
FROM
	MatchSession MS
	JOIN Jury J ON J.username = MS.assigned_jury_username
GROUP BY
	MS.assigned_jury_username
HAVING
	rated_sessions = (
		SELECT
			COUNT(*) AS rated_sessions
		FROM
			MatchSession MS
			JOIN Jury J ON J.username = MS.assigned_jury_username
		GROUP BY
			MS.assigned_jury_username
		ORDER BY
			rated_sessions DESC
		LIMIT 1);