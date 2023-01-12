/* 7. Generate a full list of all pain management specialists in Nashville and the number of claims 
      they had for each opioid. Report the number of claims per drug per prescriber. Include all combinations, 
      whether or not the prescriber had any claims. Report the npi, the drug name, and the number of claims. 
      Fill in any missing values for total_claim_count with 0. */
         
SELECT npi,
       drug_name,
       COALESCE(total_claim_count, 0) AS total_claim_count
FROM drug
NATURAL JOIN prescriber
LEFT JOIN prescription
USING (npi, drug_name)
WHERE opioid_drug_flag = 'Y'
  AND specialty_description = 'Pain Management'
  AND nppes_provider_city = 'NASHVILLE'   
ORDER BY npi, drug_name;