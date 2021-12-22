-- tables_exercises.sql
USE employees;
SHOW TABLES;
DESCRIBE employees.employees;
-- int, date, varchar(14), varchar(16), enum('M','F'), date
-- emp_no, birth_date, and hire_date hold numbers
-- first_name, last_name, and gender molt likely hold strings
-- birth_date and hire_date hold date type info 
-- there is no direct relationship between employees and departments
SHOW CREATE TABLE dept_manager;
