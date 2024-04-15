-- ✅ Query 9
-- In separate subqueries, find the date_of_birth and height of the player whose name is 'Ebrar Karakurt'.
-- Then, select the names and surnames of the players who were born in the same year and are taller than 'Ebrar Karakurt'. Sort the results by surname in ascending order.
-- Use DATE() to convert the date_of_birth to a date and YEAR() to extract the year.
;
SELECT
	P.name,
	P.surname
FROM
	Player P
WHERE
	YEAR(STR_TO_DATE(P.date_of_birth, '%d/%m/%Y')) = (
		SELECT
			YEAR(STR_TO_DATE(date_of_birth, '%d/%m/%Y'))
		FROM
			Player P
		WHERE
			CONCAT(P.`name`, P.surname) = 'Ebrar Karakurt'
			)
	AND P.height > (
		SELECT
			height
		FROM
			Player
		WHERE
			`name` = 'Ebrar '
			AND surname = 'Karakurt')
ORDER BY
	P.surname ASC;