-- Temporary Tables Exercises

-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.
USE employees;

CREATE TEMPORARY TABLE germain_1462.employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;

SELECT * FROM germain_1462.employees_with_departments;
-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
USE germain_1462;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);
-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
SELECT * FROM employees_with_departments;
-- What is another way you could have ended up with this same table?
DROP TABLE employees_with_departments;
USE employees;


CREATE TEMPORARY TABLE germain_1462.employees_with_departments AS
SELECT emp_no,  dept_no, dept_name, CONCAT(first_name, " ", last_name)
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;
USE germain_1462;
SELECT * FROM employees_with_departments;


-- 2. Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
USE germain_1462;

CREATE TEMPORARY TABLE payments_made AS
SELECT *
FROM sakila.payment;

ALTER TABLE payments_made MODIFY COLUMN amount DECIMAL(10,2);

# SELECT CAST(amount as INT)
-- REview Question 3 
-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

USE germain_1462;

SELECT avg(salary), std(salary) from employees.salaries;

-- saving values for later... that what variables do (with a name)
CREATE temporary table historic_aggregates as (
 select avg(salary) as avg_salary, std(salary) as std_salary
 from employees.salaries);
 
 select * from historicalggregates;
 
 -- If you see "for each" in the English for a query to build..
 --  THen, you're prob going to use a group by...
 select dept_name, avg(salary) as department_currrent_average
 from employees.salaries
 join employees.dept_emp using(emp_no)
 join employees.departments using(dept_no)
 where employees.dept_emp.to_date > curdate()
 and employees.salto_date > curdate()
 group by dept_name
 );
 
 select * from current_info;
 
update current_info set historic_avg = (select avg_salary from historic_aggregates);
update current_info set historic_std = (select std_salary from historic_aggregates);
  
select * from current_info;
   
update current_info set zscore = (department_current_average - historic_avg) / historic_std;

select * from current_info;