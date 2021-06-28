-- Where Clauses 
-- Used employees database. 
USE employees;

DESCRIBE employees;

/* 2. All current or previous employees with first names 
Irena, Vidya, or Maya using IN. # of records is 709
*/
SELECT first_name 
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya');

/* 3. All current or previous employees with first names 
Irena, Vidya, or Maya using OR. # of records is 709. Matches Q2.
*/
SELECT first_name
FROM employees
WHERE first_name = 'Irena'
	OR	first_name = 'Vidya'
	OR		first_name = 'Maya';
	

/* 4. All current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. # of records 441.
*/
SELECT first_name, gender
FROM employees
WHERE gender = 'M'
	AND (
			first_name = 'Irena'
	OR	first_name = 'Vidya'
	OR		first_name = 'Maya'
			);
			

-- 5. Last names that start with "E". 7330 rows. 
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%';


-- 6. Last name starts or ends with "E". 30723 records. 23393 employees last names ends with "E" but does not start with "E". 
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%'
	OR		last_name LIKE '%e';
	
-- 7. Last name starts and ends with "E". 899 records. 24292 employee's last name end with E. 

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E';

-- TEST
SELECT last_name
FROM employees
WHERE last_name LIKE '%E';

-- 8. All current or previous employees hired in the 90's. 135214 records. 

SELECT * FROM employees
WHERE hire_date LIKE '199%';

-- 9. All current or previous employees born on Christmas. 789 records. 

SELECT * FROM employees
WHERE hire_date LIKE '%12-25';

-- 10. All current or previous employees hired in the 90's and born on Christmas. 346 records. 

SELECT * FROM employees
WHERE hire_date LIKE '199%'
	AND	hire_date LIKE '%12-25';
	
-- 11. All employees with a 'q' in their last name. 1873 records. 

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%';

-- 12. All employees with a q in their last name but no 'qu'. 547 records. 

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
	AND		last_name NOT LIKE '%qu%';
	



-- ORDER BY exercises.  
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
