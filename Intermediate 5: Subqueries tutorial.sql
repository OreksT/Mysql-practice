-- SUBQUERIES
-- Subquery is simply a query within another query. There are different variations to use the Subquery. In this lesson, we're going to be
-- consdidering the Where Caluse, the Select Statement and the From Statement.

Select *
From employee_demographics;

-- Now we want to identify employees who work in the actual Park and Recreation department using their emplyee ID
-- If we recollect that in the Parks department table, the Parks and Recreation department carries dept ID 1 as seen below
Select *
From parks_departments;

-- So to determine the employees in the department using their dept_ID, we can decide to JOIN all the tables together or simply use a 
-- Subquery which makes it easier. We can therefore say...alter

Select *
From employee_demographics
Where employee_id IN
					(Select employee_id
                     From employee_salary
                     Where dept_id = 1);
-- Now when we run the subquery alone, that's the lower query, we get a list of the employee ID in the epmployee salary table that fall
-- under the dept ID 1 which is the Park and Recreation department. Now what the full query does is that now that we've determined the 
-- employee IDs that fall under the Parks and Recreation dept in the Employee Salary table, we try and match them with the employee IDS 
-- in the Employee Demographics table. There, we have the full details of only employees in the Parks and Recreation department.

-- Up next is how to use Subqueries in a Select Statement. We'll be using the Salary Table
Select *
From employee_salary;
-- For instance, we want to determine the overall average salary for the employees

Select first_name, salary, avg(salary)
From employee_salary
Group by first_name, salary;

-- When we run this we don't get the overall average salary, because what we is to be able to compare who earns above or below the average
-- This is where a subquery comes in. We go...

Select first_name, salary,
		(Select avg(salary)
		From employee_salary)
From employee_salary;
-- Now we have been able to determine the overall average and we can now compare who earns above or below average

-- Lastly is how to use a Subquery in the From Statement
Select *
From employee_demographics;
-- Here we're goning to do a Group By based on gender and add some aggregated function. e.g below

Select gender, avg(age), MAX(age), Min(age), Count(age)
From employee_demographics
Group by gender; 
-- In this query, we have determine the average age of both genders that we grouped by and also min, max and the total count of the ages

-- Now if we want to determine the average of the average column, the maximum column, the minimum age column or the count age column,
-- a Subquery is going to make that possible
Select gender, avg(`avg(age)`), max(`MAX(age)`), Min(`Min(age)`), count(`Count(age)`)
From
		(Select gender, avg(age), MAX(age), Min(age), Count(age)
From employee_demographics
Group by gender) AS Aggregaetd_Table
Group by gender;
-- When we run this, it's not going to give us exactly what we need because we're still grouping on gernder and what we want is to find the
-- average of both genders put together, so we eliminate the gender
-- The backtick was also necessary. It helped to indicate that that is the name of the column now and it's not just an aggregation.

Select avg(`avg(age)`), max(`MAX(age)`), Min(`Min(age)`), count(`Count(age)`)
From
		(Select gender, avg(age), MAX(age), Min(age), Count(age)
From employee_demographics
Group by gender) AS Aggregaetd_Table;
-- Now we have the average of the columns.
-- We can go ahead and rename then, to make it more organized and with this we don't have to use the backtick anymore

Select avg(avg_age), avg(max_age), avg(min_age), avg(count_age)
From
		(Select avg(age) AS avg_age,
		 MAX(age) AS max_age, 
         Min(age) AS min_age, 
         Count(age) AS count_age
From employee_demographics
Group by gender) AS Aggregaetd_Table;





