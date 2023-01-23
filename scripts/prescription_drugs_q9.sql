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
       drug_name:	                  total_claims:
       ATORVASTATIN CALCIUM	      429152
       AMLODIPINE BESYLATE	      391236
       LEVOTHYROXINE SODIUM	      389447
       LISINOPRIL	                  387787
       FUROSEMIDE	                  318164
*/

WITH claims_cardio AS (
SELECT specialty_description AS desc_cardio,
       drug_name, 
       SUM (total_claim_count)
            AS total_claims_cardio
FROM prescription
INNER JOIN prescriber 
USING (npi)
WHERE specialty_description IN ('Cardiology')
GROUP BY drug_name, specialty_description
ORDER BY drug_name
),

claims_fam AS (
SELECT specialty_description AS desc_fam,
       drug_name, 
       SUM (total_claim_count)
            AS total_claims_fam
FROM prescription
INNER JOIN prescriber 
USING (npi)
WHERE specialty_description IN ('Family Practice')
GROUP BY drug_name, specialty_description
ORDER BY drug_name
)

SELECT drug_name,
       (total_claims_cardio + total_claims_fam) AS total_claims
FROM claims_cardio
INNER JOIN claims_fam
USING (drug_name)
ORDER BY total_claims DESC
LIMIT 5;