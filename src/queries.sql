-- ✅ Query 1
-- Use the aggregation function "Count" to count the number of players in the Player table.
;
SELECT
	COUNT(*) AS player_count
FROM
	Player;

-- ✅ Query 2
-- Select session_ID, assigned_jury_username, rating directly and format the date column to display in the format "dd/mm/yyyy". Upon selecting the columns, filter the rows where the date is before 2024-01-01 and order the results by date in ascending order. Order the results by date in ascending order. 
-- Use the STR_TO_DATE function to convert the date column to a date format. Use the DATE_FORMAT function to format the date column to display in the format "dd/mm/yyyy".
;
SELECT
	session_ID,
	assigned_jury_username,
	rating,
	DATE_FORMAT(STR_TO_DATE(`date`, '%d.%m.%Y'), '%d/%m/%Y') AS `date`
FROM
	MatchSession
WHERE
	STR_TO_DATE(`date`, '%d.%m.%Y') < date('2024-01-01')
ORDER BY
	STR_TO_DATE(`date`, '%d.%m.%Y') ASC;

-- ✅ Query 3
-- Find the minimum rating across all matchsessions in a subquery and select all columns from MatchSession where the rating is equal to the minimum rating.
-- Finding Min in a subquery is similar to Query 1 syntax-wise. The only difference is MIN(rating) is used instead of COUNT(*).
;
SELECT
	*
FROM
	MatchSession
WHERE
	rating = (
		SELECT
			MIN(rating)
		FROM
			MatchSession);

-- ✅ Query 4
-- Find the maximum rating across all match sessions in a subquery and select the assigned_jury_username and stadium_name columns from MatchSession where the rating is equal to the maximum rating. Sort the result by assigned_jury_username in descending order.
;
SELECT
	assigned_jury_username,
	stadium_name
FROM
	MatchSession
WHERE
	rating = (
		SELECT	MAX(rating)
		FROM MatchSession )
ORDER BY
	assigned_jury_username DESC;

-- ✅ Query 5
-- Use the AVG() aggregate operator on the rating column to calculate the average rating.
;
SELECT
	AVG(rating) AS average_rating
FROM
	MatchSession;

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

-- ✅ Query 7
-- Insert into Table "Position". Specify values after "VALUES" keyword in the order of columns in the table. Namely positon_ID, position_name
;
INSERT INTO `Position` VALUES (5, 'Middle Hitter');

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

-- ✅ Query 10
-- Join Coach table with the Team table by matching coach usernames. Return the name, surname, channel name, contract start and contract finish of the coaches whose contract is valid between 2024-09-02 and 2025-12-31 and who are broadcasting on the 'Digiturk' channel.
-- Use STR_TO_DATE function to convert the contract start and contract finish dates to DATE type.
-- Use date function to convert the given date string to DATE type.
-- Use equality, less than or equal to, and greater than or equal to operators in the WHERE clause.
;
SELECT
	C.name,
	C.surname,
	T.channel_name,
	T.contract_start,
	T.contract_finish
FROM
	Team T
	LEFT JOIN Coach C ON C.username = T.coach_username
WHERE
	STR_TO_DATE(T.contract_start, '%d.%m.%Y') <= date('2024-09-02')
	AND STR_TO_DATE(T.contract_finish, '%d.%m.%Y') >= date('2025-12-31')
	AND T.channel_name = 'Digiturk';

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

-- ✅ Query 13
-- Join the MatchSession table with the Team and Coach tables by matching the team_ID and coach_username columns.
-- Return the stadium_name, name, surname, and the number of sessions directed by each coach in each stadium.
-- Filter the results to include only the coaches who directed the most sessions in each stadium.
-- Sort the result by stadium_name in ascending order, and then by the number of directed sessions in descending order.
-- Uses a subquery to determine the maximum number of directed sessions for each stadium before filtering the results to include only the coaches with that maximum count.
;
SELECT
	MS.stadium_name,
	C.name,
	C.surname,
	COUNT(*) AS directed_count
FROM
	MatchSession MS
	JOIN Team T ON T.team_ID = MS.team_ID
	JOIN Coach C ON C.username = T.coach_username
GROUP BY
	MS.stadium_name,
	C.name,
	C.surname
HAVING
	COUNT(*) = (
		SELECT
			MAX(directed_count)
		FROM (
			SELECT
				COUNT(*) AS directed_count
			FROM
				MatchSession MS2
				JOIN Team T2 ON T2.team_ID = MS2.team_ID
				JOIN Coach C2 ON C2.username = T2.coach_username
			WHERE
				MS2.stadium_name = MS.stadium_name
			GROUP BY
				C2.username) AS Subquery)
	ORDER BY
		MS.stadium_name,
		directed_count DESC;

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

-- ✅ Query 15
-- Group match sessions by juries and then count rated sessions for each jury in a subquery. Order within the subquery by the number of rated sessions in descending order and limit the result to 1 to get the maximum number of rated sessions by a jury.
-- Then, join the jury table with the match session table and group by the assigned jury username. Filter the results to include only the juries who have rated the maximum number of sessions.
;
SELECT
	J.name,
	J.surname,
	COUNT(*) AS rated_sessions
FROM
	MatchSession MS
	JOIN Jury J ON J.username = MS.assigned_jury_username
GROUP BY
	MS.assigned_jury_username
HAVING
	rated_sessions = (
		SELECT
			COUNT(*) AS rated_sessions
		FROM
			MatchSession MS
			JOIN Jury J ON J.username = MS.assigned_jury_username
		GROUP BY
			MS.assigned_jury_username
		ORDER BY
			rated_sessions DESC
		LIMIT 1);

-- ✅ Query 16
-- Join MatchSession to Team by team_ID and Team to Coach by coach_username. Then group the results by coach username and calculate the average rating of the sessions for each coach with AVG() aggregate function on the rating. Sort the results by average rating in descending order.
SELECT C.name, C.surname, AVG(MS.rating) as average_rating FROM
MatchSession MS
JOIN Team T ON T.team_ID = MS.team_ID
JOIN Coach C ON C.username = T.coach_username
GROUP BY C.username
ORDER BY average_rating DESC;

-- ✅ Query 17
-- The final schema consists of "table1 left outer join table2", allowing the inclusion of NULLs for teams that do not meet specified conditions. Table1 contains exactly one team name for each entry.
-- Table2 features a subquery that creates a temporary view named 'temp', which displays the maximum contract duration for coaches across each team. Additionally, this setup facilitates the processing of coach usernames with match ratings through the join of MatchSession, Team, and Coach tables.
-- The WHERE clause incorporates two conditions connected by a logical AND operator: it excludes coaches whose contract durations are less than the maximum for their respective teams, and it also excludes coaches who have any ratings lower than 4.7.
;
SELECT
	table1.team_name,
	table2.name,
	table2.surname,
	table2.duration AS contract_duration
FROM ( SELECT DISTINCT
		T.team_name
	FROM
		Team T) AS table1
	LEFT OUTER JOIN (
	SELECT
		T.team_name,
		coach.name,
		coach.surname,
		temp.duration
	FROM
		Team T
		LEFT JOIN matchsession ON T.team_ID = matchsession.team_ID
		INNER JOIN coach ON T.coach_username = coach.username,
		(
			SELECT
				MAX(DATEDIFF(STR_TO_DATE(T.contract_finish, '%d.%m.%Y'), STR_TO_DATE(T.contract_start, '%d.%m.%Y'))) AS duration,
				T.team_name
			FROM
				Team T
			GROUP BY
				T.team_name) AS temp
		WHERE
			temp.team_name = T.team_name
			AND temp.duration = DATEDIFF(STR_TO_DATE(T.contract_finish, '%d.%m.%Y'), STR_TO_DATE(T.contract_start, '%d.%m.%Y'))
			AND T.coach_username NOT IN(
				SELECT
					team.coach_username FROM matchsession M
				LEFT JOIN team ON team.team_ID = M.team_ID
			WHERE
				rating < 4.7)) AS table2 ON table1.team_name = table2.team_name;


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

