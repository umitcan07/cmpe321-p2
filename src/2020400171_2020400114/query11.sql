-- ✅ Query 11
-- Join the MatchSession table with the Team and Coach tables by matching the team_ID and coach_username columns. 
-- Return the session_ID, name, surname, stadium_name, stadium_country, and team_name of the coaches whose full name is 'Daniele Santarelli' and the stadium_country is not 'UK'. 
-- Use CONCAT() to concatenate the name and surname of coaches.
-- Sort the result by session_ID in ascending order.
;
SELECT M.session_ID, C.`name`, C.surname, M.stadium_name, M.stadium_country, T.team_name
FROM MatchSession M
LEFT JOIN Team T ON M.team_ID = T.team_ID
LEFT JOIN Coach C ON C.username = T.coach_username
WHERE
	CONCAT(C.name, C.surname) = 'Daniele Santarelli' AND M.stadium_country != 'UK'
ORDER BY
	M.session_ID;