-- Subqueries Exercises

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query. 55
-- spacing is not necessarily important
USE employees;
SELECT * FROM employees
WHERE hire_date IN (
		SELECT hire_date
		FROM employees
		WHERE emp_no = 101010 
		)
		and emp_no in (
		select emp_no 
		from dept_emp
		where to_date > curdate()
		);


-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title
FROM titles
WHERE emp_no IN(
		SELECT emp_no
		FROM employees
		WHERE first_name = 'Aamod'
		
)
AND to_date > curdate()
GROUP BY title;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 59900 no longer working for the company. 

SELECT emp_no, first_name, last_name 
FROM employees
WHERE emp_no NOT IN(
		SELECT emp_no
		FROM dept_emp
		WHERE to_date > curdate()
						);

-- 4. Find all the current department managers that are female. List their names in a comment in your code.

/*
Isamu	Legleitner	F
Karsten	Sigstam	F
Leon	DasSarma	F
Hilary	Kambil	F
*/

SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN(
		SELECT emp_no
		FROM dept_manager
		WHERE gender = 'F'
		AND to_date > now()
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

(SELECT stddev(salary) FROM salaries); # standard deviation 

(SELECT max(salary) FROM salaries WHERE to_date > curdate()); # Max historical salary

SELECT emp_no  
FROM salaries 
WHERE salary >= 
((SELECT max(salary) FROM salaries WHERE to_date > curdate()) - 
(SELECT stddev(salary) FROM salaries))
AND to_date > curdate(); # Gives me the employee numbers of all curent salaries one stardard deviation below the max. 78

SELECT emp_no  
FROM salaries 
WHERE salary >= 
(SELECT max(salary) - stddev(salary) FROM salaries WHERE to_date > curdate())
AND to_date > curdate(); # Assumes only current salaries.  83 rows. 


SELECT count(salary) from salaries WHERE to_date > curdate(); #historical: 2844047 current: 240124

-- 0.0346%
SELECT (Num_of_Employees / 
			(SELECT count(salary) from salaries WHERE to_date > curdate())) * 100 AS Percentage
FROM (SELECT count(emp_no) AS Num_of_Employees
		FROM (
		SELECT emp_no  
		FROM salaries 
		WHERE salary >= 
				(SELECT max(salary) - stddev(salary) FROM salaries WHERE to_date > curdate())

		AND to_date > curdate()
				) as t1
		) as t2;


-- BONUS

-- Find all the department names that currently have female managers.
/*
Development
Finance
Human Resources
Research
*/
SELECT dept_name FROM departments WHERE dept_no IN 
(SELECT dept_no FROM dept_manager WHERE emp_no IN
(SELECT emp_no FROM employees WHERE gender = 'F'
AND to_date > curdate())
) ;

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