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

-- BONUS

-- Find all the department names that currently have female managers.

-- Find the first and last name of the employee with the highest salary.

-- Find the department name that the employee with the highest salary works in.