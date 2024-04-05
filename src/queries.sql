USE VolleyDB;

-- CREATE TABLE Player 
-- (
--     username	VARCHAR(512),
--     password	VARCHAR(512),
--     name	VARCHAR(512),
--     surname	VARCHAR(512),
--     date_of_birth	VARCHAR(512), -- 27/02/1996
--     height	INT,
--     weight	INT,
--     PRIMARY KEY (username)
-- );

-- CREATE TABLE PlayerPositions 
-- (
--     player_positions_id	INT,
--     username	VARCHAR(512),
--     position	INT,
--     PRIMARY KEY (player_positions_id)
-- );

-- CREATE TABLE PlayerTeams 
-- (
--     player_teams_id	INT,
--     username	VARCHAR(512),
--     team	INT,
--     PRIMARY KEY (player_teams_id)
-- );

-- CREATE TABLE Team 
-- (
--     team_ID	INT,
--     team_name	VARCHAR(512),
--     coach_username	VARCHAR(512),
--     contract_start	VARCHAR(512),
--     contract_finish	VARCHAR(512),
--     channel_ID	INT,
--     channel_name	VARCHAR(512),
--     PRIMARY KEY (team_ID)
-- );

-- CREATE TABLE Coach 
-- (
--     username	VARCHAR(512),
--     password	VARCHAR(512),
--     name	VARCHAR(512),
--     surname	VARCHAR(512),
--     nationality	VARCHAR(512),
--     PRIMARY KEY (username)
-- );

-- CREATE TABLE Position 
-- (
--     position_ID	INT,
--     position_name	VARCHAR(512),
--     PRIMARY KEY (position_ID)
-- );

-- CREATE TABLE Jury 
-- (
--     username	VARCHAR(512),
--     password	VARCHAR(512),
--     name	VARCHAR(512),
--     surname	VARCHAR(512),
--     nationality	VARCHAR(512),
--     PRIMARY KEY (username)
-- );

-- CREATE TABLE MatchSession 
-- (
--     session_ID	INT,
--     team_ID	INT,
--     stadium_ID	INT,
--     stadium_name	VARCHAR(512),
--     stadium_country	VARCHAR(512),
--     time_slot	INT,
--     date	VARCHAR(512),
--     assigned_jury_username	VARCHAR(512),
--     rating	DOUBLE,
--     PRIMARY KEY (session_ID)
-- );

-- CREATE TABLE SessionSquads 
-- (
--     squad_ID	INT,
--     session_ID	INT,
--     played_player_username	VARCHAR(512),
--     position_ID	INT,
--     PRIMARY KEY (squad_ID)
-- );

-- INSERT INTO SessionSquads (squad_ID, session_ID, played_player_username, position_ID) VALUES ('48', '7', 'a_aykac', '0');
-- INSERT INTO MatchSession (session_ID, team_ID, stadium_ID, stadium_name, stadium_country, time_slot, date, assigned_jury_username, rating) VALUES ('0', '0', '0', 'Burhan Felek Voleybol Salonu', 'TR', '1', '10.03.2024', 'o_ozcelik', '4.5');
-- INSERT INTO Jury (username, password, name, surname, nationality) VALUES ('o_ozcelik', 'ozlem.0347', 'Özlem', 'Özçelik', 'TR');
-- INSERT INTO Position (position_ID, position_name) VALUES ('0', 'Libero');
-- INSERT INTO Coach (username, password, name, surname, nationality) VALUES ('d_santarelli', 'santa.really1', 'Daniele ', 'Santarelli', 'ITA');
-- INSERT INTO Team (team_ID, team_name, coach_username, contract_start, contract_finish, channel_ID, channel_name) VALUES ('6', 'U19', 'a_derune', '10.08.2005', '10.08.2010', '2', 'TRT');
-- INSERT INTO PlayerTeams (player_teams_id, username, team) VALUES ('1', 'g_orge', '0');
-- INSERT INTO PlayerPositions (player_positions_id, username, position) VALUES ('1', 'g_orge', '0');
-- INSERT INTO Player (username, password, name, surname, date_of_birth, height, weight) VALUES ('g_orge', 'Go.1993', 'Gizem ', 'Örge', '26/04/1993', '170', '59');


-- Query 1
-- Find the number of players and display this as player count. The required column names are respectively: player count.;
SELECT
	COUNT(*) AS player_count
FROM
	Player;

-- Query 2
-- List the match sessions which are played before 2024 (exclusive). Display date in DD/MM/YYYY format. The required column names are respectively: session_ID, assigned_jury_username, rating, date. Sort the results by date in ascending order.;
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


-- Query 3
-- List all the fields of the match sessions with the minimum rating. Display Date in DD.MM.YYYY format. The required column names are respectively: session_ID, team_ID, stadium_ID, stadium name, stadium country, time slot, date, assigned jury username, rating.;
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

-- Query 4
-- List assigned jury username and stadium name of the match sessions with the maximum rating. The required column names are respectively: assigned jury username, stadium name. Sort the results by assigned jury username in descending order.;
SELECT
	assigned_jury_username,
	stadium_name
FROM
	MatchSession
WHERE
	rating = (
		SELECT
			MAX(rating)
		FROM
			MatchSession)
	ORDER BY
		assigned_jury_username DESC;

-- Query 5
-- Find the average rating of all match sessions. The required column names are respectively: average rating.;
SELECT
	AVG(rating) AS average_rating
FROM
	MatchSession;


-- Query 6
-- List all teams together with the number of players in each Team. Notice that in the Team table, each team id is unique. However, different ids may have the same team names as different agreements with coaches in the past were needed to be recorded. Note that there may be empty teams. The required column names are respectively: team name, coach name, coach surname, player count.;
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

-- Query 7
-- Insert a new position, whose position ID is “5” and position name is “Middle Hitter”. No required column names. No required output.;
INSERT INTO `position` (position_ID, position_name)  VALUES (5, 'Middle Hitter');

-- Query 8
-- Find the names and surnames of coaches who have directed more than or equal to 2 match sessions. The required column names are respectively: name, sur- name. Sort by surname in descending order.;
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

-- Query 9
-- Find the names and surnames of players who were born in the same year as “Ebrar Karakurt” and who are taller than her. The required column names are respectively: name, surname. Sort by surname in ascending order.;
SELECT
	`name`,
	surname
FROM
	Player
WHERE
	YEAR(STR_TO_DATE(date_of_birth, '%d/%m/%Y')) = (
		SELECT
			YEAR(STR_TO_DATE(date_of_birth, '%d/%m/%Y')) AS date_of_birth
		FROM
			Player
		WHERE
			`name` = 'Ebrar '
			AND surname = 'Karakurt')
	AND (`name` != 'Ebrar ' OR `surname` != 'Karakurt');

-- Query 10
-- List all the coaches’ names who directed a single team non-stop between 02.09.2024- 31.12.2025 (inclusive) and that team has agreement with “Digiturk”. The required column names are respectively: name, surname, channel name, contract start, contract finish. Sort by name in ascending order.;
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

-- Query 11
-- List all match sessions that were not directed by Daniele Santarelli and were not played in UK. The required column names are respectively: session ID, name, surname, stadium name, stadium country, team name. Sort by session id in ascending order.;
SELECT M.session_ID, C.`name`, C.surname, M.stadium_name, T.team_name
FROM MatchSession M
LEFT JOIN Team T ON M.team_ID = T.team_ID 
LEFT JOIN Coach C ON C.username = T.coach_username
WHERE
	C.username = 'd_santarelli' AND M.stadium_country != 'UK'
ORDER BY
	M.session_ID;

-- Query 12
-- For each year, find and list the coach who has directed the team with the highest average rating in that year. The required column names are respectively: name, surname, year, average rating. Sort by year in ascending order.;

-- Query 13
-- For each stadium, find the coach who has directed the highest number of matches in that stadium. Please note that there can be multiple maximums. You can check the provided result table. The required column names are re- spectively: stadium name, name, surname, directed count.;

-- Query 14
-- List all the matches that were played after 2023 (meaning starting from 01.01.2024 inclusive), and have not been directed by “Ferhat Akba ̧s”. The required column names are respectively: session ID, name, surname. Sort by session id in ascending order.;

-- Query 15
-- Find the jury who has rated the highest number of match sessions in the database. The required column names are respectively: name, surname, rated sessions.;

-- Query 16
-- Find the average rating of match sessions for each coach, and list the coaches in descending order of their average ratings. The required column names are respectively: name, surname, average rating. Sort by name in descending order.;

-- Query 17
-- For each team name, find the coach who has signed a contract that has the longest period with that team, and has never directed a match with a rating lower than 4.7 (4.7 is not acceptable) with ANY team. Please note that if there are no coaches who meet these conditions, show the coach name, surname, and day count as NULL or None. The required column names are respectively: team name, name, surname, day count.;

-- Query 18
-- Find the names of coaches who have directed at least one match in each stadium. The required column names are respectively: name, surname, played count.;

-- Query 19
-- Return the players who have played in stadium name “GD Voleybol Arena” as position name “Libero”. The required column names are respectively: name, surname.;

-- Query 20
-- List all player ID’s with the column more than one which is either TRUE if that player plays more than one position or FALSE otherwise. The required column names are respectively: name, surname, more than one. Sort in ascending order by name.;
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
