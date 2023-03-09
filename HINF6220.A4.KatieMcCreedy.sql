use PhysicianPractice;
--- Assignment 4
--- Katie McCreedy
-- 2/12/23
 
-- Question 1
SELECT 
Phys.Patient.FirstName,
Phys.Patient.LastName,
Phys.Patient.BirthDate,
DATEDIFF(day, BirthDate ,GETDATE())/365.25 as age 
FROM Phys.Patient
-- This returns 18,383 rows of patients with their calculated ages and names.

--- Question 2
Select 
ph.FirstName,
ph.LastName
AS LastName, concat(ph.LastName,', ', ph.FirstName)
FROM Phys.Physician ph

-- This returns 101 rows of physician names.


--- Aggregates - Question 1
SELECT * from Phys.LaboratoryTests lt 
WHERE lt.Description = 'Hemoglobin A1c'
ORDER BY lt.value

-- The maximum HbA1c for the entire dataset = 12.0743, the minimum HbA1c = 3.10133. The average is 6.96 across 5,407 tests. 

-- Aggregates - Question 2
SELECT 
Phys.Patient.PatientKey, Phys.Patient.FirstName, Phys.Patient.LastName,
ROUND(MIN(Phys.LaboratoryTests.value),2) AS MinimumA1c,
ROUND(MAX(Phys.LaboratoryTests.value),2) AS MaximumA1c
FROM Phys.Patient
JOIN Phys.LaboratoryTests ON Phys.Patient.PatientKey = Phys.LaboratoryTests.PatientKey
WHERE Phys.LaboratoryTests.Description LIKE 'Hem%'
GROUP BY 
Phys.Patient.PatientKey, Phys.Patient.FirstName, Phys.Patient.LastName;

-- This gives 2,650 rows of patients' min and max HbA1c. 

-- Aggregates - Question 3
SELECT 
Phys.PatientCondition.PCondition,
ROUND(AVG(Phys.LaboratoryTests.value),2) AS AvgA1c
FROM Phys.Patient
JOIN Phys.LaboratoryTests ON Phys.Patient.PatientKey = Phys.LaboratoryTests.PatientKey
JOIN Phys.PatientCondition ON Phys.Patient.PatientKey = Phys.PatientCondition.PatientKey
WHERE Phys.LaboratoryTests.Description LIKE 'Hem%'
GROUP BY 
Phys.PatientCondition.PCondition;

-- 6 rows returned. High Cholesterol = 6.6, Coronary = 6.84, Chronic Bronchitis = 6.6, Asthma = 6.84, Hypertension = 6.9, Diabetes = 6.97. 

-- Aggregates - Question 4
SELECT 
Phys.Patient.PatientKey AS Patient_Key,
Phys.Patient.LastName AS Last_Name,
Phys.Patient.FirstName AS First_Name,
ROUND(MIN(Phys.LaboratoryTests.value),2) AS Min_A1c,
ROUND(MAX(Phys.LaboratoryTests.value),2) AS Max_A1c,
ROUND(AVG(Phys.LaboratoryTests.value),2) AS Avg_A1c,
COUNT(Phys.LaboratoryTests.value) AS A1c_TestsCount
FROM Phys.Patient
JOIN Phys.LaboratoryTests ON Phys.Patient.PatientKey = Phys.LaboratoryTests.PatientKey
WHERE Phys.LaboratoryTests.Description LIKE 'Hem%'
GROUP BY 
Phys.Patient.PatientKey, Phys.Patient.FirstName, Phys.Patient.LastName
HAVING COUNT(Phys.LaboratoryTests.value) >= 2
ORDER BY Last_Name, First_Name;

-- This returns 2,568 rows. 


