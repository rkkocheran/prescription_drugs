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

15. Instead of UNION, use GROUPING SETS to achieve the same output.

16. Additionally, report information about the number of opioid vs. non-opioid claims by these two specialties. Modify the query to produce the following chart:

specialty_description         |opioid_drug_flag|total_claims|
------------------------------|----------------|------------|
                              |                |      129726|
                              |Y               |       76143|
                              |N               |       53583|
Pain Management               |                |       72487|
Interventional Pain Management|                |       57239|

17. Modify the query by replacing the GROUPING SETS with ROLLUP(opioid_drug_flag, specialty_description). How is the result different from the output from the previous query? 
Answer: GROUPING SETS results in the UNION of the query using each individual set, whereas ROLLUP introduces a heirarchy, returning grouping sets of the first set as well as combinations of the first set with all successive sets, including an empty set.

18. Finally, use the CUBE function instead of ROLLUP. How does this impact the output?
Answer: CUBE summarizes the data based all possible permutations of the given sets.

19. Using the crosstab function, create a pivot table showing for each of the 4 largest cities in Tennessee (Nashville, Memphis, Knoxville, and Chattanooga), the total claim count for each of six common types of opioids: Hydrocodone, Oxycodone, Oxymorphone, Morphine, Codeine, and Fentanyl. For the purpose of this question, put a drug into one of the six listed categories if it has the category name as part of its generic name. For example, count both of "ACETAMINOPHEN WITH CODEINE" and "CODEINE SULFATE" as "CODEINE".

The end result of this question should be a table formatted like this:

city       |codeine|fentanyl|hydrocodone|morphine|oxycodone|oxymorphone|
-----------|-------|--------|-----------|--------|---------|-----------|
CHATTANOOGA|   1323|    3689|      68315|   12126|    49519|       1317|
KNOXVILLE  |   2744|    4811|      78529|   20946|    84730|       9186|
MEMPHIS    |   4697|    3666|      68036|    4898|    38295|        189|
NASHVILLE  |   2043|    6119|      88669|   13572|    62859|       1261|

