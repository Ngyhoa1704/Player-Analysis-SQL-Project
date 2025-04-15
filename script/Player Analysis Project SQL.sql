-- PART I: SCHOOL ANALYSIS
USE maven_advanced_sql;
-- 1. View the schools and school details tables
SELECT * FROM schools;
SELECT * FROM school_details;

-- 2. In each decade, how many schools were there that produced players?
SELECT 
	FLOOR(yearID / 10) * 10 AS decade, 
    COUNT(DISTINCT schoolID) AS num_schools
FROM 
	schools
GROUP BY decade
ORDER BY decade;

-- 3. What are the names of the top 5 schools that produced the most players?
SELECT 
    sd.name_full,
    COUNT(DISTINCT playerID) AS num_players
FROM 
	school_details sd
    JOIN
    schools s ON sd.schoolID = s.schoolID
GROUP BY sd.schoolID
ORDER BY num_players DESC
LIMIT 5;
-- 4. For each decade, what were the names of the top 3 schools that produced the most players?
WITH decade_group AS (
SELECT
	FLOOR(yearID / 10) * 10 AS decade,
    s.schoolID,
    name_full,
    COUNT(DISTINCT s.playerID) AS num_players
FROM
	schools s JOIN school_details sd ON s.schoolID =  sd.schoolID
GROUP BY decade, schoolID
),
rn AS (
SELECT
	decade,
    name_full,
    num_players,
    ROW_NUMBER() OVER(PARTITION BY decade ORDER BY num_players DESC) AS ranking
FROM
	decade_group
)
SELECT
	decade,
    name_full,
    num_players
FROM
	rn
WHERE ranking <= 3
ORDER BY decade DESC, ranking;


-- PART II: SALARY ANALYSIS
-- 1. View the salaries table
SELECT * FROM salaries;
-- 2. Return the top 20% of teams in terms of average annual spending
WITH total AS (
SELECT
	yearID,
    teamID,
    SUM(salary) AS total_salary
FROM salaries
GROUP BY teamID, yearID
ORDER BY  teamID, yearID
),
avg AS (
SELECT
	teamID,
    AVG(total_salary) AS avg_spend,
    NTILE(5) OVER(ORDER BY AVG(total_salary) DESC) AS pct
FROM
	total
GROUP BY teamID
)
SELECT 
	teamID,
    ROUND(avg_spend / 1000000,1) AS avg_spend_millions
FROM
	avg
WHERE pct = 1;
-- 3. For each team, show the cumulative sum of spending over the years
SELECT
	teamID,
    yearID,
    ROUND(SUM(SUM(salary)) OVER(PARTITION BY teamID ORDER BY yearID) / 1000000,1) AS cumulative_million_spend
FROM
	salaries
GROUP BY teamID, yearID
ORDER BY teamID, yearID;
-- 4. Return the first year that each team's cumulative spending surpassed 1 billion
WITH temp1 AS (
SELECT
	teamID,
    yearID,
    ROUND(SUM(SUM(salary)) OVER(PARTITION BY teamID ORDER BY yearID) / 1000000,1) AS cumulative_million_spend
FROM
	salaries
GROUP BY teamID, yearID
ORDER BY teamID, yearID
),
rn AS (
SELECT
	teamID,
    yearID,
    cumulative_million_spend,
    ROW_NUMBER() OVER(PARTITION BY teamID ORDER BY cumulative_million_spend) AS row_num
FROM 
	temp1
WHERE cumulative_million_spend > 1000
)
SELECT 
	teamID,
    yearID,
    ROUND(cumulative_million_spend / 1000,2) AS cumulative_billion_spend
FROM rn
WHERE row_num = 1;


-- PART III: PLAYER CAREER ANALYSIS
-- 1. View the players table and find the number of players in the table
SELECT * FROM players;
SELECT COUNT(*) FROM players;
/* 2. For each player, calculate their age at their first game, their last game, and their career length (all in years). 
Sort from longest career to shortest career. */
SELECT 
	nameGiven,
    TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), debut) AS starting_age,
    TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), finalGame) AS ending_age,
    TIMESTAMPDIFF(YEAR, debut, finalGame) AS career_length
FROM
	players
ORDER BY career_length DESC;
-- 3. What team did each player play on for their starting and ending years?
SELECT * FROM salaries;
SELECT * FROM players;
 
SELECT
	nameGiven,
    s.yearID AS starting_year,
    s.teamID AS starting_team,
    e.yearID AS ending_year,
    e.teamID AS ending_team
FROM
	players p
    JOIN
    salaries s ON p.playerID = s.playerID AND YEAR(p.debut) = s.yearID
    JOIN
    salaries e ON p.playerID = e.playerID AND YEAR(p.finalGame) = e.yearID
ORDER BY starting_team, starting_year
;

-- 4. How many players started and ended on the same team and also played for over a decade?
SELECT
	nameGiven,
    s.yearID AS starting_year,
    s.teamID AS starting_team,
    e.yearID AS ending_year,
    e.teamID AS ending_team
FROM
	players p
    JOIN
    salaries s ON p.playerID = s.playerID AND YEAR(p.debut) = s.yearID
    JOIN
    salaries e ON p.playerID = e.playerID AND YEAR(p.finalGame) = e.yearID
WHERE s.teamID = e.teamID AND YEAR(p.finalGame) - YEAR(p.debut) > 10
ORDER BY starting_team, starting_year;

-- PART IV: PLAYER COMPARISON ANALYSIS
-- 1. View the players table
SELECT * FROM players;

-- 2. Which players have the same birthday?
WITH birthday AS (
SELECT
	nameGiven,
    CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate
FROM
	players
)
SELECT
	birthdate,
    GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players -- using GROUP_CONCAT to group the players by their birthdate  
FROM
	birthday
WHERE YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate;
-- 3. Create a summary table that shows for each team, what percent of players bat right, left and both
USE maven_advanced_sql;
SELECT * FROM salaries;
SELECT * FROM players;
WITH player_stats AS (
SELECT DISTINCT
	teamID,
    p.playerID,
    bats
FROM
	salaries s
    LEFT JOIN
    players p ON s.playerID = p.playerID
)
SELECT
	teamID,
    ROUND(SUM(CASE
			WHEN bats = "R" THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS bat_right,
	ROUND(SUM(CASE
			WHEN bats = "L" THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS bat_left,
	ROUND(SUM(CASE
			WHEN bats = "B" THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS bat_both
FROM
	player_stats
GROUP BY teamID
ORDER BY teamID
;
-- 4. How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?
SELECT * FROM players;
WITH decade_stats AS ( 
SELECT 
	FLOOR(YEAR(debut) / 10) * 10 AS decade,
    AVG(height) AS avg_height,
    AVG(weight) AS avg_weight
FROM
	players
WHERE FLOOR(YEAR(debut) / 10) * 10 IS NOT NULL
GROUP BY decade
ORDER BY decade
)
SELECT
	ds.decade,
    avg_height - LAG(avg_height) OVER(ORDER BY decade) AS height_diff,
    avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff
FROM
	decade_stats ds;