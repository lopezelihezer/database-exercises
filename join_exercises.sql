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
/* WRONG CODE
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
*/
-- 4. Find the current titles of employees currently working in the Customer Service department (d009). Show title and count.
/*
Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

select title, count(title) AS Count
from dept_emp
join departments using(dept_no)
join titles using(emp_no)
where departments.dept_name = "Customer Service"
and dept_emp.to_date > curdate()
and titles.to_date > curdate()
group by title
order by title;

select title, count(*) AS Count
from departments
join dept_emp using(dept_no)
join titles using(emp_no)
where departments.dept_no = "d009"
and dept_emp.to_date > curdate()
and titles.to_date > curdate()
group by title
order by title;

-- NEED TO REVIEW THE FOLLOWING
-- 5.

-- 6.

-- 7.

-- 8.

-- 9.

-- Exercise 5. Find the current salary of all current managers.
select dept_no, salary, concat(first_name, " ", last_name) as "Current Manager"
from salaries
join dept_manager using(emp_no)
join employees using(emp_no)
join departments using(dept_no)
where dept_manager.to_date > curdate()
and salaries.to_date > curdate();

# Exercise 6
# Find the number of current employees in each department.
select dept_no, dept_name, count(*) as num_employees
from departments
join dept_emp using(dept_no)
where to_date > curdate()
group by dept_no
order by dept_no;

# Exercise 7 
# Which department has the highest average salary? Hint: Use current not historic information.

select dept_name, avg(salary) as average_salary
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()
group by dept_name
order by average_salary DESC;

# Exercise 8
# Who is the highest paid employee in the Marketing department? 
select first_name, last_name, salary
from departments
join dept_emp using(dept_no)
join salaries using(emp_no)
join employees using(emp_no)
where salaries.to_date > curdate()
and dept_emp.to_date > curdate()
and dept_name = "Marketing"
order by salary DESC
limit 1;


# Exercise 9
# Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from salaries
join dept_manager using(emp_no)
join departments using(dept_no)
join employees using(emp_no)
where salaries.to_date > curdate()
and dept_manager.to_date > curdate()
order by salary DESC
limit 1;

# 10 BONUS
-- Find the names of all current employees, their department name, and their current manager's name.

select concat(managers.first_name, " ", managers.last_name) as "manager_name", dept_name, concat(employees.first_name, " ", employees.last_name) as "Employee Name"
from employees as managers #aliasing here allows us to "self join" the employees table.
join dept_manager using(emp_no)
join departments using(dept_no)
join dept_emp using(dept_no)
join employees on dept_emp.emp_no = employees.emp_no
where dept_manager.to_date > curdate()
and dept_emp.to_date > curdate();

-- 10. 

SELECT 
	t1.dept_name AS 'Department Name',
	t1.salary AS 'Salary',
	CONCAT(first_name,' ', last_name) AS 'Employee Name'
FROM 
	(
	-- Part 1 which builds the base table to employee names, salaries and dept names
	SELECT
		salary, dept_name, first_name, last_name
	FROM
		salaries
	JOIN
		dept_emp 
	USING(emp_no)
	JOIN 
		departments 
	USING(dept_no)
	JOIN 
		employees
	USING(emp_no)
	WHERE 
		dept_emp.to_date >= NOW()
	AND 
		salaries.to_date >= NOW()
	) AS t1 # This is table_1 result created
INNER JOIN
	(
	-- Part 2 builds another table to cross reference the previous part with the calculated max salaries
	SELECT dept_name, MAX(salary) as max_salary
	FROM 
		(
		SELECT
			salary, dept_name, first_name, last_name
		FROM
			salaries
		JOIN
			dept_emp 
		USING(emp_no)
		JOIN 
			departments 
		USING(dept_no)
		JOIN 
			employees
		USING(emp_no)
		WHERE 
			dept_emp.to_date >= NOW()
			AND 
			salaries.to_date >= NOW()
		) as t2
	GROUP BY dept_name
	) AS t2 # This is table_2 result created
	-- Joins both tables based on the dept_name and matches the salary & department name with the max_salary
	ON 
	t1.dept_name = t2.dept_name
	AND
	t1.salary = t2.max_salary
ORDER BY 'Department Name' DESC;






