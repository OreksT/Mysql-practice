-- WINDOW FUNCTIONS

-- They are similar to Group By only that they don't roll everything up into one row when grouping.
-- They allow us to look at a partition or a group but they keep their unique rows in the out put. We'll be looking at three things 
-- under the Window Function
-- 1. Row Numbers
-- 2. Rank
-- 3. Dense Rank

-- Before going fully into Window Functions, we're going to look at a Group By query so we can compare them

Select gender, Avg(salary) as Avg_Salary
From employee_demographics as dem
	JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id
Group By gender;
-- In the query above, we can see that both genders were pulled up into one row and the average salary for both genders were determined
-- Now to do something similar but with a Windows Function

Select gender, Avg(salary) Over()
From employee_demographics as dem
	JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id;
-- Compared to a Group By function where the genders are rolled up into distinct rows, in the Windows Function, the rows stay independent
-- we're looking at the average salary of everybody instead on grouping them into genders as Group By does. What we can do instead is to 
-- do a partition as seen below

Select gender, Avg(salary) Over(partition by gender) as avg_salary
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- Unlike the group by where everything is rolled up into one row, the above does the calculation based on each row in the column
-- So it separates each female from each male, instead of rolling both genders up into two rows
-- If we compare this query to the group by query, the average is the same for both gender only that this has the average salary on each
-- individual rows instead of rolling them up into one.
-- This is useful because in a situation where we want additional information for each row, we can easily add the information to the query
-- and the average salary coulmn remains the same. Unlike in the group by where the average salary for each row would be different because
-- we're going to have to group by the additional informations which will mean that average salary column will be determined by the unique
-- values of the columns added, Example below

Select dem.first_name, dem.last_name,gender, Avg(salary) as Avg_Salary
From employee_demographics as dem
	JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id
Group By dem.first_name, dem.last_name,gender;
-- Here the average salary for each row differs because we're grouping based on the unique values in the colums added. that is we're 
-- determining the average salary of each employee individually

Select dem.first_name, dem.last_name,gender, Avg(salary) Over(partition by gender) as avg_salary
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
        
-- Another use of the Windows Function is SUM as shown below
Select dem.first_name, dem.last_name,gender,
Sum(salary) Over(partition by gender) as avg_salary
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- This shows us the sum of the total salary earned my each gender. We cam also perform what we call a Rolling Total on this
-- What a Rolling Total does is that it starts at a particular row and adds on values from subsequent rows based on out partition, to 
-- arrive as a total. Example show below, to make this clearer, we can add the salary column

Select dem.first_name, dem.last_name,gender, salary,
Sum(salary) Over(partition by gender Order By dem.employee_id) as Rolling_Total
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- What this does is that it first partitions based off of genders after they're separate, it the takes the salary of the first employee
-- then add the salary of the next employee to that of the first, then the salary of the next is alow added to the total of the first two
-- and it keeps adding up like that until it gets to the last employee in the gender, then it starts the same for the next gender

-- Now to ROW NUMBER
Select dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER() -- We're just going to do it based on everything for the purpose of this lecture
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- Row Number simply adds a number to each row, just like an employee ID, giving each row it's unique value
-- We can also do a Row Number and partition based on the gender as seen below
Select dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender) 
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- Here the row number is assigned based on the partition that we have run, so a row number is assigned to the females first to the last 
-- female and then it starts again from the first male to the last. We can also decide to add a row number based on the salary either
-- from the higest to the loswest or vice versa for each gender that we're partitioning by instead of just leaving it scattered. 
-- We run an Order By. We go...

Select dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender Order By salary desc) 
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;

-- RANK. Rank just gives as offical rank to rows. We can also rename the new columns as seen below

Select dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender order by salary desc) AS row_num,
Rank() OVER(partition by gender order by salary desc) as rank_num
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- What this does is that it gives a rank to the columns just like the row number but when it notices a duplicate in the coulmn that we
-- ordered by, it gives them the same rank but then the next number is not going to be the next number numerically, its going to be
-- the next number based on the position on the row

-- DENSE RANK
Select dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender order by salary desc) AS row_num,
Rank() OVER(partition by gender order by salary desc) as rank_num,
Dense_Rank() OVER(partition by gender order by salary desc) as denserank_num
From employee_demographics as dem
	JOIN employee_salary as sal 
		ON dem.employee_id = sal.employee_id;
-- Dense Rank just like the usual Rank gives the same rank if there's a duplicate based on the column that we ordered by but where it's
-- different is when is the next rank is assigned numerically instead of positionally like the normal Rank
