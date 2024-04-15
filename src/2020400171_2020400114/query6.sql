-- ✅ Query 6
-- List all teams together with the number of players in each Team. 
-- Notice that in the Team table, each team id is unique. However, different IDs may have same team names as different agreements with coaches in the past were needed to be recorded. 
-- Note that there may be empty teams. The required column names are respectively: team name, coach name, coach surname, player count.
;
SELECT
	T.team_name,
	C.name AS coach_name,
	C.surname AS coach_surname,
	COUNT(P.player_teams_id) AS player_count
FROM
	Team T
	LEFT JOIN PlayerTeams P ON T.team_ID = P.team
	JOIN Coach C ON T.coach_username = C.username
GROUP BY
	T.team_ID,
	T.team_name,
	C.name,
	C.surname
ORDER BY
	player_count DESC;