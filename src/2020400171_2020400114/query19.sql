-- ✅ Query 19
-- Join MatchSession to SessionSquads by session_ID, Position by position_ID, and Player by played_player_username. 
-- Filter the results to include only the players who have played as a 'Libero' in the 'GD Voleybol Arena' stadium. 
-- Overall its a simple join query with multiple tables and a WHERE clause to filter the results.
-- Return the name and surname of the players from Player table who meet the specified conditions.
;
SELECT DISTINCT P.name, P.surname
FROM SessionSquads SS
JOIN MatchSession MS ON MS.session_ID = SS.session_ID
JOIN Position POS ON SS.position_ID = POS.position_ID
JOIN Player P ON P.username = SS.played_player_username
WHERE POS.position_name = 'Libero' AND MS.stadium_name = 'GD Voleybol Arena';