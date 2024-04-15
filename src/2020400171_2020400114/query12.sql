-- ✅ Query 12
-- Group match sessions by year and team, then find the average rating for each of them in a subquery.
-- Join team and coach tables to be able to return the name and surname of the coach.
-- Group the subquery by year and find the maximum rating for each year.
-- Compare the rating and year fields of the two subqueries to find the team with the highest average rating for each year.
-- Return the name and surname of the coach of the team with the highest average rating for each year.
-- Sort the results by year in ascending order.
;
SELECT
	C.name,
	C.surname,
	sub_query.year,
	sub_query.avg_rating AS average_rating
FROM (
	SELECT
		AVG(M.rating) AS avg_rating,
		SUBSTRING(M.date, 7, 9) AS year,
		M.team_ID
	FROM
		MatchSession M
	GROUP BY
		SUBSTRING(M.date, 7, 9),
		M.team_ID) AS sub_query
	INNER JOIN Team T ON sub_query.team_ID = T.team_ID
	INNER JOIN Coach C ON T.coach_username = C.username,
	(
		SELECT
			max(sub_query.avg_rating) AS avg_rating,
			sub_query.year AS year
		FROM (
			SELECT
				AVG(M.rating) AS avg_rating,
				SUBSTRING(M.date, 7, 9) AS year,
				M.team_ID
			FROM
				MatchSession M
			GROUP BY
				SUBSTRING(M.date, 7, 9),
				M.team_ID) AS sub_query
		GROUP BY
			sub_query.year) AS max_ratings
WHERE
	max_ratings.avg_rating = sub_query.avg_rating
	AND max_ratings.year = sub_query.year
ORDER BY
	sub_query.year ASC;