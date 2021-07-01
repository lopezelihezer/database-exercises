-- CASE exercises

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT 	dept_emp.emp_no -- 10144
			hire_date,
			dept_no,
			to_date,
			IF( dept_emp.emp_no IN (	#Condition for current employees
									SELECT emp_no 
									FROM dept_emp 
									WHERE to_date > curdate()
							), True, False
				) AS is_current_employee
FROM employees #emp_no, hire_date
# JOIN (SELECT DISTINCT emp_no, dept_no, to_date  FROM dept_emp) AS no_dupes USING(emp_no); #dept_no, to_date
JOIN dept_emp ON dept_emp.emp_no = employess.emp_no 
JOIN (SELECT DISTINCT dept_emp.emp_no FROM dept_emp) AS extra;

-- Example code:
SELECT 
	de.emp_no,
	dept_no,
	hire_date,
	to_date,
	IF(to_date > CURDATE(), 1, 0) AS current_employee
FROM dept_emp AS de
JOIN (SELECT 
			emp_no,
			MAX(to_date) AS max_date
		FROM dept_emp
		GROUP BY emp_no) as last_dept 
		ON de.emp_no = last_dept.emp_no
			AND de.to_date = last_dept.max_date
JOIN employees AS e ON e.emp_no = de.emp_no;

SELECT DISTINCT emp_no FROM dept_emp;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT 	first_name, 
			last_name, 
			CASE  
			WHEN SUBSTR(last_name, 1, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') 
			THEN 'A-H'
			WHEN SUBSTR(last_name, 1, 1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q')
			THEN 'I-Q'
			WHEN SUBSTR(last_name, 1, 1) IN ('r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')
			THEN 'R-Z'
			END AS 'alpha_group'
FROM employees;

SELECT IF(SUBSTR(last_name, 1, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'), 'A-H', False)
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
SELECT emp_no, 
			CASE
				WHEN birth_date LIKE '194%' 
					THEN "40's"
				WHEN birth_date LIKE '195%' 
						THEN "50's"
				WHEN birth_date LIKE '196%' 
						THEN "60's"
				WHEN birth_date LIKE '197%' 
						THEN "70's"
				WHEN birth_date LIKE '198%' 
						THEN "80's"
				WHEN birth_date LIKE '199%' 
					THEN "90's"
				END AS 'Decade'
FROM employees;


-- BONUS
-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

