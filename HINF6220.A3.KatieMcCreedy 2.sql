use PhysicianPractice;
/*
* Assignment 4 - Katie McCreedy
*/
-- QUESTION 1 --
SELECT DISTINCT
pp.PhysicianPracticeKey, pp.PracticeName, p.PatientKey, p.FirstName, p.LastName,
pc.PCondition,
lt.Description, lt.OrderDate, lt.Value
FROM Phys.PhysicianPractice pp
JOIN  Phys.PhysicianAssignedToPractice pap
ON pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
JOIN Phys.Physician md 
ON pap.PhysicianKey = md.PhysicianKey
JOIN Phys.Patient p
ON p.PCPPhysicianKey = MD.PhysicianKey
JOIN Phys.PatientCondition pc
ON pc.PatientKey = p.PatientKey
JOIN  Phys.OfficeVisit ov ON ov.PatientKey = p.PatientKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey = p.PatientKey
JOIN Phys.PatientCondition ON pc.PatientKey = p.PatientKey
WHERE p.LastName = 'Carlson' AND pc.PCondition = 'Diabetes' 
AND lt.Description LIKE 'Hemo%' AND lt.value <  9.0 AND lt.value >  5.0
ORDER BY PracticeName


-- Results -- 
-- There are 2 practices with patients with Diabetes, hBA1c > 5, < 9, with the last name Carlson. 
-- 101	Marino Center	8239	Mallory	Carlson	Diabetes	Hemoglobin A1c	2004-03-03	6.0419177103596535
-- 101	Marino Center	8239	Mallory	Carlson	Diabetes	Hemoglobin A1c	2005-03-03	6.04191771035965
-- 101	Marino Center	8239	Mallory	Carlson	Diabetes	Hemoglobin A1c	2010-03-03	6.0419177103596535
-- 101	Marino Center	10024	Diane	Carlson	Diabetes	Hemoglobin A1c	2003-12-26	5.433026562456822
-- 101	Marino Center	10024	Diane	Carlson	Diabetes	Hemoglobin A1c	2009-12-26	5.433026562456822
-- 103	Welby Associates	10024	Diane	Carlson	Diabetes	Hemoglobin A1c	2003-12-26	5.433026562456822
-- 103	Welby Associates	10024	Diane	Carlson	Diabetes	Hemoglobin A1c	2009-12-26	5.433026562456822

-- Question 2
SELECT DISTINCT
pp.PhysicianPracticeKey, pp.PracticeName, p.PatientKey, p.FirstName, p.LastName,
pc.PCondition,
lt.Description, lt.OrderDate, lt.Value, ov.PatientKey, ov.DateofVisit
FROM Phys.PhysicianPractice pp
JOIN  Phys.PhysicianAssignedToPractice pap
ON pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
JOIN Phys.Physician md 
ON pap.PhysicianKey = md.PhysicianKey
JOIN Phys.Patient p
ON p.PCPPhysicianKey = MD.PhysicianKey
JOIN Phys.PatientCondition pc
ON pc.PatientKey = p.PatientKey
JOIN  Phys.OfficeVisit ov ON ov.PatientKey = p.PatientKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey = p.PatientKey
JOIN Phys.PatientCondition ON pc.PatientKey = p.PatientKey
WHERE p.LastName = 'Carlson' AND pc.PCondition = 'Diabetes' 
AND lt.Description LIKE 'Hemo%' AND lt.value <  9.0 AND lt.value >  5.0
ORDER BY PracticeName

-- RESULTS
-- There are 60 office visits in the results.

-- QUESTION 3 --
-- Step 1, get every patient who has been diagnosed with diabetes.
SELECT DISTINCT p.LastName,p.FirstName,pc1.PCondition,pc2.PCondition, lt.Description, 
lt.OrderDate, lt.Value, ov.PatientKey, ov.DateofVisit 
FROM Phys.Patient p
JOIN Phys.PatientCondition pc1 on p.PatientKey = pc1.PatientKey
JOIN Phys.PatientCondition pc2 on p.PatientKey = pc2.PatientKey
JOIN  Phys.OfficeVisit ov ON ov.PatientKey = p.PatientKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey = p.PatientKey
WHERE pc1.PCondition = 'Diabetes' AND p.LastName = 'Carlson' 
AND lt.Description LIKE 'Hemo%' AND lt.value <  9.0 AND lt.value >  5.0
ORDER BY p.LastName,p.FirstName 

-- There are 96 lab results for Mallory Carlson and Diane Carlson collectively, the 2 patients who meet the criterion.

-- Question 4
SELECT DISTINCT
pp.PhysicianPracticeKey, pp.PracticeName,
md.Title, md.FirstName AS PhysicianFirstName,md.LastName AS PhysicianLastName,
p.FirstName AS PatientFirstName, p.LastName AS PatientLastName,
p.BirthDate,
md.BirthDate
FROM Phys.PhysicianPractice pp
JOIN  Phys.PhysicianAssignedToPractice pap
ON pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
JOIN Phys.Physician md 
ON pap.PhysicianKey = md.PhysicianKey
JOIN Phys.Patient p
ON p.PCPPhysicianKey = MD.PhysicianKey
WHERE p.BirthDate > md.BirthDate
ORDER BY p.BirthDate

-- There are 10,966 patients who are older than their PCPs. 
