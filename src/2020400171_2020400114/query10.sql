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