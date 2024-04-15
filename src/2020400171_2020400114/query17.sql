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
