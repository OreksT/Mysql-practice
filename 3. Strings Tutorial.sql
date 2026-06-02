-- STRING FUNCTIONS
-- These are functions within MYSQL that'll help us use strings
-- There are a number of them and they all have different use cases

-- First is LENGTH. example below
SELECT LENGTH('skyfall');
-- All this does is that it tells us how long the characters in the string (skyfall) is
-- To do this for the employee demographics table, we go...

SELECT first_name, LENGTH(first_name)
FROM employee_demographics;
-- This shows us all the length of the characters in the first names.

-- We can also orderby and go... 
SELECT first_name, LENGTH(first_name)
FROM employee_demographics
Order by 2;
-- This arranges the second column/2 i.e LENGTH(first_name) in ascending order 


-- NEXT IS UPPER/LOWER. Example below
SELECT UPPER('sky');
SELECT LOWER('sky');
-- All these do is change the string either to all upper case or all lower case. To perform a usecase, we go...
SELECT first_name, UPPER(first_name)
FROM employee_demographics;
-- Same applies to Lower.


-- Next is TRIM. We have TRIM, LEFT TRIM AND RIGHT TRIM.
-- Trim is simply going to take the excess space at the beginning or at the end and get rid of it. Example below...
SELECT ('                   sky         ');
-- When we run this query, the excess spaces at the biginning and at the end are going to appear in the result. To get rid of them, we go...
SELECT TRIM('                   sky         ');
-- Space is eliminated.

 -- Now, to get rid of the excess space at the left hand side/beginning, we go...
 SELECT LTRIM('                   sky         ');
 
 -- To get rid of the excess space on the right hand side/end, we go...
 SELECT RTRIM('                   sky         ');
 
 
 -- Next is SUBSTRINGS. Under SUBSTRINGS, we have the LEFT and RIGHT. Usecase example.
 SELECT first_name, LEFT(first_name)
 FROM employee_demographics;
 -- The above query is going to give an error message because, there is a value that is supposed to be there that is isn't.
 -- The correct query should be
 
 SELECT first_name, LEFT(first_name, 4)
  FROM employee_demographics;
  -- What this means is that you're specifying how many characters from the left that you need, in the first_name column
  
-- To do this for both the left and right sides, we go...
SELECT first_name,
 LEFT(first_name, 4),
  RIGHT(first_name, 4)
   FROM employee_demographics;
-- This shows the first four characters from the left and the last four characters from the right.


# SUBSTRINGS
-- Substrings allow us to chose what position in a particular value we want to start from and then input how many characters we want, after. e.g
SELECT first_name,
  LEFT(first_name, 4),
  RIGHT(first_name, 4),
   SUBSTRING(first_name, 3,2)
    FROM employee_demographics;
-- In the above query, the substrings allows us to start from the third position/third characters in the first_name column and also allows
-- to choose how many more characters we want to run, that is in this case, the two characters starting from the third

-- Let's say for example, we want to find the month that everyone was born in, we can run a SUBSTRING that goes like this 
SELECT first_name,
  LEFT(first_name, 4),
  RIGHT(first_name, 4),
   SUBSTRING(first_name, 3,2),
	birth_date
    FROM employee_demographics;
-- When we run this query, we see that the birth month in the birthdate column starts at position 6, so we go
-- Note that the 2 in the birthdate substring indicates that we're taking the next two characters/positions starting from the 6th position
SELECT first_name,
  LEFT(first_name, 4),
  RIGHT(first_name, 4),
   SUBSTRING(first_name, 3,2),
	substring(birth_date, 6,2) AS Birth_Month
    FROM employee_demographics;
-- The birthmonth for each employee in the employee demographic has been identified

-- Next is REPLACE. This replaces a specific character with a character that you want. example below

Select first_name, Replace(first_name, 'a', 'z')
FROM employee_demographics;
-- What this query does is that in the firstname column, it replaces every lowercase a with a lowercase z as in Mark, Donna and Craig.
-- Replace basically specifies what we want to replace and what we want to replace it with.

-- LOCATE

Select LOCATE('w', 'Taiwo');
-- What locate does is that it tells us what position a particular character were looking for is in
-- In the above query, it tell us what position W is in the name Taiwo

Select first_name, LOCATE('An', first_name)
FROM employee_demographics;
-- Here this query shows us the firstnames that have an An in them

-- CONCATENATION
-- Concat helps to join multiple columns into one single column
Select first_name, last_name,
CONCAT(first_name, last_name)
FROM employee_demographics;
-- Too add space in between the joined columms, we can go 
Select first_name, last_name,
CONCAT(first_name, ' ',last_name) AS Full_name
FROM employee_demographics;
-- Here it looks more organized and we have also renamed the concatenated columns into Full name.