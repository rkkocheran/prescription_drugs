/* 1. Which prescriber had the highest total number of claims (totaled over all drugs)? 
      Report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, 
      and the total number of claims. 
      
      A: Bruce Pendley, in Family Practice with 99707 total claims. */

SELECT nppes_provider_first_name, 
       nppes_provider_last_org_name, 
       specialty_description, 
       SUM (total_claim_count) AS total_claims
FROM prescription
LEFT JOIN prescriber
USING (npi)
GROUP BY npi, 
         nppes_provider_first_name, 
         nppes_provider_last_org_name, 
         specialty_description
ORDER BY total_claims DESC
LIMIT 1;