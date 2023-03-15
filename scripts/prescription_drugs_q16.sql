SELECT specialty_description,
       opioid_drug_flag,
       SUM(total_claim_count) AS total_claims
FROM prescription
LEFT JOIN prescriber
USING(npi)
LEFT JOIN drug
USING(drug_name)
WHERE specialty_description IN ('Interventional Pain Management',
                                'Pain Management')
GROUP BY GROUPING SETS (specialty_description, 
                        opioid_drug_flag, 
                        ())
ORDER BY specialty_description DESC,
         opioid_drug_flag DESC;