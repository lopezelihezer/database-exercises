-- ORDER BY exercises. Did not copy contents from WHERE clause, because SQL ACE slows down significantly. 
USE employees;
DESCRIBE employees;

-- 2. All employees with first names 'Irena', 'Vidya', or 'Maya' ORDER BY first name. First row = Irena Reutenauer. Last row = Vidya Simmen
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;

-- 3. All employyes with first names 'Irena', 'Vidya', or 'Maya' ORDER BY first name and then last name. First row = Irena Acton. Last row = Vidya Zweizig

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- 4. All employees with first names 'Irena', 'Vidya', or 'Maya' ORDER BY last name and then first name. First row = Irena Acton. Last row = Maya Zyda. 
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- 5. All employees whose last name starts and ends with 'E'. ORDER BY employee number. # of employees = 899. 1st employee = 10021 Ramzi Erde. Last employee = 499648 Tadahiro Erde. 
SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no;

-- 6. All employees whose last name starts and ends with 'E'. ORDER BY hire date with newest employees listed first. # of employees = 899. Newest = Teiji Eldridge. Oldest = Sergi Erde. 

SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;

-- 7. Employees hired in the 90's and born on Christmas. ORDER BY oldest employee, who was hired last. # of employees = . Oldest employee who was hired last = Khun Bernini. Youngest employee who was hired first = Douadi Pettis. 
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND	birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC;
