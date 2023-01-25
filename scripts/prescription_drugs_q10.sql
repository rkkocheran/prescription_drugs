/* 10. Generate a list of the top prescribers in each of the major metropolitan areas of Tennessee.
    a. Find the top 5 prescribers in Nashville in terms of the total number of claims (total_claim_count) 
       across all drugs. Report the npi, the total number of claims, and include a column showing the city.
    b. Report the same for Memphis.
    c. Combine your results from a and b, along with the results for Knoxville and Chattanooga. */

WITH top_nashville AS (
      SELECT DISTINCT npi, 
             SUM (total_claim_count) OVER (PARTITION BY npi, nppes_provider_city) AS total_claims,
             nppes_provider_city
      FROM prescriber
      INNER JOIN prescription
      USING (npi)
      WHERE nppes_provider_city IN ('NASHVILLE')
      ORDER BY total_claims DESC
      LIMIT 5
),

top_memphis AS (
      SELECT DISTINCT npi,
             SUM (total_claim_count) OVER (PARTITION BY npi) AS total_claims, 
             nppes_provider_city
      FROM prescriber
      INNER JOIN prescription
      USING (npi)
      WHERE nppes_provider_city IN ('MEMPHIS')
      ORDER BY total_claims DESC
      LIMIT 5
),

top_knox AS (
      SELECT DISTINCT npi,
             SUM (total_claim_count) OVER (PARTITION BY npi) AS total_claims, 
             nppes_provider_city
      FROM prescriber
      INNER JOIN prescription
      USING (npi)
      WHERE nppes_provider_city IN ('KNOXVILLE')
      ORDER BY total_claims DESC
      LIMIT 5
),

top_chat AS (
      SELECT DISTINCT npi,
             SUM (total_claim_count) OVER (PARTITION BY npi) AS total_claims, 
             nppes_provider_city
      FROM prescriber
      INNER JOIN prescription
      USING (npi)
      WHERE nppes_provider_city IN ('CHATTANOOGA')
      ORDER BY total_claims DESC
      LIMIT 5
)

SELECT * FROM top_nashville
UNION ALL SELECT * FROM top_memphis
UNION ALL SELECT * FROM top_knox
UNION ALL SELECT * FROM top_chat