-- ✅ Query 16
-- Join MatchSession to Team by team_ID and Team to Coach by coach_username. Then group the results by coach username and calculate the average rating of the sessions for each coach with AVG() aggregate function on the rating. Sort the results by average rating in descending order.
SELECT C.name, C.surname, AVG(MS.rating) as average_rating FROM
MatchSession MS
JOIN Team T ON T.team_ID = MS.team_ID
JOIN Coach C ON C.username = T.coach_username
GROUP BY C.username
ORDER BY average_rating DESC;