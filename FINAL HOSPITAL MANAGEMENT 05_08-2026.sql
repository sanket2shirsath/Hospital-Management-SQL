SELECT * FROM hospitalmanagementdb.hospital_billing_summary;
--  Total Hospital Billing Summary 
CREATE VIEW Hospital_Billing_Summary AS
SELECT COUNT(*) AS Total_Bills, SUM(total_amount) AS Total_Revenue, AVG(total_amount) AS Average_Bill FROM Billing;

desc departments;

DESC patients;

DESC doctors;

DESC admissions;

DESC treatments;

DESC BILLING;

SELECT * FROM Departments;

SELECT * FROM Patients;

SELECT * FROM doctors;

SELECT * FROM appointments;

SELECT * FROM admissions;

SELECT * FROM treatments;

SELECT * FROM Billing;

-- Find patients whose bill amount is greater than the average bill amount.(Single-Row Subquerie)
SELECT * FROM Patients WHERE patient_id IN 
( SELECT patient_id FROM Billing WHERE total_amount >
(SELECT AVG(total_amount) FROM Billing));



-- Find doctors working in the Cardiology department. (Single-Row Subquerie)
SELECT * FROM Doctors WHERE department_id =
(SELECT department_id FROM Departments WHERE department_name='Cardiology');

-- Find doctors who belong to departments located in Block A. (Multiple-Row Subquerie)
SELECT doctor_id,doctor_name,specialization,department_id FROM Doctors WHERE department_id IN
( SELECT department_id FROM Departments WHERE location LIKE 'Block A%');

-- Find patients having pending bills. (Multiple-Row Subquerie)
SELECT * FROM Patients WHERE patient_id IN
(SELECT patient_id FROM Billing WHERE payment_status='Pending' );

-- Find doctors whose average treatment cost is greater than ₹50,000 (Correlated Subquerie)
select d. doctor_name FROM Doctors d
WHERE (SELECT AVG(t.treatment_cost) FROM Treatments t WHERE t.doctor_id = d.doctor_id) > 50000;

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

-- List doctor names and patient names alphabetically (Union)
SELECT doctor_name AS doc_Name FROM Doctors UNION
SELECT CONCAT(first_name,' ',last_name) FROM Patients ORDER BY doc_Name;

-- Patient Billing View
CREATE VIEW Patient_Billing_View AS
SELECT p.patient_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name, b.total_amount, b.payment_status, b.payment_method FROM Patients p 
JOIN Billing b ON p.patient_id = b.patient_id;

-- High Cost Treatments View
CREATE VIEW High_Cost_Treatment AS
SELECT Patient_id, doctor_id, treatment_cost,treatment_date FROM Treatments WHERE treatment_cost > 60000;
