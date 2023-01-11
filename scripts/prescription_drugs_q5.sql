/* 5a. How many CBSAs are in Tennessee? Note: the CBSA table contains information for all states, 
       not just Tennessee.
       A: 10. */

-- Solution 1:
SELECT DISTINCT cbsa
FROM cbsa
WHERE 'TN' LIKE ANY(STRING_TO_ARRAY (TRIM (RIGHT (cbsaname, -(POSITION (',' IN cbsaname)))), '-'))
ORDER BY cbsa;

-- Solution 2:
SELECT DISTINCT cbsa
FROM cbsa
INNER JOIN fips_county
USING (fipscounty)
WHERE state = 'TN'
ORDER BY cbsa;


/* 5b. Which CBSA has the largest combined population? Which has the smallest? 
       Report the CBSA name and total population.
       A: "Nashville-Davidson--Murfreesboro--Franklin, TN" with 1,830,410 total population. */

SELECT DISTINCT cbsaname,
       SUM (population) OVER (PARTITION BY cbsa) AS total_pop
FROM population
INNER JOIN cbsa
USING (fipscounty)
ORDER BY total_pop DESC;


/* 5c. What is the largest (in terms of population) county which is not included in a CBSA? 
       Report the county name and population.
       A: "SEVIER" county with a population of 95,523. */

SELECT *
FROM fips_county
LEFT JOIN population
USING (fipscounty)
WHERE fipscounty NOT IN (
            SELECT DISTINCT fipscounty
            FROM cbsa
      )
  AND population IS NOT NULL
ORDER BY population DESC
LIMIT 1;