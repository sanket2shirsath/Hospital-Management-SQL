CREATE DATABASE HospitalManagementDB;
USE HospitalManagementDB;


-- Department Table 
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    head_doctor_id INT
);

DESC Departments;

-- Patients Table 
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(50),
    blood_group VARCHAR(5),
    registration_date DATE NOT NULL
);

DESC Patients;

-- Doctors Table 
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    joining_date DATE,
    
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
);

DESC Doctors;

ALTER TABLE Departments ADD CONSTRAINT fk_head_doctor
FOREIGN KEY (head_doctor_id) REFERENCES Doctors(doctor_id);

DESC Departments;

-- Appointments Table 
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME,
    appointment_status VARCHAR(30),
    reason VARCHAR(255),
    
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

DESC Appointments;

-- Admissions Table 
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    room_number VARCHAR(20),
    admission_type VARCHAR(50),
    admission_status VARCHAR(30),

FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id));

DESC Admissions;

-- Treatments Table 
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    admission_id INT,
    treatment_date DATE NOT NULL,
    treatment_type VARCHAR(100),
    diagnosis VARCHAR(255),
    treatment_description TEXT,
    treatment_cost DECIMAL(10,2),

FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id));

DESC Treatments;


-- Medications Table
CREATE TABLE Medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    treatment_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    start_date DATE,
    end_date DATE,

FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id));

DESC Medications;

-- Billing Table
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    admission_id INT,
    treatment_id INT,
    bill_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    payment_method VARCHAR(30),

FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id),
FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id));

DESC Billing;

INSERT INTO Departments (department_id, department_name, location, head_doctor_id) VALUES
(1, 'Cardiology', 'Block A - 1st Floor', NULL),
(2, 'Neurology', 'Block A - 2nd Floor', NULL),
(3, 'Orthopedics', 'Block B - 1st Floor', NULL),
(4, 'Pediatrics', 'Block B - 2nd Floor', NULL),
(5, 'Dermatology', 'Block C - 1st Floor', NULL),
(6, 'General Medicine', 'Block C - 2nd Floor', NULL),
(7, 'Gynecology', 'Block D - 1st Floor', NULL),
(8, 'Oncology', 'Block D - 2nd Floor', NULL),
(9, 'Emergency Medicine', 'Emergency Block', NULL),
(10, 'ENT', 'Block E - 1st Floor', NULL),
(11, 'Psychiatry', 'Block E - 2nd Floor', NULL),
(12, 'Urology', 'Block F - 1st Floor', NULL),
(13, 'Nephrology', 'Block F - 2nd Floor', NULL),
(14, 'Gastroenterology', 'Block G - 1st Floor', NULL),
(15, 'Pulmonology', 'Block G - 2nd Floor', NULL),
(16, 'Endocrinology', 'Block H - 1st Floor', NULL),
(17, 'Rheumatology', 'Block H - 2nd Floor', NULL),
(18, 'Ophthalmology', 'Block I - 1st Floor', NULL),
(19, 'Dentistry', 'Block I - 2nd Floor', NULL),
(20, 'Radiology', 'Block J - 1st Floor', NULL),
(21, 'Pathology', 'Block J - 2nd Floor', NULL),
(22, 'Anesthesiology', 'Block K - 1st Floor', NULL),
(23, 'General Surgery', 'Block K - 2nd Floor', NULL),
(24, 'Plastic Surgery', 'Block L - 1st Floor', NULL),
(25, 'Neurosurgery', 'Block L - 2nd Floor', NULL),
(26, 'Vascular Surgery', 'Block M - 1st Floor', NULL),
(27, 'Infectious Diseases', 'Block M - 2nd Floor', NULL),
(28, 'Hematology', 'Block N - 1st Floor', NULL),
(29, 'Critical Care', 'Block N - 2nd Floor', NULL),
(30, 'Physiotherapy', 'Block O - 1st Floor', NULL);

SELECT * FROM Departments;

INSERT INTO Patients(patient_id, first_name, last_name, gender, date_of_birth, phone, email, city, blood_group, registration_date) VALUES
(1, 'Aarav', 'Sharma', 'Male', '1985-03-15', '9876501001', 'aarav.sharma@gmail.com', 'Mumbai', 'O+', '2023-01-10'),
(2, 'Priya', 'Patil', 'Female', '1992-07-22', '9876501002', 'priya.patil@gmail.com', 'Pune', 'A+', '2023-01-15'),
(3, 'Rohan', 'Mehta', 'Male', '1978-11-05', '9876501003', 'rohan.mehta@gmail.com', 'Mumbai', 'B+', '2023-02-03'),
(4, 'Sneha', 'Joshi', 'Female', '1995-01-18', '9876501004', 'sneha.joshi@gmail.com', 'Nashik', 'AB+', '2023-02-12'),
(5, 'Vikram', 'Deshmukh', 'Male', '1969-06-30', '9876501005', 'vikram.deshmukh@gmail.com', 'Nagpur', 'O-', '2023-02-20'),
(6, 'Anjali', 'Kulkarni', 'Female', '1988-09-12', '9876501006', 'anjali.kulkarni@gmail.com', 'Mumbai', 'B-', '2023-03-01'),
(7, 'Rahul', 'Shah', 'Male', '1990-04-25', '9876501007', 'rahul.shah@gmail.com', 'Thane', 'A-', '2023-03-10'),
(8, 'Neha', 'Verma', 'Female', '1982-12-08', '9876501008', 'neha.verma@gmail.com', 'Pune', 'O+', '2023-03-18'),
(9, 'Amit', 'Rao', 'Male', '1975-08-19', '9876501009', 'amit.rao@gmail.com', 'Mumbai', 'AB-', '2023-03-25'),
(10, 'Pooja', 'Nair', 'Female', '1998-05-14', '9876501010', 'pooja.nair@gmail.com', 'Navi Mumbai', 'A+', '2023-04-02'),
(11, 'Sanjay', 'Gupta', 'Male', '1965-10-27', '9876501011', 'sanjay.gupta@gmail.com', 'Mumbai', 'B+', '2023-04-15'),
(12, 'Kavita', 'Iyer', 'Female', '1987-02-11', '9876501012', 'kavita.iyer@gmail.com', 'Pune', 'O+', '2023-04-22'),
(13, 'Akash', 'Tiwari', 'Male', '1993-06-17', '9876501013', 'akash.tiwari@gmail.com', 'Aurangabad', 'A-', '2023-05-05'),
(14, 'Riya', 'Bansal', 'Female', '1991-11-23', '9876501014', 'riya.bansal@gmail.com', 'Mumbai', 'AB+', '2023-05-12'),
(15, 'Manish', 'Yadav', 'Male', '1972-03-09', '9876501015', 'manish.yadav@gmail.com', 'Thane', 'O-', '2023-05-20'),
(16, 'Swati', 'Desai', 'Female', '1985-07-28', '9876501016', 'swati.desai@gmail.com', 'Nashik', 'B+', '2023-06-01'),
(17, 'Karan', 'Singh', 'Male', '1996-09-16', '9876501017', 'karan.singh@gmail.com', 'Mumbai', 'A+', '2023-06-10'),
(18, 'Meera', 'Nair', 'Female', '1979-01-05', '9876501018', 'meera.nair@gmail.com', 'Pune', 'O+', '2023-06-18'),
(19, 'Suresh', 'Patil', 'Male', '1968-05-21', '9876501019', 'suresh.patil@gmail.com', 'Kolhapur', 'B-', '2023-06-25'),
(20, 'Isha', 'Agarwal', 'Female', '1994-12-13', '9876501020', 'isha.agarwal@gmail.com', 'Mumbai', 'AB+', '2023-07-03'),
(21, 'Deepak', 'Mishra', 'Male', '1980-08-07', '9876501021', 'deepak.mishra@gmail.com', 'Nagpur', 'O+', '2023-07-15'),
(22, 'Nisha', 'Reddy', 'Female', '1989-04-29', '9876501022', 'nisha.reddy@gmail.com', 'Mumbai', 'A+', '2023-07-22'),
(23, 'Sameer', 'Khan', 'Male', '1976-10-18', '9876501023', 'sameer.khan@gmail.com', 'Thane', 'B+', '2023-08-05'),
(24, 'Tanvi', 'Desai', 'Female', '1997-03-26', '9876501024', 'tanvi.desai@gmail.com', 'Pune', 'O-', '2023-08-12'),
(25, 'Mohan', 'Reddy', 'Male', '1963-12-02', '9876501025', 'mohan.reddy@gmail.com', 'Mumbai', 'AB-', '2023-08-20'),
(26, 'Aarti', 'Choudhary', 'Female', '1984-06-15', '9876501026', 'aarti.choudhary@gmail.com', 'Navi Mumbai', 'B+', '2023-09-01'),
(27, 'Sanjay', 'Kulkarni', 'Male', '1990-02-24', '9876501027', 'sanjay.kulkarni@gmail.com', 'Nashik', 'A-', '2023-09-10'),
(28, 'Monica', 'Fernandes', 'Female', '1970-09-09', '9876501028', 'monica.fernandes@gmail.com', 'Mumbai', 'O+', '2023-09-18'),
(29, 'Aditya', 'Joshi', 'Male', '1999-11-30', '9876501029', 'aditya.joshi@gmail.com', 'Pune', 'A+', '2023-10-05'),
(30, 'Shalini', 'Menon', 'Female', '1983-05-11', '9876501030', 'shalini.menon@gmail.com', 'Mumbai', 'B-', '2023-10-15');

SELECT * FROM Patients;

INSERT INTO Doctors (doctor_id, doctor_name, specialization, department_id, phone, email, joining_date) VALUES
(1, 'Dr. Rajesh Sharma', 'Cardiologist', 1, '9876543201', 'rajesh.sharma@hospital.com', '2018-04-12'),
(2, 'Dr. Priya Mehta', 'Neurologist', 2, '9876543202', 'priya.mehta@hospital.com', '2019-07-15'),
(3, 'Dr. Amit Verma', 'Orthopedic Surgeon', 3, '9876543203', 'amit.verma@hospital.com', '2017-02-20'),
(4, 'Dr. Neha Kapoor', 'Pediatrician', 4, '9876543204', 'neha.kapoor@hospital.com', '2020-01-10'),
(5, 'Dr. Rohit Joshi', 'Dermatologist', 5, '9876543205', 'rohit.joshi@hospital.com', '2018-09-18'),
(6, 'Dr. Sneha Patil', 'General Physician', 6, '9876543206', 'sneha.patil@hospital.com', '2019-03-25'),
(7, 'Dr. Anjali Deshmukh', 'Gynecologist', 7, '9876543207', 'anjali.deshmukh@hospital.com', '2016-11-05'),
(8, 'Dr. Vikram Malhotra', 'Oncologist', 8, '9876543208', 'vikram.malhotra@hospital.com', '2015-06-14'),
(9, 'Dr. Karan Singh', 'Emergency Physician', 9, '9876543209', 'karan.singh@hospital.com', '2021-08-22'),
(10, 'Dr. Meera Nair', 'ENT Specialist', 10, '9876543210', 'meera.nair@hospital.com', '2017-12-01'),
(11, 'Dr. Arjun Rao', 'Psychiatrist', 11, '9876543211', 'arjun.rao@hospital.com', '2019-05-17'),
(12, 'Dr. Pooja Kulkarni', 'Urologist', 12, '9876543212', 'pooja.kulkarni@hospital.com', '2018-10-11'),
(13, 'Dr. Suresh Iyer', 'Nephrologist', 13, '9876543213', 'suresh.iyer@hospital.com', '2016-03-08'),
(14, 'Dr. Kavita Shah', 'Gastroenterologist', 14, '9876543214', 'kavita.shah@hospital.com', '2020-06-19'),
(15, 'Dr. Nitin Gupta', 'Pulmonologist', 15, '9876543215', 'nitin.gupta@hospital.com', '2017-08-27'),
(16, 'Dr. Riya Bansal', 'Endocrinologist', 16, '9876543216', 'riya.bansal@hospital.com', '2019-11-13'),
(17, 'Dr. Manish Yadav', 'Rheumatologist', 17, '9876543217', 'manish.yadav@hospital.com', '2018-01-29'),
(18, 'Dr. Swati Joshi', 'Ophthalmologist', 18, '9876543218', 'swati.joshi@hospital.com', '2021-04-16'),
(19, 'Dr. Deepak Mishra', 'Dentist', 19, '9876543219', 'deepak.mishra@hospital.com', '2016-09-23'),
(20, 'Dr. Shalini Menon', 'Radiologist', 20, '9876543220', 'shalini.menon@hospital.com', '2017-05-12'),
(21, 'Dr. Akash Tiwari', 'Pathologist', 21, '9876543221', 'akash.tiwari@hospital.com', '2019-02-07'),
(22, 'Dr. Nisha Reddy', 'Anesthesiologist', 22, '9876543222', 'nisha.reddy@hospital.com', '2018-07-21'),
(23, 'Dr. Rahul Chavan', 'General Surgeon', 23, '9876543223', 'rahul.chavan@hospital.com', '2015-12-18'),
(24, 'Dr. Isha Agarwal', 'Plastic Surgeon', 24, '9876543224', 'isha.agarwal@hospital.com', '2020-09-09'),
(25, 'Dr. Sameer Khan', 'Neurosurgeon', 25, '9876543225', 'sameer.khan@hospital.com', '2016-06-30'),
(26, 'Dr. Tanvi Desai', 'Vascular Surgeon', 26, '9876543226', 'tanvi.desai@hospital.com', '2019-10-04'),
(27, 'Dr. Mohan Reddy', 'Infectious Disease Specialist', 27, '9876543227', 'mohan.reddy@hospital.com', '2017-03-16'),
(28, 'Dr. Aarti Choudhary', 'Hematologist', 28, '9876543228', 'aarti.choudhary@hospital.com', '2018-12-10'),
(29, 'Dr. Sanjay Kulkarni', 'Critical Care Specialist', 29, '9876543229', 'sanjay.kulkarni@hospital.com', '2015-08-05'),
(30, 'Dr. Monica Fernandes', 'Physiotherapist', 30, '9876543230', 'monica.fernandes@hospital.com', '2021-01-18');

SELECT * FROM Doctors;

INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, appointment_status, reason) VALUES
(1, 1, 1, '2023-01-12', '09:30:00', 'Completed', 'Chest pain and routine cardiac checkup'),
(2, 2, 7, '2023-01-18', '10:00:00', 'Completed', 'Routine gynecological consultation'),
(3, 3, 2, '2023-02-05', '11:30:00', 'Completed', 'Frequent headaches and dizziness'),
(4, 4, 4, '2023-02-14', '09:00:00', 'Completed', 'Child vaccination and health checkup'),
(5, 5, 3, '2023-02-22', '14:00:00', 'Completed', 'Knee pain and joint stiffness'),
(6, 6, 5, '2023-03-03', '10:30:00', 'Completed', 'Skin allergy and rash'),
(7, 7, 6, '2023-03-12', '11:00:00', 'Completed', 'Fever and general weakness'),
(8, 8, 15, '2023-03-20', '15:30:00', 'Completed', 'Breathing difficulty and cough'),
(9, 9, 8, '2023-03-27', '09:30:00', 'Completed', 'Oncology consultation'),
(10, 10, 10, '2023-04-04', '10:00:00', 'Completed', 'Ear pain and hearing problem'),
(11, 11, 11, '2023-04-17', '13:00:00', 'Completed', 'Anxiety and sleep problems'),
(12, 12, 13, '2023-04-24', '11:30:00', 'Completed', 'Kidney function consultation'),
(13, 13, 14, '2023-05-07', '09:00:00', 'Completed', 'Stomach pain and digestive issues'),
(14, 14, 16, '2023-05-14', '14:30:00', 'Completed', 'Diabetes and hormone checkup'),
(15, 15, 17, '2023-05-22', '10:30:00', 'Completed', 'Joint pain and inflammation'),
(16, 16, 18, '2023-06-03', '12:00:00', 'Completed', 'Vision problems and eye examination'),
(17, 17, 19, '2023-06-12', '15:00:00', 'Completed', 'Dental pain and tooth examination'),
(18, 18, 20, '2023-06-20', '09:30:00', 'Completed', 'Radiology scan consultation'),
(19, 19, 22, '2023-06-27', '11:00:00', 'Completed', 'Pre-surgery anesthesia consultation'),
(20, 20, 23, '2023-07-05', '14:00:00', 'Completed', 'Abdominal pain and surgical consultation'),
(21, 21, 25, '2023-07-17', '10:00:00', 'Completed', 'Neurological surgery consultation'),
(22, 22, 27, '2023-07-24', '13:30:00', 'Completed', 'Infectious disease consultation'),
(23, 23, 28, '2023-08-07', '09:00:00', 'Completed', 'Blood disorder evaluation'),
(24, 24, 30, '2023-08-14', '11:30:00', 'Completed', 'Physiotherapy consultation'),
(25, 25, 29, '2023-08-22', '16:00:00', 'Completed', 'Critical care follow-up'),
(26, 26, 24, '2023-09-03', '10:30:00', 'Cancelled', 'Plastic surgery consultation'),
(27, 27, 26, '2023-09-12', '14:30:00', 'Completed', 'Vascular health consultation'),
(28, 28, 9, '2023-09-20', '18:00:00', 'Completed', 'Emergency medical consultation'),
(29, 29, 12, '2023-10-07', '09:30:00', 'Scheduled', 'Urology consultation'),
(30, 30, 21, '2023-10-17', '11:00:00', 'Scheduled', 'Pathology test consultation');

SELECT * FROM Appointments;

INSERT INTO Admissions (admission_id, patient_id, doctor_id, admission_date, discharge_date, room_number, admission_type, admission_status) VALUES
(1, 1, 1, '2023-01-13', '2023-01-18', 'A101', 'Emergency', 'Discharged'),
(2, 2, 7, '2023-01-20', '2023-01-23', 'D201', 'Scheduled', 'Discharged'),
(3, 3, 2, '2023-02-06', '2023-02-12', 'A205', 'Emergency', 'Discharged'),
(4, 4, 4, '2023-02-15', '2023-02-17', 'B102', 'Scheduled', 'Discharged'),
(5, 5, 3, '2023-02-23', '2023-03-02', 'B105', 'Emergency', 'Discharged'),
(6, 6, 5, '2023-03-04', '2023-03-06', 'C101', 'Scheduled', 'Discharged'),
(7, 7, 6, '2023-03-13', '2023-03-16', 'C205', 'Emergency', 'Discharged'),
(8, 8, 15, '2023-03-21', '2023-03-28', 'G202', 'Emergency', 'Discharged'),
(9, 9, 8, '2023-03-28', '2023-04-05', 'D205', 'Scheduled', 'Discharged'),
(10, 10, 10, '2023-04-05', '2023-04-07', 'E101', 'Scheduled', 'Discharged'),
(11, 11, 11, '2023-04-18', '2023-04-25', 'E205', 'Emergency', 'Discharged'),
(12, 12, 13, '2023-04-25', '2023-05-02', 'F201', 'Scheduled', 'Discharged'),
(13, 13, 14, '2023-05-08', '2023-05-13', 'G101', 'Emergency', 'Discharged'),
(14, 14, 16, '2023-05-15', '2023-05-20', 'H101', 'Scheduled', 'Discharged'),
(15, 15, 17, '2023-05-23', '2023-05-29', 'H205', 'Emergency', 'Discharged'),
(16, 16, 18, '2023-06-04', '2023-06-06', 'I101', 'Scheduled', 'Discharged'),
(17, 17, 19, '2023-06-13', '2023-06-15', 'I205', 'Scheduled', 'Discharged'),
(18, 18, 20, '2023-06-21', '2023-06-24', 'J101', 'Scheduled', 'Discharged'),
(19, 19, 22, '2023-06-28', '2023-07-03', 'K101', 'Emergency', 'Discharged'),
(20, 20, 23, '2023-07-06', '2023-07-12', 'K205', 'Scheduled', 'Discharged'),
(21, 21, 25, '2023-07-18', '2023-07-25', 'L205', 'Emergency', 'Discharged'),
(22, 22, 27, '2023-07-25', '2023-07-29', 'M205', 'Emergency', 'Discharged'),
(23, 23, 28, '2023-08-08', '2023-08-14', 'N101', 'Scheduled', 'Discharged'),
(24, 24, 30, '2023-08-15', '2023-08-19', 'O101', 'Scheduled', 'Discharged'),
(25, 25, 29, '2023-08-23', NULL, 'N205', 'Emergency', 'Admitted'),
(26, 26, 24, '2023-09-04', '2023-09-08', 'L101', 'Scheduled', 'Discharged'),
(27, 27, 26, '2023-09-13', '2023-09-18', 'M101', 'Scheduled', 'Discharged'),
(28, 28, 9, '2023-09-21', '2023-09-25', 'ER101', 'Emergency', 'Discharged'),
(29, 29, 12, '2023-10-08', NULL, 'F101', 'Scheduled', 'Admitted'),
(30, 30, 21, '2023-10-18', '2023-10-22', 'J205', 'Scheduled', 'Discharged');

SELECT * FROM Admissions;

INSERT INTO Treatments (treatment_id, patient_id, doctor_id, admission_id, treatment_date, treatment_type, diagnosis, treatment_description, treatment_cost) VALUES
(1, 1, 1, 1, '2023-01-14', 'Cardiac Evaluation', 'Hypertension', 'ECG, blood pressure monitoring and cardiac assessment', 8500.00),
(2, 2, 7, 2, '2023-01-21', 'Gynecological Treatment', 'Ovarian Cyst', 'Ultrasound examination and medication-based treatment', 12000.00),
(3, 3, 2, 3, '2023-02-07', 'Neurological Treatment', 'Migraine', 'Neurological examination and migraine management', 9500.00),
(4, 4, 4, 4, '2023-02-16', 'Pediatric Treatment', 'Viral Fever', 'Medical observation, medication and hydration therapy', 5000.00),
(5, 5, 3, 5, '2023-02-24', 'Orthopedic Treatment', 'Knee Arthritis', 'X-ray, physiotherapy and pain management', 18000.00),
(6, 6, 5, 6, '2023-03-05', 'Dermatology Treatment', 'Skin Allergy', 'Allergy testing and prescribed skin treatment', 6500.00),
(7, 7, 6, 7, '2023-03-14', 'General Medicine', 'Dengue Fever', 'Blood tests, hydration therapy and medical monitoring', 15000.00),
(8, 8, 15, 8, '2023-03-22', 'Pulmonary Treatment', 'Asthma', 'Pulmonary function test and respiratory treatment', 11000.00),
(9, 9, 8, 9, '2023-03-29', 'Cancer Treatment', 'Breast Cancer', 'Cancer evaluation and chemotherapy planning', 75000.00),
(10, 10, 10, 10, '2023-04-06', 'ENT Treatment', 'Ear Infection', 'Ear examination, cleaning and antibiotic treatment', 5500.00),
(11, 11, 11, 11, '2023-04-19', 'Psychiatric Treatment', 'Anxiety Disorder', 'Psychiatric evaluation and counseling sessions', 9000.00),
(12, 12, 13, 12, '2023-04-26', 'Kidney Treatment', 'Chronic Kidney Disease', 'Kidney function monitoring and medication management', 25000.00),
(13, 13, 14, 13, '2023-05-09', 'Gastrointestinal Treatment', 'Gastritis', 'Endoscopy and medication-based treatment', 14000.00),
(14, 14, 16, 14, '2023-05-16', 'Endocrine Treatment', 'Type 2 Diabetes', 'Blood sugar monitoring and diabetes management', 10000.00),
(15, 15, 17, 15, '2023-05-24', 'Rheumatology Treatment', 'Rheumatoid Arthritis', 'Joint evaluation and anti-inflammatory treatment', 16000.00),
(16, 16, 18, 16, '2023-06-05', 'Eye Treatment', 'Cataract', 'Eye examination and cataract surgery evaluation', 22000.00),
(17, 17, 19, 17, '2023-06-14', 'Dental Treatment', 'Dental Caries', 'Dental examination and cavity filling', 4500.00),
(18, 18, 20, 18, '2023-06-22', 'Radiology Service', 'Chest Abnormality', 'CT scan and diagnostic imaging evaluation', 12500.00),
(19, 19, 22, 19, '2023-06-29', 'Anesthesia Service', 'Preoperative Assessment', 'Preoperative anesthesia evaluation and preparation', 8500.00),
(20, 20, 23, 20, '2023-07-07', 'General Surgery', 'Appendicitis', 'Appendectomy and postoperative medical care', 45000.00),
(21, 21, 25, 21, '2023-07-19', 'Neurosurgery', 'Brain Tumor', 'Neurosurgical evaluation and surgical treatment planning', 95000.00),
(22, 22, 27, 22, '2023-07-26', 'Infectious Disease Treatment', 'Tuberculosis', 'Diagnostic testing and long-term medication management', 28000.00),
(23, 23, 28, 23, '2023-08-09', 'Hematology Treatment', 'Anemia', 'Blood tests, iron therapy and nutritional treatment', 7500.00),
(24, 24, 30, 24, '2023-08-16', 'Physiotherapy', 'Back Pain', 'Physical therapy, stretching and rehabilitation exercises', 6000.00),
(25, 25, 29, 25, '2023-08-24', 'Critical Care', 'Respiratory Failure', 'Intensive monitoring and critical care management', 120000.00),
(26, 26, 24, 26, '2023-09-05', 'Plastic Surgery', 'Burn Injury', 'Burn wound management and reconstructive surgery planning', 55000.00),
(27, 27, 26, 27, '2023-02-25','Vascular Surgery', 'Varicose Veins', 'Vascular examination and minimally invasive treatment', 30000.00),
(28, 28, 9, 28, '2023-09-22', 'Emergency Treatment', 'Acute Chest Pain', 'Emergency evaluation, ECG and immediate medical treatment', 18000.00),
(29, 29, 12, 29, '2023-10-09', 'Urology Treatment', 'Kidney Stone', 'Diagnostic imaging and kidney stone treatment', 27000.00),
(30, 30, 21, 30, '2023-10-19', 'Pathology Service', 'Blood Disorder Evaluation', 'Blood tests and pathological examination', 9000.00);

Select*from Treatments;

INSERT INTO Medications (medication_id, treatment_id, medication_name, dosage, frequency, start_date, end_date) VALUES
(1, 1, 'Amlodipine', '5 mg', 'Once daily', '2023-01-14', '2023-02-14'),
(2, 2, 'Doxycycline', '100 mg', 'Twice daily', '2023-01-21', '2023-01-28'),
(3, 3, 'Sumatriptan', '50 mg', 'As needed', '2023-02-07', '2023-02-21'),
(4, 4, 'Paracetamol', '250 mg', 'Twice daily', '2023-02-16', '2023-02-20'),
(5, 5, 'Ibuprofen', '400 mg', 'Twice daily', '2023-02-24', '2023-03-10'),
(6, 6, 'Cetirizine', '10 mg', 'Once daily', '2023-03-05', '2023-03-15'),
(7, 7, 'Paracetamol', '500 mg', 'Three times daily', '2023-03-14', '2023-03-21'),
(8, 8, 'Budesonide', '200 mcg', 'Twice daily', '2023-03-22', '2023-04-22'),
(9, 9, 'Tamoxifen', '20 mg', 'Once daily', '2023-03-29', '2023-06-29'),
(10, 10, 'Amoxicillin', '500 mg', 'Three times daily', '2023-04-06', '2023-04-13'),
(11, 11, 'Sertraline', '50 mg', 'Once daily', '2023-04-19', '2023-05-19'),
(12, 12, 'Furosemide', '40 mg', 'Once daily', '2023-04-26', '2023-05-26'),
(13, 13, 'Omeprazole', '20 mg', 'Once daily', '2023-05-09', '2023-05-23'),
(14, 14, 'Metformin', '500 mg', 'Twice daily', '2023-05-16', '2023-06-16'),
(15, 15, 'Methotrexate', '10 mg', 'Once weekly', '2023-05-24', '2023-06-24'),
(16, 16, 'Timolol', '0.5%', 'Twice daily', '2023-06-05', '2023-07-05'),
(17, 17, 'Amoxicillin', '500 mg', 'Three times daily', '2023-06-14', '2023-06-21'),
(18, 18, 'Iodixanol', '320 mg/mL', 'Single dose', '2023-06-22', '2023-06-22'),
(19, 19, 'Propofol', '10 mg/mL', 'Single dose', '2023-06-29', '2023-06-29'),
(20, 20, 'Ceftriaxone', '1 g', 'Once daily', '2023-07-07', '2023-07-14'),
(21, 21, 'Dexamethasone', '4 mg', 'Twice daily', '2023-07-19', '2023-08-02'),
(22, 22, 'Isoniazid', '300 mg', 'Once daily', '2023-07-26', '2023-10-26'),
(23, 23, 'Ferrous Sulfate', '325 mg', 'Once daily', '2023-08-09', '2023-09-09'),
(24, 24, 'Diclofenac', '50 mg', 'Twice daily', '2023-08-16', '2023-08-30'),
(25, 25, 'Midazolam', '5 mg', 'As needed', '2023-08-24', '2023-08-24'),
(26, 26, 'Silver Sulfadiazine', '1%', 'Once daily', '2023-09-05', '2023-09-19'),
(27, 27, 'Heparin', '5000 units', 'Twice daily', '2023-09-05', '2023-09-18'),
(28, 28, 'Aspirin', '325 mg', 'Once daily', '2023-09-22', '2023-10-06'),
(29, 29, 'Tamsulosin', '0.4 mg', 'Once daily', '2023-10-09', '2023-10-23'),
(30, 30, 'Vitamin B12', '1000 mcg', 'Once daily', '2023-10-19', '2023-11-19');

Select*from medications;

INSERT INTO Billing (bill_id, patient_id, admission_id, treatment_id, bill_date, total_amount, payment_status, payment_method) VALUES
(1, 1, 1, 1, '2023-01-18', 10500.00, 'Paid', 'Cash'),
(2, 2, 2, 2, '2023-01-23', 14500.00, 'Paid', 'Credit Card'),
(3, 3, 3, 3, '2023-02-12', 11000.00, 'Paid', 'UPI'),
(4, 4, 4, 4, '2023-02-17', 6000.00, 'Paid', 'Cash'),
(5, 5, 5, 5, '2023-03-02', 22000.00, 'Paid', 'Debit Card'),
(6, 6, 6, 6, '2023-03-06', 7500.00, 'Paid', 'UPI'),
(7, 7, 7, 7, '2023-03-16', 18000.00, 'Paid', 'Insurance'),
(8, 8, 8, 8, '2023-03-28', 13500.00, 'Paid', 'Credit Card'),
(9, 9, 9, 9, '2023-04-05', 85000.00, 'Pending', 'Insurance'),
(10, 10, 10, 10, '2023-04-07', 6500.00, 'Paid', 'UPI'),
(11, 11, 11, 11, '2023-04-25', 10500.00, 'Paid', 'Debit Card'),
(12, 12, 12, 12, '2023-05-02', 28000.00, 'Pending', 'Insurance'),
(13, 13, 13, 13, '2023-05-13', 16500.00, 'Paid', 'Cash'),
(14, 14, 14, 14, '2023-05-20', 12000.00, 'Paid', 'UPI'),
(15, 15, 15, 15, '2023-05-29', 19000.00, 'Paid', 'Credit Card'),
(16, 16, 16, 16, '2023-06-06', 25000.00, 'Pending', 'Insurance'),
(17, 17, 17, 17, '2023-06-15', 6000.00, 'Paid', 'Cash'),
(18, 18, 18, 18, '2023-06-24', 14500.00, 'Paid', 'Debit Card'),
(19, 19, 19, 19, '2023-07-03', 10000.00, 'Paid', 'UPI'),
(20, 20, 20, 20, '2023-07-12', 50000.00, 'Pending', 'Insurance'),
(21, 21, 21, 21, '2023-07-25', 105000.00, 'Pending', 'Insurance'),
(22, 22, 22, 22, '2023-07-29', 32000.00, 'Paid', 'Credit Card'),
(23, 23, 23, 23, '2023-08-14', 9000.00, 'Paid', 'UPI'),
(24, 24, 24, 24, '2023-08-19', 7500.00, 'Paid', 'Cash'),
(25, 25, 25, 25, '2023-08-24', 135000.00, 'Pending', 'Insurance'),
(26, 26, 26, 26, '2023-09-08', 62000.00, 'Paid', 'Credit Card'),
(27, 27, 27, 27, '2023-09-18', 35000.00, 'Paid', 'Debit Card'),
(28, 28, 28, 28, '2023-09-25', 21000.00, 'Paid', 'UPI'),
(29, 29, 29, 29, '2023-10-09', 30000.00, 'Pending', 'Insurance'),
(30, 30, 30, 30, '2023-10-22', 11000.00, 'Paid', 'Cash');

SELECT *FROM BILLING;

-- SUBQUIRES
-- Find patients who have a bill greater than the average bill amount
SELECT CONCAT(first_name, ' ', last_name) AS patient_name FROM Patients
WHERE patient_id IN (SELECT patient_id FROM Billing WHERE total_amount > 
(SELECT AVG(total_amount) FROM Billing));

drop table medications;

-- Find patients having more than one admission (Correlated Subquery)
SELECT *FROM Patients P WHERE ( SELECT COUNT(*) FROM Admissions A
WHERE a.patient_id=p.patient_id)>1;

-- Find doctors having more than one appointment (Correlated Subquery)
SELECT *FROM Doctors d WHERE (
SELECT COUNT(*) FROM Appointments a
WHERE a.doctor_id=d.doctor_id
)>1;

--  Find the department headed by Doctor ID 1. (Single-Row Subquerie)
SELECT * FROM Departments WHERE head_doctor_id=
( SELECT doctor_id FROM Doctors WHERE doctor_id=2 );

-- Find patients whose bill amount is greater than the average bill amount.(Single-Row Subquerie)
SELECT * FROM Patients WHERE patient_id IN 
( SELECT patient_id FROM Billing WHERE total_amount >
(SELECT AVG(total_amount) FROM Billing));

--  Find the treatment with the highest cost.(Single-Row Subquerie)
SELECT Patient_id,treatment_type,treatment_date,treatment_cost FROM Treatments WHERE treatment_cost =
(SELECT MAX(treatment_cost) FROM Treatments);

-- Find doctors working in the Cardiology department. (Single-Row Subquerie)
SELECT * FROM Doctors WHERE department_id =
(SELECT department_id FROM Departments WHERE department_name='Cardiology');

-- Find patients having pending bills. (Multiple-Row Subquerie)
SELECT * FROM Patients WHERE patient_id IN
(SELECT patient_id FROM Billing WHERE payment_status='Pending' );

-- Find treatments costing more than ANY treatment performed by Doctor 1. (Multiple-Row Subquerie)
SELECT * FROM Treatments WHERE treatment_cost > ANY
(SELECT treatment_cost FROM Treatments WHERE doctor_id=5);

-- Find doctors who belong to departments located in Block A. (Multiple-Row Subquerie)
SELECT doctor_id,doctor_name,specialization,department_id FROM Doctors WHERE department_id IN
( SELECT department_id FROM Departments WHERE location LIKE 'Block A%');

-- Find doctors whose average treatment cost is greater than ₹50,000 (Correlated Subquerie)
select d. doctor_name FROM Doctors d
WHERE (SELECT AVG(t.treatment_cost) FROM Treatments t WHERE t.doctor_id = d.doctor_id) > 50000;

SELECT
    d.doctor_id,
    d.doctor_name,
    d.specialization,
    dep.department_name
FROM Doctors d
INNER JOIN Departments dep
ON d.department_id = dep.department_id;

--  Display admitted patients with assigned doctors (Inner Join)
SELECT a.admission_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name, d.doctor_name FROM Admissions a
INNER JOIN Patients p ON a.patient_id = p.patient_id
INNER JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- Display billing with doctor names (Inner Join)
SELECT b.patient_id, d.doctor_name, b.total_amount, b.payment_status FROM Billing b
INNER JOIN Treatments t ON b.treatment_id = t.treatment_id
INNER JOIN Doctors d ON t.doctor_id = d.doctor_id;


-- Display all departments with doctors and appointments(Left Join)
SELECT dep.department_name, d.doctor_name, a.appointment_date, a.appointment_time,d.specialization
FROM Departments dep
LEFT JOIN Doctors d ON dep.department_id = d.department_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id;

-- Display all appointments with department names (Right Join)
SELECT dep.department_name, d.doctor_name, a.appointment_date FROM Departments dep
RIGHT JOIN Doctors d ON dep.department_id = d.department_id
RIGHT JOIN Appointments a ON d.doctor_id = a.doctor_id;

-- Display all paid and pending payment statuses (Union)
SELECT payment_status  FROM Billing UNION
SELECT appointment_status FROM Appointments;

-- List doctor names and patient names alphabetically (Union)
SELECT doctor_name AS doc_Name FROM Doctors UNION
SELECT CONCAT(first_name,' ',last_name) FROM Patients ORDER BY doc_Name;





-- Patient Billing View
CREATE VIEW Patient_Billing_View AS
SELECT p.patient_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name, b.total_amount, b.payment_status, b.payment_method FROM Patients p 
JOIN Billing b ON p.patient_id = b.patient_id;


-- Emergency Admissions View
CREATE VIEW Emergency_Admissions AS
SELECT patient_id,doctor_id,admission_type,admission_status FROM Admissions WHERE admission_type='Emergency';

-- High Cost Treatments View
CREATE VIEW High_Cost_Treatments AS
SELECT Patient_id, doctor_id, treatment_cost,treatment_date FROM Treatments WHERE treatment_cost > 60000;

-- Paid Bills View
CREATE VIEW Paid_Bills AS
SELECT patient_id,total_amount,payment_status,payment_method FROM Billing WHERE payment_status='Paid';

--  Total Hospital Billing Summary 
CREATE VIEW Hospital_Billing_Summary AS
SELECT COUNT(*) AS Total_Bills, SUM(total_amount) AS Total_Revenue, AVG(total_amount) AS Average_Bill FROM Billing;