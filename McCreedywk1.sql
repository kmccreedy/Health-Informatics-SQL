--- Assignment 2, Katie McCreedy, 1/29/23
-- Question 1
SELECT LastName,
      FirstName,
      Birthdate
FROM Phys.Physician
WHERE BirthDate='1964'
ORDER BY Birthdate DESC
-- There are no physicians born in 1964 returned in the search.

-- Question 2
SELECT LastName,
      FirstName,
      Birthdate
FROM Phys.Patient
WHERE BirthDate='1964' AND MaritalStatus='single'
-- This query searches for patients born in 1964 who are also single, it returns 2. 

-- Question 3
SELECT*
FROM Phys.PatientCondition
WHERE PCondition='diabetes'
ORDER BY FirstDiagnosed DESC
-- There are 4,190 patients with the condition of diabetes.

-- Question 4
SELECT*
FROM Phys.PatientCondition
WHERE PCondition='Hypertension'
ORDER BY FirstDiagnosed DESC

-- There are 5,824 patients with hypertenion and 4,190 with diabetes. There are 10,014 patients with hypertension OR diabetes.

-- Question 5
SELECT*
FROM Phys.Patient
WHERE LastName='Brown'

-- There are 82 patients with the last name Brown. 

-- Question 5
SELECT FirstName, LastName, Count(*) AS CNT
FROM Phys.Patient
GROUP BY FirstName, LastName
HAVING COUNT(*) > 1

-- This query organizes a table with a count of all names of patients that are identical in the database. 
-- There are no people with repeat names with the last name "Brown", but there are for Blue and Barnes.

-- Question 6
SELECT LastName,
      FirstName,
      BirthDate
FROM Phys.Physician
WHERE LastName LIKE '%s%a%' AND (MiddleName = 'Null' OR BirthDate > '1963')

-- There are 15 physicians with a last name that starts with 'sa' 
-- There are 8 physicians whose last name starts with 'sa" and EITHER have a birthdate after jan 1, 1964 or null middle name.

-- Question 7
SELECT LastName,
      FirstName
FROM Phys.Patient

SELECT LastName,
		FirstName,
		MiddleName
FROM Phys.Patient

SELECT LastName,
		FirstName,
		MiddleName,
		BirthDate
FROM Phys.Patient
ORDER BY BirthDate DESC

-- The search with the greatest amount of details gives the greatest likelihood that there are not duplicate patients. 
-- The only true unqiue search would be one using unqiue patient identifying numbers.