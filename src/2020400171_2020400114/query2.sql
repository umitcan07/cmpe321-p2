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