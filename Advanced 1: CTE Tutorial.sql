-- CTEs In MySQL
-- CTE stands for Common Table Expression. They allow us to define a subquery block that we can then reference within the main query
-- It's similar to a Subquery where we have a query within a query but in CTE, we're going to name the subqery block and make it more
-- standardized compared to a SUbquery

-- The basics of writing a CTE.
-- NOTE that the keyword to define a CTE is WITH
-- CTEs can only be used once, immediately after they're created

WITH  CTE_Example AS
(
Select gender, Avg(salary), Max(salary), Min(Salary), Count(Salary)
From employee_demographics as Dem
Join employee_salary as Sal
	ON dem.employee_id = sal.employee_id
Group by gender
)
Select *
From CTE_Example;
-- This is just like we're writing a subquery and then withing the subquery we're builing a little temporary table and then we can query
-- off of it below
-- We can decide to select one item from the CTE to run, in this case we chose Max(salary). we can either rename or use the backtick,
-- which indicates that it is a table we created and not a table already in the data base

WITH  CTE_Example AS
(
Select gender, Avg(salary), Max(salary), Min(Salary), Count(Salary)
From employee_demographics as Dem
Join employee_salary as Sal
	ON dem.employee_id = sal.employee_id
Group by gender
)
Select avg(`avg(salary)`)
From CTE_Example;
-- We can wither do this or just decide to name the temporary tables which makes it easier, as seen below

WITH  CTE_Example AS
(
Select gender, Avg(salary) avg_sal, Max(salary) max_sal, Min(Salary) min_sal, Count(Salary) count_sal
From employee_demographics as Dem
Join employee_salary as Sal
	ON dem.employee_id = sal.employee_id
Group by gender
)
Select avg(avg_sal)
From CTE_Example;
-- The output are going to be the same. That is the avarage of the average salary of both males and females
-- The purpose of the CTE is to be able to perform advanced calculations. Something that can't be done withing just one query. Another is
-- the readability. We can write the same query using the subquery but it'll look less organized

-- You can create multiple CTEs withing one query. Or where we have to join multiple complex queries together, we can do it with a CTE

WITH CTE_Example AS
(
Select employee_id, gender, birth_date
From employee_demographics
Where birth_date > '1985-01-01'
),
CTE_Example2 AS
(
Select employee_id, salary
From employee_salary
Where salary > 50000
)
Select *
From CTE_Example
Join CTE_Example2
		ON CTE_Example.employee_id = CTE_Example2.employee_id;


-- Lastly as we did in one of the queries above (which will be shown below) where we alliased the column names, we can actually do it
-- in a more simple way
-- We can open a parenthesis beside the CTE and rename them from there. Example below 

WITH  CTE_Example (Gender, Avg_Sal, Max_Sal, Min_Sal, Counr_Sal) AS
(
Select gender, Avg(salary), Max(salary), Min(Salary), Count(Salary)
From employee_demographics as Dem
Join employee_salary as Sal
	ON dem.employee_id = sal.employee_id
Group by gender
)
Select *
From CTE_Example;
-- We can see that the columns are already renamed
