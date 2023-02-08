SELECT specialty_description,
       SUM(total_claim_count) AS total_claims
FROM prescription
INNER JOIN prescriber
USING(npi)
WHERE specialty_description in ('Interventional Pain Management', 'Pain Management')
GROUP BY specialty_description;