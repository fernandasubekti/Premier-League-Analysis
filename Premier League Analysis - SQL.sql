# CREATE DATABASE premier_league;

USE premier_league;

SELECT *
FROM champions;

SELECT *
FROM pl_2425;

# PL teams who haven't won PL title
SELECT `2024-25 club`, status, `first season in top division`
FROM pl_2425 AS t
LEFT JOIN champions AS c
	ON t.`2024-25 club` = c.champions
WHERE season IS NULL;

# EFL teams who have won PL title
SELECT t.team, COUNT(*) AS count_title
FROM efl_teams AS t
LEFT JOIN champions AS c
	ON t.team = c.champions
WHERE season IS NOT NULL
GROUP BY t.team
ORDER BY count_title DESC;

# EFL teams who haven't won PL title
SELECT team, location, stadium, capacity
FROM efl_teams AS t
LEFT JOIN champions AS c
	ON t.team = c.champions
WHERE season IS NULL;

# The most PL title who had been won by the managers
SELECT `winning manager`, COUNT(*) AS count_title
FROM champions
GROUP BY `winning manager`
ORDER BY count_title DESC;

# Inspect 'Alex Ferguson'
SELECT *
FROM champions
WHERE `winning manager` = 'Alex Ferguson';

# Are there managers who have won with more than a team has coached?
WITH champ AS (
	SELECT `winning manager`, champions, COUNT(*) AS count_title,
		   ROW_NUMBER() OVER(PARTITION BY `winning manager`) AS team_num
	FROM champions
	GROUP BY `winning manager`, champions
	ORDER BY `winning manager`
)
SELECT `winning manager`, champions, count_title
FROM champ
WHERE `winning manager` IN (
	SELECT DISTINCT `winning manager`
	FROM champ
	WHERE team_num > 1);
-- Note that 'The Wednesday' = 'Sheffield Wednesday'

# Top transfer players involved in PL teams
SELECT *
FROM transfers;