## Analysis of TN Medicare Part D Prescriber and Prescription Data

### PostgreSQL queries are used to find answers to the following questions:
1. a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, and the total number of claims.

2. a. Which specialty had the most total number of claims (totaled over all drugs)?

   b. Which specialty had the most total number of claims for opioids?

   c. Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?

   d. For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?

3. a. Which drug (generic_name) had the highest total drug cost?

   b. Which drug (generic_name) has the hightest total cost per day?

4. a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.

   b. Determine whether more was spent (total_drug_cost) on opioids or on antibiotics.

5. a. How many CBSAs are in Tennessee? Note: the CBSA table contains information for all states, not just Tennessee.

   b. Which CBSA has the largest combined population? Which has the smallest? Report the CBSA name and total population.

   c. What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population.

6. 
   a. Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name and the total_claim_count.

   b. For each instance that you found in part a, add a column that indicates whether the drug is an opioid.

   c. Add another column to you answer from the previous part which gives the prescriber first and last name associated with each row.

7. Generate a full list of all pain management specialists in Nashville and the number of claims they had for each opioid. Note: the results from all 3 parts should have 637 rows.

   a. Create a list of all npi/drug_name combinations for pain management specialists in the city of Nashville, where the drug is an opioid. This will only require the prescriber and drug tables.

   b. Report the number of claims per drug per prescriber. Include all combinations, whether or not the prescriber had any claims. Report the npi, the drug name, and the number of claims.
    
   c. Fill in any missing values for total_claim_count with 0.