/* 15. Include the total number of claims between the previous two groups. 
       Use GROUPING SETS to achieve the same output. */

SELECT specialty_description,
       SUM(total_claim_count) AS total_claims
FROM prescription
LEFT JOIN prescriber
USING(npi)
WHERE specialty_description IN ('Interventional Pain Management', 
                                'Pain Management')
GROUP BY GROUPING SETS ((specialty_description), ())