/* 4a. For each drug in the drug table, return the drug name and then a column named 'drug_type' 
       which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those 
       drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs. */

WITH drug_categories AS (
      SELECT drug_name,
             CASE 
                  WHEN opioid_drug_flag = 'Y' THEN 'opioid'
                  WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
                  ELSE 'neither'
             END AS drug_type
      FROM drug
)

/* 4b. Determine whether more was spent (total_drug_cost) on opioids or on antibiotics.
       A: More money was spent on "opioids". */

SELECT drug_type, 
       SUM (total_drug_cost) AS total_cost
FROM prescription
LEFT JOIN drug_categories
USING (drug_name)
WHERE drug_type IN ('opioid', 'antibiotic')
GROUP BY drug_type
ORDER BY total_cost DESC;