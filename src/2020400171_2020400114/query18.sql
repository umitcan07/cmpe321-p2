-- ✅ Query 18
-- Join Team to Coach by coach_username and MatchSession to Team by team_ID. Group the coaches by their username and count the number of distinct stadiums they have directed matches in. Filter the results to include only the coaches who have directed matches in all stadiums. 
-- Return the name and surname of the coaches who meet the specified conditions.
-- To get the directed_stadium_count in a subquery, count the number of distinct stadium names in the MatchSession table where the stadium_name is not NULL.
;
SELECT
	C.name,
	C.surname,
	COUNT(DISTINCT MS.stadium_name) AS directed_stadium_count
FROM
	Coach C
	LEFT JOIN Team T ON T.coach_username = C.username
	LEFT JOIN MatchSession MS ON MS.team_ID = T.team_ID
GROUP BY
	C.username
HAVING
	directed_stadium_count = (
		SELECT
			COUNT(DISTINCT stadium_name)
		FROM
			MatchSession MS
		WHERE
			MS.stadium_name IS NOT NULL);