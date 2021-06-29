-- Join Exercises

-- 1. Select all records from both users and roles tables
USE join_example_db;

SELECT * FROM users;

SELECT * FROM roles;

-- 2. Use join, left join and right join to combine results. 

SELECT * 
FROM users
JOIN roles ON roles.id = users.role_id;

SELECT * 
FROM users
LEFT JOIN roles ON roles.id = users.role_id;

SELECT * 
FROM users
RIGHT JOIN roles ON roles.id = users.role_id;

-- 3. List of roles along with the number of users who have that role.
SELECT roles.name AS role, count(*) as count 
FROM users
RIGHT JOIN roles ON roles.id = users.role_id
GROUP BY roles.id;

-- Employees Database exercises

-- 1. Use employees database. 
USE employees;

-- 2. Department name and current department manager
SELECT CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager", d.dept_name
FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01';

-- 3. Find the name of all departments currently managed by women.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager", d.dept_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' and e.gender = 'F';

-- 4. Find the current titles of employees currently working in the Customer Service department (d009). Show title and count.
SELECT DISTINCT title FROM titles; # shows all unique titles

SELECT title, count(*) FROM titles
GROUP BY title; # Shows how many employees have a certain title.

SELECT * from dept_emp 
where dept_no = 'd009' and to_date = '9999-01-01'; # shows all current employees in the Customer service department. 

SELECT emp_no, count(*) AS count
from dept_emp 
where dept_no = 'd009' and to_date = '9999-01-01'
GROUP BY emp_no; # Found no duplicates

SELECT titles.title AS Title, count(*) AS Count
FROM titles
JOIN employees AS e ON e.emp_no = titles.emp_no
JOIN dept_emp AS de ON de.emp_no = e.emp_no
WHERE de.dept_no = 'd009' and de.to_date = '9999-01-01'
GROUP BY Title;


