/* 9a. Find the top five drugs (generic_name) prescribed by prescribers with the specialty of Family Practice. */

WITH tab AS (
      SELECT drug_name,
             SUM (total_claim_count) AS total_claims
      FROM prescriber
      INNER JOIN prescription
      USING (npi)
      WHERE specialty_description = 'Family Practice'
      GROUP BY drug_name
      ORDER BY total_claims DESC
      LIMIT 5
)

SELECT generic_name, 
       total_claims
FROM tab
INNER JOIN drug
USING (drug_name)
ORDER BY total_claims DESC;

/* 9b. Find the top five drugs (generic_name) prescribed by prescribers with the specialty of Cardiology. */

WITH tab AS (
      SELECT drug_name,
             SUM (total_claim_count) AS total_claims
      FROM prescriber
      INNER JOIN prescription
      USING (npi)
      WHERE specialty_description = 'Cardiology'
      GROUP BY drug_name
      ORDER BY total_claims DESC
      LIMIT 5
)

SELECT generic_name, 
       total_claims
FROM tab
INNER JOIN drug
USING (drug_name)
ORDER BY total_claims DESC;

/* 9c. Which drugs are in the top five prescribed by Family Practice prescribers and Cardiologists? 
       Combine what you did for parts a and b into a single query to answer this question. */

