USE albums_db;
# Selects albums_db as the database

DESCRIBE albums;
# Displays info on column names and corresponding attributes like data type and primary keys 

SELECT *
FROM albums;
# Displays all rows of all columns for table 'albums'. 31 rows total.

SELECT DISTINCT artist
FROM albums;
#Displays a total of 23 artists with unique names

DESCRIBE albums;
# id is the primary key for the albums table

SELECT *
FROM albums
WHERE release_date > 2000;
# Adele has the most recent release date at 2011

SELECT *
FROM albums
WHERE release_date < 1970;
# The Beatles have the oldest release date in 1967

SELECT * 
FROM albums 
ORDER BY release_date;
#Another way to do it, is to order according to release_date and choose the top and bottom release dates. 

SELECT name 
FROM albums 
WHERE artist = 'Pink Floyd';
# Finds all rows for artist Pink Floyd

SELECT release_date 
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
# This album was released in 1967. Had to use double quotes because an apostrophe can be found in the name.

SELECT genre, name
FROM albums
WHERE name = "Nevermind";
# Displays genre "Grunge, Alternative rock" for album name "Nevermind".

SELECT name, release_date 
FROM albums
WHERE release_date BETWEEN 1990 and 1999;
# Displays albums released in the 90's. 11 rows.

SELECT name, sales
FROM albums
WHERE sales < 20;
# Lists albums with less than 20 million in sales. 13 rows.

SELECT name, genre
FROM albums
WHERE genre = 'Rock';
# Lists albums in the Rock genre. Ignores albums in multiple genres. 

SELECT name, genre
FROM albums
WHERE genre LIKE '%Rock%';
# Alternatively you can use "LIKE" to find the word Rock in genre and then % to allow characters before and after. 
# capitalization does not make a difference in using 'LIKE'

