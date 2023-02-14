## Analysis of TN Medicare Part D Prescriber and Prescription Data
This is a repository for a project completed during my Data Analytics apprenticeship at [Nashville Software School](https://nashvillesoftwareschool.com/). In this project, I explored medical provider, prescription, medication and county-level data using Power BI and SQL to calculate various prescription statistics. The technology and skills employed to achieve this goal include: PowerBI, SQL, PostgreSQL, pgAdmin, and ERDs.

### PostgreSQL queries are used to find answers to the following questions:
1. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, and the total number of claims.

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

6. Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name, the total_claim_count and npi. For each instance found, add a column that indicates whether the drug is an opioid, and a column that gives the prescriber's first and last name.

7. Generate a full list of all pain management specialists in Nashville and the number of claims they had for each opioid. Report the number of claims per drug per prescriber. Include all combinations, whether or not the prescriber had any claims. Report the npi, the drug name, and the number of claims. Fill in any missing values for total_claim_count with 0.

8. How many npi numbers appear in the prescriber table but not in the prescription table?

9.
    a. Find the top five drugs (generic_name) prescribed by prescribers with the specialty of Family Practice.

    b. Find the top five drugs (generic_name) prescribed by prescribers with the specialty of Cardiology.

    c. Which drugs are in the top five prescribed by Family Practice prescribers and Cardiologists?

10. Generate a list of the top prescribers in each of the major metropolitan areas of Tennessee.
    a. Find the top 5 prescribers in Nashville in terms of the total number of claims (total_claim_count) across all drugs. Report the npi, the total number of claims, and include a column showing the city.
    b. Report the same for Memphis.
    c. Combine your results from a and b, along with the results for Knoxville and Chattanooga.

11. Find all counties which had an above-average number of overdose deaths. Report the county name and number of overdose deaths.

12.
    a. Write a query that finds the total population of Tennessee.
    b. Build off of the query that you wrote in part a to write a query that returns for each county that county's name, its population, and the percentage of the total population of Tennessee that is contained in that county.

13. Return the total number of claims for Interventional Pain Management and Pain Management.

14. Include the total number of claims between the previous two groups. Combine two queries with the UNION keyword to accomplish this.

