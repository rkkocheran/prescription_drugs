/* 3a. Which drug (generic_name) had the highest total drug cost? 
       A: "PIRFENIDONE" with $2,829,174.30 */

SELECT generic_name,
       total_drug_cost
FROM prescription
LEFT JOIN drug
USING (drug_name)
ORDER BY total_drug_cost DESC
LIMIT 1;


/* 3b. Which drug (generic_name) has the hightest total cost per day?
       A: "IMMUN GLOB G(IGG)/GLY/IGA OV50" with $7141.11 per day. */

SELECT drug_name,
       generic_name,
       ROUND ((total_drug_cost / total_day_supply), 2) AS cost_per_day
FROM prescription
LEFT JOIN drug
USING (drug_name)
ORDER BY cost_per_day DESC
LIMIT 1;