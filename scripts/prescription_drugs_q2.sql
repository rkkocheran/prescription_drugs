/* 2a. Which specialty had the most total number of claims (totaled over all drugs)?
       A: "Family Practice with 9,752,347 total claims */
       
SELECT specialty_description, 
       SUM (total_claim_count) AS total_claims
FROM prescription
LEFT JOIN prescriber
USING (npi)
GROUP BY specialty_description
ORDER BY total_claims DESC
LIMIT 1;


/* 2b. Which specialty had the most total number of claims for opioids?
       A: "Nurse Practitioner" with 900,845 total opioid claims. */
       
SELECT specialty_description, 
       SUM (total_claim_count) AS total_opioid_claims
FROM prescription
LEFT JOIN prescriber
USING (npi)
LEFT JOIN drug
USING (drug_name)
WHERE opioid_drug_flag = 'Y'
GROUP BY specialty_description
ORDER BY total_opioid_claims DESC
LIMIT 1;


/* 2c. Are there any specialties that appear in the prescriber table that have no associated 
       prescriptions in the prescription table?
       A: There are 15. */

WITH valid_specialties AS (
      SELECT DISTINCT specialty_description
      FROM prescription
      LEFT JOIN prescriber
      USING (npi)
)

SELECT DISTINCT specialty_description
FROM prescriber
WHERE specialty_description NOT IN (
      SELECT *
      FROM valid_specialties
      )
ORDER BY specialty_description;


/* 2d. For each specialty, report the percentage of total claims by that specialty which are for 
       opioids. Which specialties have a high percentage of opioids? 
       A: The majority of prescriptions are opioids for the following specialties:
          "Case Manager/Care Coordinator", "Orthopaedic Surgery", "Interventional Pain Management"
          "Anesthesiology", "Pain Management", "Hand Surgery", and "Surgical Oncology". */

WITH specialty_claims AS (
      SELECT DISTINCT specialty_description,
             SUM (total_claim_count) 
                  OVER (PARTITION BY specialty_description) 
                  AS total_claims,
             SUM (total_claim_count)
                  FILTER (WHERE opioid_drug_flag = 'Y') 
                  OVER (PARTITION BY specialty_description) 
                  AS total_opioid_claims
      FROM prescription
      LEFT JOIN prescriber
      USING (npi)
      LEFT JOIN drug
      USING (drug_name)
      ORDER BY specialty_description
)

SELECT specialty_description,
       total_claims,
       COALESCE (total_opioid_claims, 0) AS total_opioid_claims,
       COALESCE (ROUND((total_opioid_claims / total_claims * 100), 2), 0) AS percent_opioid
FROM specialty_claims
ORDER BY percent_opioid DESC
LIMIT 10;