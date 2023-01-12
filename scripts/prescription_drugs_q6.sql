/* 6. Find all rows in the prescription table where total_claims is at least 3000. 
      Report the drug_name, the total_claim_count and npi. For each instance found, 
      add a column that indicates whether the drug is an opioid,
      and a column that gives the prescriber's first and last name. */

WITH top_claim_counts AS (
      SELECT DISTINCT drug_name, 
             SUM(total_claim_count) OVER(PARTITION BY drug_name) AS total_claim_count,
             npi
      FROM prescription
      WHERE total_claim_count >= 3000
)

SELECT CONCAT(nppes_provider_first_name, ' ', nppes_provider_last_org_name) AS provider_name,
       drug_name, 
       total_claim_count,
       opioid_drug_flag
FROM top_claim_counts
INNER JOIN drug
USING (drug_name)
INNER JOIN prescriber
USING (npi);