-- Limit Exercises. Add the limit clause to our existing queries. 

-- 2. List the first 10 distinct last names sorted in descending order. 
USE employees;
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- 3. Employees hired in the 90's and born on Christmas. First 5 sorted by hire date and limit of 5. 
/* Employee names:
Alselm Cappello
Utz Mandell
Bouchung Schreiter
Baocai Kushner
Petter Stroustrup
*/
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5;

-- 4. 10th page of results, with 5 results per page means we have to skip the first 50 results using OFFSET. 
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 50;