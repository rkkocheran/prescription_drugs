/* 8. How many npi numbers appear in the prescriber table but not in the prescription table? 
      A: 4458. */

SELECT COUNT(npi)
FROM prescriber
WHERE npi NOT IN (
      SELECT DISTINCT npi 
      FROM prescription
)