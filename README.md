QUE1.Display all appointments scheduled on a specific date.
select * from appointment
where appointment_created='2026-06-01';

QUE2.Find all doctors who specialize in "Cardiology".
select * from doctor
where specialist='cardiology';

QUE3.Find patients born after 2000-01-01.
select * from patient
where dob='1990-05-10';

QUE4.Show lab reports with blood pressure greater than 140.
select * from labs
where blood_pressure='120';

QUE5.Find the highest doctor charge from Bill table.
SELECT MAX(total_bill) AS highest_doctor_charge
FROM Bill;

QUE6.Display doctor names and appointments handled by them.
select a.appointment_id, d.first_name, a.appointment_created
from doctor d
join appointment a
on d.doctor_id = a.docter_id;

QUE7.Display medicine names and supplier companies.
select m.medicine_name, s.supplier_name 
from medicines m
join supplier s
on m.supplier_id = s.supplier_id ;

QUE8.Find patients whose bill amount is greater than the average bill amount.
SELECT *
FROM Bill
WHERE total_bill > (
    SELECT AVG(total_bill)
    FROM Bill
);

QUE9.Find patients having the highest hospital bill.
SELECT *
FROM Bill
WHERE total_bill = (
    SELECT MAX(total_bill)
    FROM Bill
);

QUE10.Why would you create an index on the email column?
ANS:An index on the email column is created to improve search performance.

QUE11.How does indexing improve appointment search performance?
-- Indexing improves appointment search performance by reducing the amount of data the database has to scan.

QUE12.Display Patients with Bills Using CTE
WITH Patient_Bills AS (
		SELECT p.patient_id , p.first_name, b.bill_no, b.total_bill
		FROM patient p
		JOIN bill b
		ON p.patient_id = b.patient_id)
SELECT * FROM Patient_Bills;

QUE13.Doctor-wise Patient Count
WITH DoctorPatientCount AS (
    SELECT
        doctor_id,
        COUNT(patient_id) AS patient_count
    FROM patient_reportes2
    GROUP BY doctor_id
)
SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialist,
    COALESCE(dp.patient_count, 0) AS patient_count
FROM doctor d
LEFT JOIN DoctorPatientCount dp
    ON d.doctor_id = dp.doctor_id
ORDER BY patient_count DESC;

QUE14.Top Revenue Patient
WITH PatientRevenue AS (
    SELECT
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        b.total_bill
    FROM patient p
    JOIN bill b
        ON p.patient_id = b.patient_id
)
SELECT *
FROM PatientRevenue
WHERE total_bill = (
    SELECT MAX(total_bill)
    FROM PatientRevenue
);


QUE15.Monthly Revenue Report
WITH MonthlyRevenue AS (
    SELECT
        YEAR(a.appointment_created) AS revenue_year,
        MONTH(a.appointment_created) AS revenue_month,
        SUM(b.total_bill) AS total_revenue
    FROM appointment a
    JOIN patient_reportes2 pr
        ON a.docter_id = pr.doctor_id
    JOIN bill b
        ON pr.patient_id = b.patient_id
    GROUP BY
        YEAR(a.appointment_created),
        MONTH(a.appointment_created)
)
SELECT *
FROM MonthlyRevenue
ORDER BY revenue_year, revenue_month;
