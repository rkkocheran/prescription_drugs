CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab (
     'SELECT city,
             opioid_label,
             SUM(total_claim_count)::INTEGER AS total_claims
      FROM (SELECT nppes_provider_city AS city,
                   generic_name,
                   CASE WHEN generic_name ILIKE ''%codeine%'' THEN ''codeine''
                        WHEN generic_name ILIKE ''%fentanyl%'' THEN ''fentanyl''
                        WHEN generic_name ILIKE ''%hydrocodone%'' THEN ''hydrocodone''
                        WHEN generic_name ILIKE ''%morphine%'' THEN ''morphine''
                        WHEN generic_name ILIKE ''%oxycodone%'' THEN ''oxycodone''
                        WHEN generic_name ILIKE ''%oxymorphone%'' THEN ''oxymorphone''
                        ELSE NULL
                        END AS opioid_label,
                   total_claim_count
            FROM prescription
            LEFT JOIN prescriber
            USING(npi)
            LEFT JOIN drug
            USING(drug_name)
            WHERE nppes_provider_city IN (''CHATTANOOGA'', 
                                          ''KNOXVILLE'', 
                                          ''MEMPHIS'',
                                          ''NASHVILLE'')) AS opioid_claims
            WHERE opioid_label IS NOT NULL
            GROUP BY city, opioid_label
            ORDER BY city, opioid_label'
) AS ct(city TEXT, 
        codeine INTEGER, 
        fentanyl INTEGER, 
        hydrocodone INTEGER, 
        morphine INTEGER,  
        oxycodone INTEGER,  
        oxymorphone INTEGER);
