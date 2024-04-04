-- Find the number of players and display this as player count. The required column names are respectively: player count.


-- List the match sessions which are played before 2024 (exclusive). Display date in DD/MM/YYYY format. The required column names are respectively: session_ID, assigned_jury_username, rating, date. Sort the results by date in ascending order.


-- List all the fields of the match sessions with the minimum rating. Display Date in DD.MM.YYYY format. The required column names are respectively: session_ID, team_ID, stadium_ID, stadium name, stadium country, time slot, date, assigned jury username, rating.


-- List assigned jury username and stadium name of the match sessions with the maximum rating. The required column names are respectively: assigned jury username, stadium name. Sort the results by assigned jury username in descending order.
-- Find the average rating of all match sessions. The required column names are respectively: average rating.
-- List all teams together with the number of players in each Team. Notice that in the Team table, each team id is unique. However, different ids may have the same team names as different agreements with coaches in the past were needed to be recorded. Note that there may be empty teams. The required column names are respectively: team name, coach name, coach surname, player count.
-- Insert a new position, whose position ID is “5” and position name is “Middle Hitter”. No required column names. No required output.
-- Find the names and surnames of coaches who have directed more than or equal to 2 match sessions. The required column names are respectively: name, sur- name. Sort by surname in descending order.
-- Find the names and surnames of players who were born in the same year as “Ebrar Karakurt” and who are taller than her. The required column names are respectively: name, surname. Sort by surname in ascending order.
-- Listallthecoaches’nameswhodirectedasingleteamnon-stopbetween02.09.2024- 31.12.2025 (inclusive) and that team has agreement with “Digiturk”. The re- quired column names are respectively: name, surname, channel name, contract start, contract finish. Sort by name in ascending order.
-- List all match sessions that were not directed by Daniele Santarelli and were not played in UK. The required column names are respectively: session ID, name, surname, stadium name, stadium country, team name. Sort by session id in ascending order.
-- For each year, find and list the coach who has directed the team with the highest average rating in that year. The required column names are respectively: name, surname, year, average rating. Sort by year in ascending order.
-- For each stadium, find the coach who has directed the highest number of matches in that stadium. Please note that there can be multiple maximums. You can check the provided result table. The required column names are re- spectively: stadium name, name, surname, directed count.
-- List all the matches that were played after 2023 (meaning starting from 01.01.2024 inclusive), and have not been directed by “Ferhat Akba ̧s”. The required column names are respectively: session ID, name, surname. Sort by session id in ascending order.
-- Find the jury who has rated the highest number of match sessions in the database. The required column names are respectively: name, surname, rated sessions.
-- Find the average rating of match sessions for each coach, and list the coaches in descending order of their average ratings. The required column names are respectively: name, surname, average rating. Sort by name in descending order.
-- For each team name, find the coach who has signed a contract that has the longest period with that team, and has never directed a match with a rating lower than 4.7 (4.7 is not acceptable) with ANY team. Please note that if there are no coaches who meet these conditions, show the coach name, surname, and day count as NULL or None. The required column names are respectively: team name, name, surname, day count.
-- Find the names of coaches who have directed at least one match in each stadium. The required column names are respectively: name, surname, played count.
-- Return the players who have played in stadium name “GD Voleybol Arena” as position name “Libero”. The required column names are respectively: name, surname.
-- List all player ID’s with the column more than one which is either TRUE if that player plays more than one position or FALSE otherwise. The required column names are respectively: name, surname, more than one. Sort in ascending order by name. The output of each query is given in the output query-index.txt files (e.g. output1.txt, output2.txt, ... , output20.txt.

USE VolleyDB;

-- Query 1
SELECT
	COUNT(*) AS player_count
FROM
	Player;

-- Query 2
SELECT
	session_ID,
	assigned_jury_username,
	rating,
	date
FROM
	MatchSession
WHERE STR_TO_DATE(date, '%d.%m.%Y') <= date('2024-01-01')
ORDER BY
	STR_TO_DATE(date, '%d.%m.%Y') ASC;



-- Query 20
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
