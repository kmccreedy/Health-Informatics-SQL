use StudentExperimentalDatabase;
--- Assignment 6
--- Katie McCreedy
-- 2/24/23

-- Step 1
CREATE TABLE McCreedyPatients (
    PatientID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    DateOfBirth DATE,
    PhoneNumber TEXT
);

CREATE TABLE McCreedyNurses (
    NurseID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    StateLicensedIn TEXT,
    LicenseNumber TEXT,
    PhoneNumber TEXT
);

CREATE TABLE McCreedyVisits (
    VisitID INTEGER PRIMARY KEY,
    NursingNotes TEXT,
    NurseID INTEGER,
    PatientID INTEGER,
    VisitStarted DATETIME,
    VisitEnded DATETIME,
    FOREIGN KEY(NurseID) REFERENCES McCreedyNurses(NurseID),
    FOREIGN KEY(PatientID) REFERENCES McCreedyPatients(PatientID)
);

-- Step 2
INSERT INTO McCreedyPatients (PatientID, FirstName, LastName, DateOfBirth, PhoneNumber)
VALUES (20, 'John', 'Doe', '1990-01-01', '123-456-7890');

INSERT INTO McCreedyPatients (PatientID, FirstName, LastName, DateOfBirth, PhoneNumber)
VALUES (22, 'Jane', 'Smith', '1980-05-15', '555-555-5555');

INSERT INTO McCreedyPatients (PatientID, FirstName, LastName, DateOfBirth, PhoneNumber)
VALUES (24, 'Bob', 'Johnson', '1975-10-20', '987-654-3210');

INSERT INTO McCreedyNurses (NurseID, FirstName, LastName, StateLicensedIn, LicenseNumber, PhoneNumber)
VALUES (9, 'Sarah', 'Jones', 'IL', '123456', '555-123-4567');

INSERT INTO McCreedyNurses (NurseID, FirstName, LastName, StateLicensedIn, LicenseNumber, PhoneNumber)
VALUES (10, 'Mike', 'Smith', 'WI', '789012', '555-987-6543');

INSERT INTO McCreedyNurses (NurseID, FirstName, LastName, StateLicensedIn, LicenseNumber, PhoneNumber)
VALUES (11, 'Mary', 'Brown', 'IL', '345678', '555-555-5555');

INSERT INTO McCreedyVisits (VisitID, NursingNotes, NurseID, PatientID, VisitStarted, VisitEnded)
VALUES (32, 'Pt reports hx of coughs', 9, 20, '2023', '2023')

INSERT INTO McCreedyVisits (VisitID, NursingNotes, NurseID, PatientID, VisitStarted, VisitEnded)
VALUES (33, 'Pt reports visiting ER', 10, 22, '2023', '2023')

INSERT INTO McCreedyVisits (VisitID, NursingNotes, NurseID, PatientID, VisitStarted, VisitEnded)
VALUES (34, 'Pt reports stress', 11, 24, '2023', '2023')


-- Step 3
SELECT v.VisitID, v.NursingNotes, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, 
n.FirstName AS NurseFirstName, n.LastName AS NurseLastName, v.VisitStarted, v.VisitEnded
FROM McCreedyVisits v
INNER JOIN McCreedyPatients p ON v.PatientID = p.PatientID
INNER JOIN McCreedyNurses n ON v.NurseID = n.NurseID;