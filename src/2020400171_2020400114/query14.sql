-- ✅ Query 14
-- Join Team to Match Session by team_ID and Coach to Team by coach_username. Then filter the results to include only the sessions that occur after January 1, 2024, and exclude the coach with the username 'f_akbas'.
-- STR_TO_DATE() is used to convert the date string in the MatchSession table to a date format that can be compared with the date '2024-01-01'.
-- Returns the session_ID, name, and surname of the coaches who meet the specified conditions, sorted by session_ID in ascending order.
;
SELECT M.session_ID, C.name, C.surname
FROM MatchSession M
JOIN Team T ON T.team_ID = M.team_ID
JOIN Coach C ON C.username = T.coach_username
WHERE STR_TO_DATE(M.`date`, '%d.%m.%Y') >= date('2024-01-01') AND C.username != 'f_akbas'
ORDER BY M.session_ID;