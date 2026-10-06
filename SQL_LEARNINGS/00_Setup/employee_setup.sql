CREATE DATABASE IF NOT EXISTS SQL_LEARNINGS;

USE SQL_LEARNINGS;

DROP TABLE IF EXISTS employee;

CREATE TABLE employee(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    job_role VARCHAR(50),
    salary INT
);

INSERT INTO employee(id,name,age,department,job_role,salary)
VALUES
(1, 'Alice', 22, 'IT', 'Developer', 50000),
(2, 'Bob', 25, 'HR', 'HR Executive', 45000),
(3, 'Charlie', 28, 'IT', 'Developer', 65000),
(4, 'David', 24, 'Finance', 'Accountant', 55000),
(5, 'Emma', 30, 'IT', 'Manager', 80000),
(6, 'Frank', 26, 'HR', 'Recruiter', 48000),
(7, 'Grace', 27, 'Finance', 'Analyst', 60000),
(8, 'Henry', 23, 'IT', 'Tester', 52000),
(9, 'Ivy', 29, 'Sales', 'Executive', 47000),
(10, 'Jack', 31, 'Sales', 'Manager', 75000);



