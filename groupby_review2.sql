-- GRoup BY review

USE titanic_db;

-- Returns 891 records.
SELECT *
FROM passengers;

-- Check out my data types.
DESCRIBE passengers;

-- What does a single row or record represent in the passengers table?
SELECT *
FROM passengers
LIMIT 10;

-- Return only the unique values from the class column. Now what does a single row represent? Our result set contains much less detail. Zoom out.
-- Returns 3 rows.
SELECT
    DISTINCT class
FROM passengers;

-- The GROUP BY clause returns unique values in ascending order by default.
SELECT
    class
FROM passengers
GROUP BY class;

-- If I want to reverse the order of the values, I can use the `DESC` keyword just like with ORDER BY.
SELECT
    class
FROM passengers
GROUP BY class DESC;

-- Return only the unique values from the sex column.
SELECT
    DISTINCT sex
FROM passengers;

-- The GROUP BY clause returns unique values in ascending order by default.
SELECT
    sex
FROM passengers
GROUP BY sex;

-- I can select multiple columns to return all of the unique combinations of values in the selected rows.
SELECT
    sex,
    class
FROM passengers
GROUP BY sex, class;

SELECT
    sex,
    COUNT(*) as number_of_passengers
FROM passengers
GROUP BY sex;

-- -------------------------

-- The * returns the count of non-NULL values in the column; I can use the specific column name if I'm not concerned about NULL values.
SELECT
    sex,
    COUNT(sex) as number_of_passengers
FROM passengers
GROUP BY sex;

-- Check out the difference. Just be aware of this difference when you decide what you pass to the COUNT function.
SELECT 
    deck,
    COUNT(deck) as 'non-null-values',
    COUNT(*) as 'all_rows'
FROM passengers
GROUP BY deck;

-- What if we want to look at the number of rows for each unique combination of values in multiple columns?
SELECT
    sex,
    class,
    COUNT(*) as number_of_passengers
FROM passengers
GROUP BY sex, class;

-- Let's choose another dimension and a couple of different measures to further analyze our data. I'm formatting using the ROUND() function.
SELECT
    sex,
    ROUND(AVG(fare), 2) AS average_fare_paid,
    MIN(fare) AS minimum_fare_paid,
    ROUND(MAX(fare), 2) AS maximum_fare_paid,
    ROUND(STDDEV(fare), 2) AS standard_deviation_in_fare
FROM passengers
GROUP BY sex;

-- Let's drill down one more layer by adding the sub-dimension class. I'm basically creating a table of summary statistics for my table.
SELECT
    sex,
    class,
    ROUND(AVG(fare), 2) AS average_fare_paid,
    ROUND(MIN(fare), 2) AS minimum_fare_paid,
    ROUND(MAX(fare), 2) AS maximum_fare_paid,
    ROUND(STDDEV(fare), 2) AS standard_deviation_in_fare
FROM passengers
GROUP BY sex, class;

SELECT
		sex,
		fare 
		FROM passengers
		GROUP BY sex, fare
		ORDER BY fare DESC;