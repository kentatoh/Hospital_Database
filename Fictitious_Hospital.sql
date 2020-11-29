/* Creating tables */

CREATE TABLE Ward (
    WardNo NUMBER(3) NOT NULL,
    WardName VARCHAR2(30),
    Location VARCHAR2(30),
    NoOfBed NUMBER(3),
    ExtNo NUMBER(15),
    PRIMARY KEY (WardNo)
);

CREATE TABLE Staff (
    StaffNo VARCHAR2(10) NOT NULL,
    FirstName VARCHAR2(30),
    LastName VARCHAR2(30),
    Address VARCHAR2(100),
    Gender VARCHAR2(1),
    DateOfBirth DATE,
    TelNo NUMBER(15),
    Position VARCHAR2(30),
    Salary NUMBER(9,2),
    HoursWorked NUMBER(5,1),
    SalaryScale VARCHAR2(2),
    PermOrTemp VARCHAR2(1),
    SalaryMethod VARCHAR2(1),
    PRIMARY KEY (StaffNo),
    CHECK (Gender in ('M', 'F')),
    CHECK (PermOrTemp in ('P', 'T')),
    CHECK (SalaryMethod in ('M', 'W'))
);
 
CREATE TABLE StaffListing (
    WardNo NUMBER(3) NOT NULL,
    StaffNo VARCHAR2(10) NOT NULL,
    WeekBeginning DATE,
    Shift VARCHAR2(10),
    PRIMARY KEY (WardNo, StaffNo),
    FOREIGN KEY (WardNo) REFERENCES Ward (WardNo),
    FOREIGN KEY (StaffNo) REFERENCES Staff (StaffNo)
);

CREATE TABLE Work (
    WorkNo VARCHAR2(10) NOT NULL,
    Organisation VARCHAR2(30) NOT NULL,
    Position VARCHAR2(30) NOT NULL,
    StartDate DATE NOT NULL,
    FinishDate DATE NOT NULL,
    StaffNo VARCHAR2(10) NOT NULL,
    PRIMARY KEY (WorkNo),
    FOREIGN KEY (StaffNo) REFERENCES Staff (StaffNo)
);

CREATE TABLE Qualification (
    QualificationNo VARCHAR2(10) NOT NULL,
    Type VARCHAR2(50) NOT NULL,
    DateAwarded DATE NOT NULL,
    Institution VARCHAR2(50) NOT NULL,
    StaffNo VARCHAR2(10) NOT NULL,
    PRIMARY KEY (QualificationNo),
    FOREIGN KEY (StaffNo) REFERENCES Staff (StaffNo)
);

CREATE TABLE Appointment (
    ApptNo VARCHAR2(10) NOT NULL,
    StaffNo VARCHAR2(8) NOT NULL,
    ApptDate DATE,
    ApptTime VARCHAR2(5),
    Room VARCHAR2(5),
    Reconmendation VARCHAR2(50),
    PRIMARY KEY (ApptNo),
    FOREIGN KEY (StaffNo) REFERENCES Staff (StaffNo)
);

CREATE TABLE Doctor (
    ProviderNo VARCHAR2(10) NOT NULL,
    FullName VARCHAR2(100),
    Address	VARCHAR2(100),
    TelNo NUMBER(15),
    PRIMARY KEY (ProviderNo)
);

CREATE TABLE Patient (
    PatientNo VARCHAR2(10) NOT NULL,
    FirstName VARCHAR2(30),
    LastName VARCHAR2(30),
    Address VARCHAR2(100),
    TelNo NUMBER(15),
    DateOfBirth DATE,
    Gender VARCHAR2(1),
    MaritalStatus VARCHAR2(30),
    DateRegistered DATE NOT NULL,
    ProviderNo VARCHAR2(10) NOT NULL,
    ApptNo VARCHAR2(10),
    PRIMARY KEY (PatientNo),
    FOREIGN KEY (ProviderNo) REFERENCES Doctor (ProviderNo),
    FOREIGN KEY (ApptNo) REFERENCES Appointment (ApptNo),
    CHECK (Gender in ('M', 'F'))
);

CREATE TABLE NextOfKin (
    NokNo VARCHAR2(10) NOT NULL,
    FullName VARCHAR2(100),
    Relationship VARCHAR2(30),
    Address VARCHAR2(100),
    TelNo NUMBER(15) NOT NULL,
    PatientNo VARCHAR2(10) NOT NULL,
    PRIMARY KEY (NokNo),
    FOREIGN KEY (PatientNo) REFERENCES Patient (PatientNo)
);

CREATE TABLE Bed (
    BedNo NUMBER(3) NOT NULL,
    WardNo NUMBER(3) NOT NULL,
    PatientNo VARCHAR2(10) NOT NULL,
    DateWarded DATE,
    DateDischarged DATE,
    PRIMARY KEY (BedNo, WardNo, PatientNo),
    FOREIGN KEY (WardNo) REFERENCES Ward (WardNo),
    FOREIGN KEY (PatientNo) REFERENCES Patient (PatientNo)
);


/* Populating tables */

INSERT ALL
INTO Ward VALUES ('11', 'Orthopaedic', 'Block E', '10', '7711')
INTO Ward VALUES ('12', 'Orthodontics', 'Block C', '7', '7712')
INTO Ward VALUES ('13', 'Face Clinic', 'Block A', '12', '7713')
INTO Ward VALUES ('14', 'Leg Clinic', 'Block E', '15', '7714')
INTO Ward VALUES ('15', 'Eye Clinic', 'Block C', '5', '7715')
SELECT * FROM dual;

INSERT ALL
INTO Staff VALUES ('S0980', 'Carol', 'Cummings', '331 Ocean Drive, White Coast, WA, 6011', 'F', '04/05/1985', '01450023341', 'Staff Nurse', '56000', '36', '1A', 'P', 'W')
INTO Staff VALUES ('S1257', 'Morgan', 'Russell', '112 Woods Ave, Wellington, WA, 6856', 'M', '05/08/1997', '01345038945', 'Nurse', '45000', '30', '1A', 'T', 'M')
INTO Staff VALUES ('S1458', 'Robin', 'Plevin', '61 Nathan Road, Downtown, WA, 1001', 'M', '08/09/1994', '01214632771', 'Staff Nurse', '63000', '38.5', '1A', 'P', 'M')
INTO Staff VALUES ('S2356', 'Amy', 'O''Donnell', '51 Brooks Walk, Murrayville, WA, 6855', 'F', '01/02/1991', '01820939827', 'Consultant', '109300', '28', '1C', 'P', 'M')
INTO Staff VALUES ('S3649', 'Laurence', 'Burns', '24 Sun Cresent, White Coast, WA, 6011', 'F', '07/12/1998', '02098837663', 'Nurse', '44000', '30', '1A', 'T', 'W')
SELECT * FROM dual;

INSERT ALL
INTO Work VALUES ('W1010', 'Queen''s Hospital', 'Charge Nurse', '23/06/2010', '01/05/2011', 'S0980')
INTO Work VALUES ('W1011', 'King''s Hospital', 'Nurse', '23/06/2012', '01/05/2013', 'S1257')
INTO Work VALUES ('W1012', 'Eastern Hospital', 'Nurse', '20/07/2011', '01/05/2013', 'S1458')
INTO Work VALUES ('W1013', 'North Shore Hospital', 'Charge Nurse', '15/07/2011', '01/05/2013', 'S2356')
INTO Work VALUES ('W1014', 'North Shore Hospital', 'Nurse', '15/08/2012', '07/06/2013', 'S3649')
SELECT * FROM dual;

INSERT ALL
INTO Qualification VALUES ('Q1010', 'BSc in Nursing','01/04/2010', 'Curtain University','S0980')
INTO Qualification VALUES ('Q1011', 'Post Graduate Diploma in Geriatrics','15/05/2012', 'Curtain University','S1257')
INTO Qualification VALUES ('Q1012', 'BSc in Nursing','01/07/2011', 'Enid Blyton University','S1458')
INTO Qualification VALUES ('Q1013', 'Post Graduate Diploma in Geriatrics','01/07/2012', 'Curtain University','S3649')
SELECT * FROM dual;

INSERT ALL
INTO Appointment VALUES ('A1010', 'S0980', '08/08/2020', '12.00', '11', 'NIL')
INTO Appointment VALUES ('A1011', 'S2356', '08/05/2020', '15.00', '20', 'NIL')
INTO Appointment VALUES ('A1012', 'S2356', '08/04/2020', '08.30', '24', 'NIL')
INTO Appointment VALUES ('A1013', 'S3649', '08/12/2020', '09.15', '25', 'NIL')
SELECT * FROM dual;


INSERT ALL
INTO Doctor VALUES ('1456584B', 'Dr Charles Lee', '56 Nathan Road, Downtown, WA, 1001', '01331246531')
INTO Doctor VALUES ('1233234A', 'Dr Rainer Lam', '11 cean Drive, White Coast, WA, 6011', '03293920392')
INTO Doctor VALUES ('1715232H', 'Dr Ana Lim', '23 Brooks Walk, Murrayville, WA, 6855', '03289832987')
SELECT * FROM dual;


INSERT ALL
INTO Patient VALUES ('P12312', 'Tom', 'Tan', '554 Ocean Drive, White Coast, WA, 6011', '014455646464', '07/07/1990', 'M', 'Single', '02/04/2020', '1456584B', 'A1010')
INTO Patient VALUES ('P03932', 'Alfred', 'Koh', '13 Brooks Walk, Murrayville, WA, 6855', '01986749372', '01/06/1996', 'M', 'Single', '12/04/2018', '1233234A', 'A1011')
INTO Patient VALUES ('P12223', 'Aaron', 'Chua', '78 Woods Ave, Wellington, WA, 6856', '01989938474', '21/06/1995', 'M', 'Married', '16/03/2020', '1715232H', 'A1012')
INTO Patient VALUES ('P12783', 'James', 'Wong', '90 Sun Cresent, White Coast, WA, 6011', '01314439019', '12/09/1998', 'M', 'Single', '23/03/2020', '1456584B', 'A1013')
SELECT * FROM dual;


INSERT ALL
INTO NextOfKin VALUES ('N1010', 'Eric Tan', 'Father' ,'554 Ocean Drive, White Coast, WA, 6011', '03134738376', 'P12312')
INTO NextOfKin VALUES ('N1011', 'Edward Koh', 'Father' ,'13 Brooks Walk, Murrayville, WA, 6855', '03938377262', 'P03932')
INTO NextOfKin VALUES ('N1012', 'Nancy Chua', 'Mother' ,'78 Woods Ave, Wellington, WA, 6856', '01992883763', 'P12223')
INTO NextOfKin VALUES ('N1013', 'Kelly Ang', 'Spouse' ,'90 Sun Cresent, White Coast, WA, 6011', '03992093883', 'P12783')
SELECT * FROM dual;
 
 
/* 5a */

INSERT ALL
INTO Staff VALUES ('S4576', 'Moira' , 'Samuels' , '49 School Road, Bedford, WA, 6052', 'F', '03/05/1990', '01504563357', 'Charge Nurse', '68760', '37.5', '1C', 'P', 'M')
INTO Qualification VALUES ('Q1000', 'BSc in Nursing','12/07/2010', 'Curtain University','S4576')
INTO Qualification VALUES ('Q1001', 'Post Graduate Diploma in Geriatrics', '22/07/2012', 'Enid Blyton University', 'S4576')
INTO Work VALUES ('W1000', 'Eastern Hospital', 'Charge Nurse', '23/01/2011', '01/05/2011', 'S4576')
INTO Work VALUES ('W1001', 'Eastern Hospital', 'Charge Nurse', '01/06/2011', '23/02/2012', 'S4576')
SELECT * FROM dual;


/* 5b */

INSERT ALL
INTO Doctor VALUES ('1455784L', 'Dr Helen Pearson', '47 Kennedy Street, Murrayville, WA, 6855', '01313326282')
INTO Patient VALUES ('P10234', 'Anne', 'Phelps', '67 Wellmeaning Way, Wellington, WA, 6856', '01313324158', '10/12/1955', 'F', 'M', '09/01/2013', '1455784L', '')
INTO NextOfKin VALUES ('N1000', 'James Phelps', 'Spouse', '67 Wellmeaning Way, Wellington, WA, 6856', '01313324158', 'P10234')
SELECT * FROM dual;


/* 5c */

INSERT ALL
INTO StaffListing VALUES ('11', 'S0980', '09/01/2013', 'Late')
INTO StaffListing VALUES ('11', 'S1257', '09/01/2013', 'Late')
INTO StaffListing VALUES ('11', 'S1458', '09/01/2013', 'Early')
INTO StaffListing VALUES ('11', 'S2356', '09/01/2013', 'Night')
INTO StaffListing VALUES ('11', 'S3649', '09/01/2013', 'Early')
SELECT * FROM dual;


/* 6a */
CREATE VIEW ViewA AS
SELECT StaffListing.WardNo, Staff.StaffNo, Staff.FirstName, Staff.LastName
FROM Staff, StaffListing
WHERE Staff.StaffNo = StaffListing.StaffNo
ORDER BY WardNo;


/* 6b */

CREATE VIEW ViewB AS
SELECT DateRegistered, PatientNo, FirstName, LastName
FROM Patient
WHERE EXTRACT(MONTH FROM DateRegistered) = EXTRACT(MONTH FROM CURRENT_TIMESTAMP)
AND EXTRACT(YEAR FROM DateRegistered) = EXTRACT(YEAR FROM CURRENT_TIMESTAMP);


/* 6c */
INSERT ALL
INTO Bed VALUES ('12', '11', 'P12223', '16/03/2020', '27/03/2020')
INTO Bed VALUES ('10', '11', 'P12783', '23/03/2020', '24/03/2020')
INTO Bed VALUES ('10', '11', 'P03932', '12/04/2018', '14/04/2018') /* Shouldn't appear in ViewC */
SELECT * FROM dual;

CREATE VIEW ViewC AS
SELECT Patient.PatientNo, Patient.FirstName, Patient.LastName, Bed.DateWarded, Bed.DateDischarged, Bed.BedNo
FROM Patient, Bed
WHERE Patient.PatientNo = Bed.PatientNo
AND Patient.DateRegistered >= add_months(sysdate, -6);


/* 6d */
CREATE VIEW ViewD AS
SELECT Doctor.ProviderNo, Doctor.FullName, Doctor.Address, Doctor.TelNo, count(Patient.PatientNo) AS NumOfPatientReferred
FROM Doctor, Patient, Bed
WHERE Doctor.ProviderNo = Patient.ProviderNo
AND Patient.PatientNo = Bed.PatientNo
AND Bed.DateWarded >= add_months(sysdate, -6)
GROUP BY Doctor.ProviderNo, Doctor.FullName, Doctor.Address, Doctor.TelNo;


/* 7a */






/* 7b */

CREATE TABLE StaffHistory(
    HistoryId NUMBER GENERATED ALWAYS AS IDENTITY,
    StaffNo VARCHAR2(10) NOT NULL,
    FirstNameOld VARCHAR2(30),
    LastNameOld VARCHAR2(30),
    AddressOld VARCHAR2(100),
    GenderOld VARCHAR2(1),
    DateOfBirthOld DATE,
    TelNoOld NUMBER(15),
    PositionOld VARCHAR2(30),
    SalaryOld NUMBER(9,2),
    HoursWorkedOld NUMBER(5,1),
    SalaryScaleOld VARCHAR2(2),
    PermOrTempOld VARCHAR2(1),
    SalaryMethodOld VARCHAR2(1),
    ModUserName VARCHAR2(20),
    ModDate DATE,
    PRIMARY KEY (StaffNo),
    CHECK (GenderOld in ('M', 'F')),
    CHECK (PermOrTempOld in ('P', 'T')),
    CHECK (SalaryMethodOld in ('M', 'W'))
);

CREATE or REPLACE TRIGGER StaffHistoryTrigger
    AFTER UPDATE
        ON Staff
    FOR EACH ROW

DECLARE
    ModUserName VARCHAR2(20);

BEGIN

    SELECT user INTO ModUserName
    FROM dual;
    
    INSERT INTO StaffHistory (
        StaffNo,
        FirstNameOld,
        LastNameOld,
        AddressOld,
        GenderOld,
        DateOfBirthOld,
        TelNoOld,
        PositionOld,
        SalaryOld,
        HoursWorkedOld,
        SalaryScaleOld,
        PermOrTempOld,
        SalaryMethodOld,
        ModUserName,
        ModDate)
        VALUES (
        :New.StaffNo,
        :New.FirstName,
        :New.LastName,
        :New.Address,
        :New.Gender,
        :New.DateOfBirth,
        :New.TelNo,
        :New.Position,
        :New.Salary,
        :New.HoursWorked,
        :New.SalaryScale,
        :New.PermOrTemp,
        :New.SalaryMethod,
        ModUserName,
        sysdate);
END;

/* Testing */
SELECT * FROM StaffHistory;
UPDATE Staff SET Salary = '45000' WHERE StaffNo  = 'S3649';
SELECT * FROM StaffHistory;


/* Granting Tables */
GRANT ALL ON StaffHistory TO S20190819TL;
GRANT ALL ON StaffHistory TO MARKERTL;
GRANT ALL ON Bed TO S20190819TL;
GRANT ALL ON Bed TO MARKERTL;
GRANT ALL ON NextOfKin TO S20190819TL;
GRANT ALL ON NextOfKin TO MARKERTL;
GRANT ALL ON Patient TO S20190819TL;
GRANT ALL ON Patient TO MARKERTL;
GRANT ALL ON Doctor TO S20190819TL;
GRANT ALL ON Doctor TO MARKERTL;
GRANT ALL ON Appointment TO S20190819TL;
GRANT ALL ON Appointment TO MARKERTL;
GRANT ALL ON Qualification TO S20190819TL;
GRANT ALL ON Qualification TO MARKERTL;
GRANT ALL ON Work TO S20190819TL;
GRANT ALL ON Work TO MARKERTL;
GRANT ALL ON StaffListing TO S20190819TL;
GRANT ALL ON StaffListing TO MARKERTL;
GRANT ALL ON Staff TO S20190819TL;
GRANT ALL ON Staff TO MARKERTL;
GRANT ALL ON Ward TO S20190819TL;
GRANT ALL ON Ward TO MARKERTL;

/* View tables */
SELECT * FROM StaffHistory;
SELECT * FROM Bed;
SELECT * FROM NextOfKin;
SELECT * FROM Patient;
SELECT * FROM Doctor;
SELECT * FROM Appointment;
SELECT * FROM Qualification;
SELECT * FROM Work;
SELECT * FROM StaffListing;
SELECT * FROM Staff;
SELECT * FROM Ward;

/* DROPPING TABLES */
DROP TABLE StaffHistory;
DROP TABLE Bed;
DROP TABLE NextOfKin;
DROP TABLE Patient;
DROP TABLE Doctor;
DROP TABLE Appointment;
DROP TABLE Qualification;
DROP TABLE Work;
DROP TABLE StaffListing;
DROP TABLE Staff;
DROP TABLE Ward;

/* View views */
SELECT * FROM ViewA;
SELECT * FROM ViewB;
SELECT * FROM ViewC;
SELECT * FROM ViewD;

/* DROPPING VIEWS */
DROP VIEW ViewA;
DROP VIEW ViewB;
DROP VIEW ViewC;
DROP VIEW ViewD;
