
create table department (
dept_id int primary key,
dept_name varchar(50)
);

CREATE TABLE employeestab
( emp_id INT PRIMARY KEY,
	dept_id int,
	mngr_id int ,
  emp_name varchar(100),
  salary int not null,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);


INSERT INTO employeestab(emp_id, dept_id, mngr_id, emp_name, salary) VALUES
(401, 01, 101, 'Raquel', 90000),
(402, 02, 102, 'Nairobi', 85000),
(403, 04, 103, 'Rio', 75000),
(404, 01, 101, 'Denver', 60000),
(405, 03, 102, 'Helsinki', 50000),
(406, 05, 103, 'Moscow', 65000),
(407, 02, 102, 'Bogota', 55000),
(408, 04, 103, 'Oslo', 75000),
(409, 01, 101, 'Berlin', 99000),
(410, 01, 101, 'Tokyo', 98000);

INSERT INTO department(dept_id, dept_name) VALUES
(01, 'Tech'),
(02, 'Design'),
(03, 'Market'),
(04, 'Sales'),
(05, 'Public Relation');

--1. write a SQL query to find Employees who have the biggest salary in their Department

select dept_id, MAX(salary) From employeestab GROUP BY dept_id

--2. write a SQL query to find Departments that have less than 3 people in it

Select e.dept_id, d.dept_name From employeestab e JOIN department d ON e.dept_id=d.dept_id GROUP BY e.dept_id, d.dept_name HAVING COUNT(*) < 3

--3. write a SQL query to find All Department along with the number of people there

select dept_id, COUNT(*) From employeestab GROUP BY dept_id

--4. write a SQL query to find All Department along with the total salary there

select dept_id, SUM(salary) From employeestab GROUP BY dept_id
