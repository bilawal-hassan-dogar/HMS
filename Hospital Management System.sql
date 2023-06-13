-------------------------------------------------------

--          DATABASE MANAGEMENT SYSTEM PROJECT
--      --------------------------------------------
--       HEALTHCARE INFORMATION / MANAGEMENT SYSTEM


-------------------------------------------------------






-------------------Database-----------------


-- Create the Database Hospital
CREATE DATABASE Hospital


--------------------TABLES------------------


-- Create the Department table
CREATE TABLE Department (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Create the Doctors table
CREATE TABLE Doctors (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Specialty VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE

);

-- Create the Patients table
CREATE TABLE Patients (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(10)
);

-- Create the Appointments table
CREATE TABLE Appointments (
    ID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    TimeSlot VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Create the Rooms table
CREATE TABLE Rooms (
    ID INT PRIMARY KEY,
    RoomNumber VARCHAR(10)
);

-- Create the Admissions table
CREATE TABLE Admissions (
    ID INT PRIMARY KEY,
    PatientID INT,
    RoomID INT,
    AdmissionDate DATE,
    DischargeDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY (RoomID) REFERENCES Rooms(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Create the BillingInformation table
CREATE TABLE BillingInformation (
    ID INT PRIMARY KEY,
    PatientID INT,
    AdmissionID INT,
    TotalAmount DECIMAL(18, 2),
    FOREIGN KEY (PatientID) REFERENCES Patients(ID),
    FOREIGN KEY (AdmissionID) REFERENCES Admissions(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--------------------------------VIEWS----------------------------

-- Create the Reception view
CREATE VIEW Reception AS
SELECT 
    Patients.ID AS PatientID,
    Patients.Name AS PatientName,
    Appointments.ID AS AppointmentID,
    Appointments.AppointmentDate,
    Appointments.TimeSlot,
    Doctors.Name AS DoctorName,
    Department.Name AS DepartmentName
FROM 
    Patients
    JOIN Appointments ON Patients.ID = Appointments.PatientID
    JOIN Doctors ON Appointments.DoctorID = Doctors.ID
    JOIN Department ON Doctors.DepartmentID = Department.ID;

-- Create the PatientInfo view
CREATE VIEW PatientInfo AS
SELECT 
    Patients.ID AS PatientID,
    Patients.Name AS PatientName,
    Patients.Age,
    Patients.Gender,
    Admissions.ID AS AdmissionID,
    Admissions.AdmissionDate,
    Admissions.DischargeDate,
    Rooms.RoomNumber
FROM 
    Patients
    JOIN Admissions ON Patients.ID = Admissions.PatientID
    JOIN Rooms ON Admissions.RoomID = Rooms.ID;

-- Create the DoctorSchedule view
CREATE VIEW DoctorSchedule AS
SELECT 
    Doctors.ID AS DoctorID,
    Doctors.Name AS DoctorName,
    Appointments.ID AS AppointmentID,
    Appointments.AppointmentDate,
    Appointments.TimeSlot
FROM 
    Doctors
    JOIN Appointments ON Doctors.ID = Appointments.DoctorID;


-- Create the PatientHistory view
CREATE VIEW PatientHistory AS
SELECT 
    p.ID AS PatientID, 
    p.Name AS PatientName, 
    a.AppointmentDate, 
    d.Name AS DepartmentName, 
    dg.Name AS DoctorName, 
    r.RoomNumber, 
    ad.AdmissionDate, 
    ad.DischargeDate, 
    b.TotalAmount
FROM 
    Patients p
    JOIN Appointments a ON p.ID = a.PatientID
    JOIN Doctors dg ON a.DoctorID = dg.ID
    JOIN Department d ON dg.DepartmentID = d.ID
    JOIN Admissions ad ON p.ID = ad.PatientID
    JOIN Rooms r ON ad.RoomID = r.ID
    JOIN BillingInformation b ON ad.ID = b.AdmissionID;


-------------- INSERTION -------------
-- Insert values in the Department table
INSERT INTO Department  VALUES
(1, 'Cardiology'),
(2, 'Dermatology'),
(3, 'Gastroenterology'),
(4, 'Neurology'),
(5, 'Oncology'),
(6, 'Orthopedics'),
(7, 'Diabetics');

-- Insert values in the Doctors table
INSERT INTO Doctors  VALUES
(1, 'Dr.Ibrahim', 'Cardiology', 1),
(2, 'Dr.Zakir', 'Dermatology', 2),
(3, 'Dr.Umer Hayat', 'Gastroenterology', 3),
(4, 'Dr.Riaz', 'Neurology', 4),
(5, 'Dr.Pervaiz', 'Oncology', 5),
(6, 'Dr.Abdullah Sultan', 'Orthopedics', 6),
(7, 'Dr.Nazeer Ahmed', 'Diabetics', 7),
(8, 'Dr.Humayon Cheema', 'Cardiology', 1);

-- Insert values in the Patients table
INSERT INTO Patients  VALUES
(1, 'Ahmed Butt', 35, 'Male'),
(2, 'Umair Ahmed', 42, 'Male'),
(3, 'Saima', 28, 'Female'),
(4, 'M Zakria', 21, 'Male'),
(5, 'Salman Farooq', 50, 'Male'),
(6, 'Asif Ali', 65, 'Male'),
(7, 'Zubair Mehmood', 52, 'Male'),
(8, 'Nusrat', 76, 'Female'),
(9, 'David Johnson', 38, 'Male');

-- Insert values in the Appointments table
INSERT INTO Appointments  VALUES
(1, 1, 1, '2023-02-13', '10:00 AM'),
(2, 2, 2, '2023-02-14', '11:00 AM'),
(3, 3, 3, '2023-02-15', '12:00 PM'),
(4, 4, 4, '2023-02-16', '01:00 PM'),
(5, 5, 5, '2023-02-17', '02:00 PM'),
(6, 6, 6, '2023-02-18', '03:00 PM'),
(7, 7, 7, '2023-02-19', '04:00 PM'),
(8, 8, 8, '2023-02-20', '05:00 PM'),
(9, 9, 1, '2023-02-21', '06:00 PM'),
(10, 1, 2, '2023-02-22', '07:00 PM');

-- Insert values in the Rooms table
INSERT INTO Rooms  VALUES
(1, '101'),
(2, '102'),
(3, '103'),
(4, '104'),
(5, '105'),
(6, '106'),
(7, '107'),
(8, '108'),
(9, '109'),
(10, '110');

-- Insert values in the Admissions table
INSERT INTO Admissions VALUES
(1, 1, 1, '2022-01-01', '2022-01-02'),
(2, 2, 2, '2022-01-03', '2022-01-05'),
(3, 3, 3, '2022-01-06', '2022-01-08'),
(4, 4, 4, '2022-01-09', '2022-01-10'),
(5, 5, 5, '2022-01-11', '2022-01-12'),
(6, 6, 6, '2022-01-13', '2022-01-14'),
(7, 7, 7, '2022-01-15', '2022-01-16'),
(8, 8, 8, '2022-01-17', '2022-01-18');

-- Insert values in the BillingInformation table
INSERT INTO BillingInformation (ID, PatientID, AdmissionID, TotalAmount) VALUES
(1, 1, 1, 1000.00),
(2, 2, 2, 2000.00),
(3, 3, 3, 3000.00),
(4, 4, 4, 4000.00),
(5, 5, 5, 5000.00),
(6, 6, 6, 6000.00),
(7, 7, 7, 7000.00),
(8, 8, 8, 8000.00);


---------- SHOW TABLES---------

SELECT * FROM Department
SELECT * FROM Doctors
SELECT * FROM Patients
SELECT * FROM Appointments
SELECT * FROM Rooms
SELECT * FROM BillingInformation

---------- SHOW VIEWS ----------
SELECT * FROM DoctorSchedule
SELECT * FROM PatientHistory
SELECT * FROM PatientInfo
SELECT * FROM Reception
