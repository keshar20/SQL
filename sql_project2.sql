use project_keshar;
select* from salary_data;
create table salary_data20(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
salary DECIMAL(10,2) NOT NULL,
annual_salary DECIMAL(12,2) NOT NULL,
pf DECIMAL(10,2) NOT NULL,
net_salary DECIMAL(10,2) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
select * from salary_data20;