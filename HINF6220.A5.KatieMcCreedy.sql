use PhysicianPractice;
--- Assignment 5
--- Katie McCreedy
-- 2/15/23
 
-- Question 1
SELECT DISTINCT Patient.PatientKey
FROM Phys.Patient
JOIN Phys.Billing ON Patient.PatientKey = Billing.PatientKey
WHERE Billing.BillingCharge > 1000 OR Billing.BillingCharge < 10;

-- There are 16,044 distinct patients with a billing charge greater than $1,000.

-- Question 2
SELECT Patient.PatientKey
FROM Phys.Patient
JOIN Phys.Billing ON Patient.PatientKey = Billing.PatientKey
GROUP BY Patient.PatientKey
HAVING SUM(CASE WHEN Billing.BillingCharge > 1000 THEN 1 ELSE 0 END) > 0
AND SUM(CASE WHEN Billing.BillingCharge < 10 THEN 1 ELSE 0 END) > 0;

-- There are 3,659 distinct patients with a billing charge greater than $1,000 and under $10.

-- Question 3
SELECT DISTINCT Patient.PatientKey
FROM Phys.Patient
JOIN Phys.Billing ON Patient.PatientKey = Billing.PatientKey
WHERE Billing.BillingCharge > 1000
AND Patient.PatientKey NOT IN (
SELECT DISTINCT Patient.PatientKey
FROM Phys.Patient
JOIN Phys.Billing ON Patient.PatientKey = Billing.PatientKey
WHERE Billing.BillingCharge < 10
);

-- There are 201 patients with a billing charge greater than $1000 and that do not have a charge under $10.

-- Question 4
SELECT DISTINCT temp.AveragePhysicianA1cValue.PCPPhysicianKey, temp.AveragePhysicianA1cValue.AveragePhysicianA1cValue, Patient.PatientKey
FROM Phys.Patient
JOIN Phys.LaboratoryTests ON Patient.PatientKey = LaboratoryTests.PatientKey
JOIN temp.AveragePhysicianA1cValue ON Patient.PCPPhysicianKey = temp.AveragePhysicianA1cValue.PCPPhysicianKey
WHERE LaboratoryTests.Description LIKE 'Hem%' AND LaboratoryTests.Value > temp.AveragePhysicianA1cValue.AveragePhysicianA1CValue

-- There are 1,330 patients who have at least one A1c result that is higher than the average A1c results for their PCP.

-- Question 5
SELECT Patient.PCPPhysicianKey, AVG(LaboratoryTests.Value) AS AvgA1c
FROM Phys.Patient
JOIN Phys.LaboratoryTests ON Patient.PatientKey = LaboratoryTests.PatientKey
WHERE LaboratoryTests.Description LIKE 'Hem%'
GROUP BY Patient.PCPPhysicianKey
ORDER BY AvgA1c;

-- There are 20 rows listing the average A1c by PCP with the min average A1c = 6.64 for PCP 14 and the max average A1c = 7.37 for PCP 7.

-- Question 6
SELECT DISTINCT subquery.PCPPhysicianKey, subquery.AvgA1c, Patient.PatientKey
FROM Phys.Patient
JOIN Phys.LaboratoryTests ON Patient.PatientKey = LaboratoryTests.PatientKey
JOIN (SELECT Patient.PCPPhysicianKey, AVG(LaboratoryTests.Value) AS AvgA1c
      FROM Phys.Patient
      JOIN Phys.LaboratoryTests ON Patient.PatientKey = LaboratoryTests.PatientKey
      WHERE LaboratoryTests.Description LIKE 'Hem%'
      GROUP BY Patient.PCPPhysicianKey) AS subquery
ON Patient.PCPPhysicianKey = subquery.PCPPhysicianKey
WHERE LaboratoryTests.Description LIKE 'Hem%' AND LaboratoryTests.Value > subquery.AvgA1c;

-- Using Q5 as the subquery, there are 1,330 patients who have at least one A1c result that is higher than the average A1c results for their PCP.
-- This is the same result as for Question #4 indicating that the subquery is accurate. 
