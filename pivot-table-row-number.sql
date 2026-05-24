-- Challenge: Occupations
-- Goal: Pivot the Occupation column to display names alphabetically under their respective titles.
-- Database: MySQL 8.0

SELECT 
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END),
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END),
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END),
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END)
FROM (
    SELECT Name, Occupation, 
           ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) as row_num
    FROM OCCUPATIONS
) AS subquery
GROUP BY row_num;

/* ENGINEERING NOTE: 
   Since native PIVOT syntax varies or is absent in some SQL dialects, using ROW_NUMBER() 
   combined with conditional aggregation (MAX + CASE WHEN) is the standard, cross-platform 
   method for data reshaping. This approach scales efficiently in distributed systems.
*/
