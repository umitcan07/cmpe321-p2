-- ✅ Query 8
-- Merge match sessions with the teams, then merge with the coaches, and group by the coaches.
-- In the resulting view, list the names and surnames of the coaches with at least 2 match sessions.
;
SELECT
	C.name,
	C.surname
FROM
	MatchSession M
	JOIN Team T ON T.team_ID = M.team_ID
	JOIN Coach C ON T.coach_username = C.username
GROUP BY
	C.username
HAVING
	COUNT(M.session_ID) >= 2
ORDER BY
	C.surname DESC;