 -- GROUP BY

Select *
From employee_demographics;

#Group By in MySQL groups together rows that have the same values in the specified columns that you're grouping on.
#When you group these rows together, you can run something called an 'Aggregate Function; on them. Aggregate funtion includes AVG, MAX, MIN, and COUNT 

Select gender
From employee_demographics
group by gender;
-- This shows that there are only two groups of gender
-- Now to run an aggregate function, we go...

Select gender, AVG(age)
From employee_demographics
group by gender;
# This shows the average age of the two groups of gender


Select *
From employee_salary;

-- Now, we're going to group on occupation

Select Occupation
From employee_salary
Group by occupation;
-- Note that the ofifce manager appears once becuase the office manager row appears twice and they have now been grouped into one row
-- If we therefore group by occupation and salary, the office manager role appears twice back, as they both hav different salaries.
-- If they had the same salary, it would've been grouped into one row. Examples shown below

Select Occupation, salary
From employee_salary
Group by occupation, salary;

# Now back to grouping by gender. We're going to perform the aggregtae funtions MAX and MIN and AVG examples below
Select gender, AVG(age), MAX(age)
From employee_demographics
group by gender;
-- This shows the average and maximum ages for the males and females

Select gender, AVG(age), Max(age), MIN(age)
From employee_demographics
Group by Gender;
-- This shows the average, maximum, and minimum ages for each groups of gender

#The COUNT simply counts the number of rows in the age column
Select gender, COUNT(age)
From employee_demographics
group by gender;
-- This is simply telling us the count of how many values are in the age columns for each groups of gender


# ORDER BY
SELECT *
From employee_demographics;

# Order by sorts results either in ascending or descending order e.g

SELECT *
From employee_demographics
Order by first_name;
-- This is in ascending order (ASC) by default as we can see that the first names run from letter A to T.
-- You can choose to add (ASC). as in "Order by first_name ASC".You would still get the same resuslt.

# For descending order (DESC), we go...
SELECT *
From employee_demographics
Order by First_name DESC;
-- The first names run from T to A

# Now to group by gender and age. 
SELECT *
From employee_demographics
Order by gender, age;
-- Here the female gender comes first cos the letter F comes before M. Also in the female gender, the ages go from the smallest to the highest
-- Likewise the male gender. Because this by default is in 'ASC'

-- To run it in 'DSC',... We can run it for either of them. It doesnt have to be both. In this case, we run it for both
SELECT *
From employee_demographics
Order by gender DESC, age DESC;

-- Lastly, we don't have to use the column name, we can simply use the number, e.g the age and gender column are the 4th and 5th colum
-- so we can go
SELECT *
From employee_demographics
Order by 4, 5;
-- We still get the same result because the numbers represent the position on the column in the table. This is not really recommended though
