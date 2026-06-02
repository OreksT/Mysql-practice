--    UNION
-- A union is used to combine rows of data from different tables or the same tables together.
-- This is done by taking a select statement and using a union to join it with another select statement. Example below

Select age, gender
From employee_demographics
UNION
Select first_name, last_name
From employee_salary;
-- This query combines the rows of the age and gender columns in the employee_demograpghics table to the rows of the first_name and last_name columns
 -- in the employee_salary table.
 -- This usually doesn't go with every data, as it doesn't make sense to combine first_name and last_name  with age and gender. We have to keep the data
 -- the same. We can say... 

Select first_name, last_name
From employee_demographics
UNION
Select first_name, last_name
From employee_salary;
-- Here, the UNION is by default 'UNION DISTINCT' and remeber that distinct is only going to take unique values. So the names that are in both
-- the demographics and salary tables are combined into one row.
-- If we want to show all of them without the distinct function, we use the 'UNION ALL'. We go...

Select first_name, last_name
From employee_demographics
UNION ALL
Select first_name, last_name
From employee_salary;
-- Here, all the names that appear pn both tables appear.

-- GOING INTO A USE CASE
Select first_name, last_name, 'Old' AS Label
From employee_demographics
Where age >50;
-- Here, Jerry is the only employee greater than 50 years, so we label them as old
-- So, the parks department is trying to cut down their budget, they're looking for old employees to push out
-- They are also looking for highly paid employees to reduce their pay or lay off too. 

-- In the query above we identified someone that is old already. So, in the same query, let's identify someone that is "highly -paid". We go...
Select first_name, last_name, 'Old' AS Label
From employee_demographics
Where age >50
Union
Select first_name, last_name, 'Highly Paid Employee' AS Label
From employee_salary
Where salary >70000;
-- Here, we have been able to identify the highly paid and old employees who arer likely to be pushed out.

-- Let's assume the "Old" age is those > 40 years and let's also differentiate their gender, to know the "old male" and "old female". We go...

Select first_name, last_name, 'Old Male' AS Label
From employee_demographics
Where age > 40 and Gender = 'Male'
Union
Select first_name, last_name, 'Old Female' AS Label
From employee_demographics
Where age >40 and Gender = 'Female'
Union
Select first_name, last_name, 'Highly Paid Employee' AS Label
From employee_salary
Where salary >70000;
-- With this query, we've been able to identify the old males and females, and the highly paid employees.
-- Notice that Leslie Knope and Chris Traeger appear twice as both old male and female and also highly paid employees.
-- To make sure they're not scattered and are easily seen, we run an Order By...
Select first_name, last_name, 'Old Male' AS Label
From employee_demographics
Where age > 40 and Gender = 'Male'
Union
Select first_name, last_name, 'Old Female' AS Label
From employee_demographics
Where age >40 and Gender = 'Female'
Union
Select first_name, last_name, 'Highly Paid Employee' AS Label
From employee_salary
Where salary >70000
Order by first_name, last_name;

-- In colclusion, we can combine as many select statements as possible together using a Union











