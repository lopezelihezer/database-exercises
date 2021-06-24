-- Where Clauses (Comments are placed below answers.)
USE employees;

-- Used employees database. 
DESCRIBE employees;

SELECT first_name 
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya');
/* 2. All current or previous employees with first names 
Irena, Vidya, or Maya using IN. # of records is 709
*/

SELECT first_name
FROM employees
WHERE first_name = 'Irena'
	OR	first_name = 'Vidya'
	OR		first_name = 'Maya';
	
/* 3. All current or previous employees with first names 
Irena, Vidya, or Maya using OR. # of records is 709. Matches Q2.
*/

SELECT first_name, gender
FROM employees
WHERE gender = 'M'
	AND (
			first_name = 'Irena'
	OR	first_name = 'Vidya'
	OR		first_name = 'Maya'
			);
			
/* 4. All current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. # of records 441.
*/

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%';

-- 5. Last names that start with "E". 7330 rows. 

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%'
	OR		last_name LIKE '%e';
	
-- 6. Last name starts or ends with "E". 30723 records. 23393 employees last names ends with "E" but does not start with "E". 

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E';

-- TEST
SELECT last_name
FROM employees
WHERE last_name LIKE '%E';

-- 7. Last name starts and ends with "E". 899 records. 24292 employee's last name end with E. 

SELECT * FROM employees
WHERE hire_date LIKE '199%';

-- 8. All current or previous employees hired in the 90's. 135214 records. 

SELECT * FROM employees
WHERE hire_date LIKE '%12-25';

-- 9. All current or previous employees born on Christmas. 789 records. 

SELECT * FROM employees
WHERE hire_date LIKE '199%'
	AND	hire_date LIKE '%12-25';
	
-- 10. All current or previous employees hired in the 90's and born on Christmas. 346 records. 

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%';

-- 11. All employees with a 'q' in their last name. 1873 records. 

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
	AND		last_name NOT LIKE '%qu%';
	
-- 12. All employees with a q in their last name but no 'qu'. 547 records. 

