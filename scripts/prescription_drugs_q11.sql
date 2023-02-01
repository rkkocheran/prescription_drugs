/* 11. Find all counties which had an above-average number of overdose deaths. 
       Report the county name and number of overdose deaths. */

SELECT county,
       ROUND(deaths) AS overdose_deaths
FROM overdoses
INNER JOIN fips_county
USING (fipscounty)
WHERE deaths > (SELECT AVG (deaths)
                FROM overdoses)
ORDER BY deaths DESC;
               