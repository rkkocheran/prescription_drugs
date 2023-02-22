/* 14. Include the total number of claims between the previous two groups. 
       Combine two queries with the UNION keyword to accomplish this. */

WITH pm_claims AS (
      SELECT specialty_description,
             SUM(total_claim_count) AS total_claims
      FROM prescription
      LEFT JOIN prescriber
      USING(npi)
      WHERE specialty_description IN ('Interventional Pain Management', 
                                      'Pain Management')
      GROUP BY specialty_description
)

SELECT NULL AS specialty_description,
       SUM(total_claims) AS total_claims
FROM pm_claims
UNION
SELECT *
FROM pm_claims