-- ✅ Query 20
-- Join the Player table to the PlayerPositions table by username. Group the players by their username and count the number of distinct positions they have played in. Filter the results to include only the players who have played in more than one position.
-- To get the more_than_one column, use a CASE statement to check if the count of distinct positions is greater than 1. If it is, return 'TRUE', otherwise return 'FALSE'.
;
SELECT
	name,
	surname,
	(CASE WHEN COUNT(DISTINCT PlayerPositions.position) > 1 THEN 'TRUE' ELSE 'FALSE' END) as more_than_one
FROM
	Player
	INNER JOIN PlayerPositions ON PlayerPositions.username = Player.username
GROUP BY
	Player.username
ORDER BY
	name ASC;