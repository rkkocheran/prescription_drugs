/* Q1a
   Which prescriber had the highest total number of claims (totaled over all drugs)?
   Report the npi and the total number of claims.
   
   ANSWER: npi = 1881634483 with 99707 total claims 

SELECT npi,
       sum(total_claim_count) AS sum_claim_count
FROM prescription
  INNER JOIN prescriber
  USING (npi)
GROUP BY npi
ORDER BY sum_claim_count DESC
LIMIT 1;
*/


/* Q1b
   Repeat the above, but this time report the nppes_provider_first_name,
   nppes_provider_last_org_name,  specialty_description, and the total number of claims.
   
   ANSWER: provider name = "Bruce Pendley"; specialty = "Family Practice"; total claims = 99707 

SELECT nppes_provider_first_name,
       nppes_provider_last_org_name,
       specialty_description,
       sum(total_claim_count) AS sum_claim_count
FROM prescriber 
INNER JOIN prescription USING (npi)
GROUP BY npi,
         nppes_provider_first_name,
         nppes_provider_last_org_name,
         specialty_description
ORDER BY sum_claim_count DESC
LIMIT 1;
*/


/* Q2a
   Which specialty had the most total number of claims (totaled over all drugs)?
   
   ANSWER: "Family Practice" with 9752347 total claims 

SELECT specialty_description,
       sum(total_claim_count) AS sum_claim_count
FROM prescriber
INNER JOIN prescription USING (npi)
GROUP BY specialty_description
ORDER BY sum_claim_count DESC
LIMIT 1;
*/


/* Q2b
   Which specialty had the most total number of claims for opioids?
   
   ANSWER: "Nurse Practitioner" with 900845 total opioid claims 

SELECT specialty_description,
       sum(total_claim_count) AS total_opioid_claim_count
FROM prescriber
INNER JOIN prescription USING (npi)
INNER JOIN drug AS d USING (drug_name)
WHERE opioid_drug_flag = 'Y'
GROUP BY specialty_description
ORDER BY total_opioid_claim_count DESC
LIMIT 1;
*/


/* Q2c
   **Challenge Question:** Are there any specialties that appear in the prescriber table
   that have no associated prescriptions in the prescription table?
   ANSWER: Yes, there are 15 specialties that have not prescribed anything. Namely,
   "Ambulatory Surgical Center"
   "Chiropractic"
   "Contractor"
   "Developmental Therapist"
   "Hospital"
   "Licensed Practical Nurse"
   "Marriage & Family Therapist"
   "Medical Genetics"
   "Midwife"
   "Occupational Therapist in Private Practice"
   "Physical Therapist in Private Practice"
   "Physical Therapy Assistant"
   "Radiology Practitioner Assistant"
   "Specialist/Technologist, Other"
   "Undefined Physician type"
*/
SELECT DISTINCT specialty_description
FROM prescriber
WHERE specialty_description NOT IN
    (SELECT DISTINCT specialty_description
     FROM prescription 
     LEFT JOIN prescriber USING (npi))
ORDER BY specialty_description;


/* Q2d
   **Difficult Bonus:** For each specialty, report the percentage of total claims by that 
   specialty which are for opioids. Which specialties have a high percentage of opioids?
   
   ANSWER: UNFINISHED

SELECT specialty_description,
       round((sum(CASE
                      WHEN opioid_drug_flag = 'Y' THEN total_claim_count
                  END) / sum(total_claim_count)) * 100, 2) AS percent_opioid_claim
FROM prescriber
INNER JOIN prescription USING (npi)
INNER JOIN drug USING (drug_name)
GROUP BY specialty_description
ORDER BY percent_opioid_claim DESC NULLS LAST
*/


/* Q3a
   Which drug (generic_name) had the highest total drug cost?
   ANSWER: "INSULIN GLARGINE,HUM.REC.ANLOG" with "$104,264,066.35"

SELECT generic_name,
       sum(total_drug_cost)::MONEY AS sum_drug_cost
FROM prescription 
INNER JOIN drug USING (drug_name)
GROUP BY generic_name
ORDER BY sum_drug_cost DESC
LIMIT 1;
*/


/* Q3B
   Which drug (generic_name) has the highest total cost per day? 
   **Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.
   
   ANSWER: "C1 ESTERASE INHIBITOR" with $3,495.22/day 

SELECT generic_name,
       (sum(total_drug_cost) / sum(total_day_supply))::MONEY AS drug_cost_per_day
FROM prescription
INNER JOIN drug USING (drug_name)
GROUP BY generic_name
ORDER BY drug_cost_per_day DESC
LIMIT 1;
*/


/* Q4a
   For each drug in the drug table, return the drug name and then a column named 'drug_type' which 
   says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which 
   have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.
   
   ANSWER: (see below) 

SELECT drug_name,
       CASE
           WHEN opioid_drug_flag = 'Y' THEN 'opioid'
           WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
           ELSE 'neither'
       END AS drug_type
FROM drug;
*/


/* Q4b
   Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) 
   on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.
   
   ANSWER: "opioid" with "$105,080,626.37" total cost. 

WITH drug_category AS (
SELECT drug_name,
       CASE
           WHEN opioid_drug_flag = 'Y' THEN 'opioid'
           WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
           ELSE 'neither'
       END AS drug_type
FROM drug)
   
SELECT drug_type,
       sum(total_drug_cost)::MONEY AS sum_drug_cost
FROM prescription
INNER JOIN drug_category USING (drug_name)
WHERE drug_type IN ('opioid',
                    'antibiotic')
GROUP BY drug_type
ORDER BY sum_drug_cost DESC;
*/


/* Q5a
   How many CBSAs are in Tennessee? **Warning:** The cbsa table contains information 
   for all states, not just Tennessee.
   
   ANSWER: 10

SELECT COUNT(DISTINCT cbsa)
FROM cbsa
INNER JOIN fips_county USING (fipscounty)
WHERE state = 'TN';
*/


/* Q5b
   Which cbsa has the largest combined population? Which has the smallest? 
   Report the CBSA name and total population.
   
   ANSWER:
   Largest: "Nashville-Davidson--Murfreesboro--Franklin, TN" (cbsaname), 1830410 (population)
   Smallest: "Morristown, TN", 116352 

SELECT cbsaname,
       sum(population) AS total_population
FROM cbsa
INNER JOIN population USING (fipscounty)
GROUP BY cbsaname
ORDER BY total_population DESC;
*/


/* Q5c
   What is the largest (in terms of population) county which is not included in a CBSA? 
   Report the county name and population.
   
   ANSWER: "SEVIER" with 95523 total population. 

SELECT county,
       sum(population) AS total_population
FROM fips_county
INNER JOIN population AS USING (fipscounty)
WHERE fipscounty NOT IN
    (SELECT DISTINCT fipscounty
     FROM cbsa)
GROUP BY county
ORDER BY total_population DESC
LIMIT 1;
*/


/* Q6a
   Find all rows in the prescription table where total_claims is at least 3000. 
   Report the drug_name and the total_claim_count.

SELECT drug_name,
       total_claim_count
FROM prescription
WHERE total_claim_count >= 3000;
*/


/* Q6b 
   For each instance that you found in part a, add a column that indicates whether the drug is an opioid. 

SELECT drug_name,
       total_claim_count,
       opioid_drug_flag
FROM prescription 
INNER JOIN drug USING (drug_name)
WHERE total_claim_count >= 3000;
*/


/* Q6c
   Add another column to you answer from the previous part which gives the prescriber first and 
   last name associated with each row. 

SELECT drug_name,
       total_claim_count,
       opioid_drug_flag,
       nppes_provider_first_name,
       nppes_provider_last_org_name
FROM prescription 
INNER JOIN drug USING (drug_name)
INNER JOIN prescriber USING (npi)
WHERE total_claim_count >= 3000
*/


/* Q7 
   Goal: Generate a full list of all pain management specialists in Nashville and 
   the number of claims they had for each opioid.
   
   Q7a
   Create a list of all npi/drug_name combinations for pain management specialists 
   (specialty_description = 'Pain Management') in the city of Nashville (nppes_provider_city = 'NASHVILLE'), 
   where the drug is an opioid (opiod_drug_flag = 'Y'). 
   **Warning:** Double-check your query before running it. You will only need to use the prescriber 
   and drug tables since you don't need the claims numbers yet. 

SELECT npi,
       drug_name
FROM prescriber
CROSS JOIN drug
WHERE nppes_provider_city = 'NASHVILLE'
  AND specialty_description = 'Pain Management'
  AND opioid_drug_flag = 'Y'
*/

/* Q7b
   Next, report the number of claims per drug per prescriber. Be sure to include all combinations, 
   whether or not the prescriber had any claims. You should report the npi, the drug name, and the 
   number of claims (total_claim_count). 
   Hint - Will need to JOIN on TWO key values (npi and drug_name)

SELECT p.npi,
       drug_name,
       total_claim_count
FROM prescriber as p
CROSS JOIN drug
LEFT JOIN prescription USING (npi, drug_name) -- LEFT JOIN to keep ALL prescriber/drug combos whether existing or not
WHERE nppes_provider_city = 'NASHVILLE'
  AND specialty_description = 'Pain Management'
  AND opioid_drug_flag = 'Y'
ORDER BY npi;
*/


/* Q7c
   Finally, if you have not done so already, fill in any missing values for total_claim_count with 0. 
   Hint - Google the COALESCE function.
*/
SELECT p.npi,
       drug_name,
       COALESCE(total_claim_count, 0) AS total_claims -- Replace NULL with 0
FROM prescriber as p
CROSS JOIN drug
LEFT JOIN prescription USING (npi, drug_name)
WHERE nppes_provider_city = 'NASHVILLE'
  AND specialty_description = 'Pain Management'
  AND opioid_drug_flag = 'Y'
ORDER BY npi;
