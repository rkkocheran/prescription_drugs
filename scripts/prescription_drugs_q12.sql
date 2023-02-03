/* 12a. Write a query that finds the total population of Tennessee. */

SELECT SUM(population) AS total_pop
FROM population
INNER JOIN fips_county
USING (fipscounty);

/* 12b. Build off of the query that you wrote in part a to write a query that returns
        for each county that county's name, its population, and the percentage of the 
        total population of Tennessee that is contained in that county. */

SELECT county,
       population,
       ROUND((100.0 * population / SUM(population) OVER() ), 2) AS perc_total_pop
FROM population
INNER JOIN fips_county
USING (fipscounty)