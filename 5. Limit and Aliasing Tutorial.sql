 -- LIMIT
 -- Limit specifies how many row you want in your output. E.g
Select *
From employee_demographics
Limit 3;
-- If we run this query, it's only going to take the first three results in the table

# LIMIT can be combined with ORDER BY to make it more powerful. E.g. If we want to know thw three oldest employees, we say... 
Select *
From employee_demographics
Order by age DESC
Limit 3;
-- This shows the top 3 oldest people in descending order

# There's another interesting feature in LIMIT. It can be activated by using a comma. example below
Select *
From employee_demographics
Order by age DESC
Limit 3, 1;
-- What this means is that we're starting at position 3, which was Leslie, in the previous query and then we're going one row after
-- But because in the result there was no other row after the third row (Leslie), we try another example. 

-- Here we started from row 2 (Donna) and then we wanted to see the result of just one row after row 2. We go...
Select *
From employee_demographics
Order by age DESC
Limit 2, 1;
-- The result being Leslie, that is only the next row after row 2


-- ALIASING
-- Aliasing is simply a way to change the name of a column. E.g
Select gender, AVG(age)
From employee_demographics
Group by gender;

-- Now to rename the average age column, 'AS' is the key word. We go...
Select gender, AVG(age) AS avg_age
From employee_demographics
Group by gender;
-- The name of the column has been successfully changed and we can now use it anywhere. Example below

Select gender, AVG(age) AS avg_age
From employee_demographics
Group by gender
Having avg_age > 39;

-- Note that the 'AS' isn't necessary, it is already implied. Even if we get rid of it, we still get the same result