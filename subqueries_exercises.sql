-- Subqueries Exercises

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
USE employees;
SELECT * FROM employees
WHERE hire_date IN (
		SELECT hire_date
		FROM employees
		WHERE emp_no = 101010 
		);


-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title
FROM titles
WHERE emp_no IN(
		SELECT emp_no
		FROM employees
		WHERE first_name = 'Aamod'
		
)
AND to_date > curdate();

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 300024 no longer working for the company. 

SELECT emp_no, first_name, last_name FROM employees
WHERE emp_no IN(
		SELECT emp_no
		FROM salaries
		WHERE to_date < curdate()
);

-- 4. Find all the current department managers that are female. List their names in a comment in your code.

/*
Isamu	Legleitner	F
Shirish	Ossenbruggen	F
Karsten	Sigstam	F
Krassimir	Wegerle	F
Rosine	Cools	F
Leon	DasSarma	F
Peternela	Onuegbe	F
Rutger	Hofmeyr	F
Sanjoy	Quadeer	F
Hilary	Kambil	F
Tonny	Butterworth	F
Marjo	Giarratana	F
Xiaobin	Spinelli	F
*/

SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN(
		SELECT emp_no
		FROM dept_manager
		WHERE gender = 'F'
);

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary. 154543
SELECT first_name, last_name
FROM employees
WHERE emp_no IN(
		SELECT emp_no
		FROM salaries
		WHERE salary > (SELECT AVG(salary) FROM salaries)
		AND to_date > curdate()
		);


-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT 
FROM salaries
WHERE emp_no IN (
		SELECT emp_no, 
		FROM salaries
		WHERE salary IN(
		
		)

(SELECT stddev(salary) FROM salaries); # standard deviation 

(SELECT max(salary) FROM salaries WHERE to_date > curdate()); # Max historical salary

SELECT emp_no  
FROM salaries 
WHERE salary > 
((SELECT max(salary) FROM salaries WHERE to_date > curdate()) - 
(SELECT stddev(salary) FROM salaries))
AND to_date > curdate(); # Gives me the employee numbers of all curent salaries one stardard deviation below the max. 78



SELECT count(salary) from salaries WHERE to_date > curdate(); #historical: 2844047 current: 240124

-- 0.0325%
SELECT (Num_of_Employees / 
			(SELECT count(salary) from salaries WHERE to_date > curdate())) * 100 AS Percentage
FROM (SELECT count(emp_no) AS Num_of_Employees
		FROM (
		SELECT emp_no  
		FROM salaries 
		WHERE salary > 
				((SELECT max(salary) FROM salaries WHERE to_date > curdate()) - 
				(SELECT stddev(salary) FROM salaries))
		AND to_date > curdate()
				) as t1
		) as t2;


-- BONUS

-- Find all the department names that currently have female managers.
/*
Customer Service
Development
Finance
Human Resources
Production
Quality Management
Research
*/
SELECT dept_name FROM departments WHERE dept_no IN 
(SELECT dept_no FROM dept_manager WHERE emp_no IN
(SELECT emp_no FROM employees WHERE gender = 'F')
);

-- Find the first and last name of the employee with the highest salary.
-- Tokuyasu Pesch
SELECT first_name, last_name FROM employees WHERE emp_no =
(SELECT emp_no FROM salaries WHERE salary = 
(SELECT max(salary) FROM salaries
));

-- Find the department name that the employee with the highest salary works in.
-- Sales
SELECT dept_name FROM departments WHERE dept_no =
	(	SELECT dept_no 
		FROM dept_emp 
		WHERE emp_no =
				(SELECT emp_no 
				FROM salaries 
				WHERE salary = 
						(SELECT max(salary) 
						FROM salaries
						)
			  )
	);