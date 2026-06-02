 -- JOINS
 -- Joins allows you to combine two tables or more together if they have a common column. The column doesn't have to be the same name but there must be
 -- similar data within it that we can use.alter
 
 -- INNER JOIN, also known as JOIN,  OUTER JOINS, and SELF JOINS
 
 -- We'll be working with the employeedemographics and employeesalary tables in this series.
 Select *
 From employee_demographics;
 
 Select *
 From employee_salary;
 
-- In this case, the column name for both tables is exactly the same, and the data inside the columns is very similar.
-- We start with INNER JOIN, it is also known as the common JOIN and is the most simple JOIN as well 

-- An INNER JOIN returns rows that are the same in both columns from both tables. Example below.
 Select *
 From employee_demographics
 INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;
-- In the above query, we first selected everything in the employee_demographics table, then did an inner join with the employee salary table
-- The next step was to enter the keyword which indicated what column we're joining the two tables on (employee_id). Also indicating which employee_id
-- was for which table, as seen above, to avoid an error message.
-- The result shows the two tables combined together. Recall that an INNER JOIN only brings over the rows that have the same values in both columns that
-- we're tieing on. 
-- In the reslut of the above query, number 2 is missing in the emmployeeid columns.This is because the employee_id column in the employee salary table
-- has a 2 but the employeeid column in the employee demographics table doesn't and we have just said that an INNER JOIN only brings over the rows that
-- have the same values in both columns that we're  tieing on. Hence, the 2 in the enployee_id column of the employee salary table is left out.

-- Further more, to shorten the query above and make it look better, we can perform Aliasing. We go...
  Select *
 From employee_demographics AS dem
 INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
 -- Here, we have changed the names of the employee demographics and salary tables so when we're entering hte keyword, we replace them with the
 -- changed name, as seen above. This reduces the length of the query and makes it easier to read.
 
 -- Also still on INNER JOIN. Let's say we want to take just the employeeid, age and occupation columns, as in...
 Select employeeid, age, occupation;
-- When we run the full query, there's going to be an error message bacuse mySQL doesn't know which table's employeeid to use. So we have to choose
-- which table's employee ID to use. We can use the aliased names. We go...
SELECT sal.employee_id, age, occupation
FROM employee_demographics AS dem
 INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- When we run this, we're able to get the selected informations from both tables in our output without all the other informations. 
-- Note that we can use either the dem or sal tables to indicate if there are similar columns in both tables.
    
    
--   OUTER JOINS
-- In OUTER JOINS, we have LEFT JOINS/LEFT OUTER JOINS and RIGHT JOINS/RIGHT OUTER JOINS
-- A LEFT OUTER JOIN takes everything from the left table even if there's no match and then returns the matches in the right table
-- It is the exact opposite for a RIGHT OUTER JOIN. Example below... 
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- When we run the above query, the output shows everything from the left table and the only returns the matches in the right table.

-- A RIGHT OUTER JOIN,takes everything from the right table but if a particular column in the right table doesn't have a match in
-- the left table, the column will return as NULL in the left table. Example below...
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- Here, the left table doesn't have employeeid 2 which the right table has so the column returns as NULL.
-- Note: The FROM statement is our LEFT table while the table we're joining on is out RIGHT table.

--    SELF JOIN
-- A SELF JOIN is a JOIN where you tie a table to itself.
-- Let's say it's December. The department wants to do a gift exchange by assigning an employee to get a gift for another and they 
-- want to do it based on their employee ID, to determine which employee is assigned to another. We can simply do it  on MySQL.
-- We  can use either tables since they both have the employee ID column. But in this instance, we use the employee_salary table
SELECT *
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id +1 = emp2.employee_ID;
-- In the query above, we joined the employee_salary table to itself. Then we entered the keyword to know which table we're pulliing
-- from. Either from the left or right. We also has to distinguish between the two tabled, since it is the same table. So, we
-- aliased. (renamed both tables) as seen above. 
-- When it was run, we  got a one for one match since it was basically the same table.
-- What we then did next was to assign an employee ID to the next employee ID. That'll be who they are to get  gifts for. 
-- Simply put 'The next person above with an employee ID is who they're getting gifts from)
-- We added a '+1'. This simply means the employee_id on the right plus 1 will be equal to the employee_id on the right. And that
-- is who they're to get gifts for.

-- To simplify the above query and to include only the details needed in the output (employee_id, first_name and last_name), we go...
SELECT emp1.employee_ID AS emp_gifter,
emp1.first_name AS first_name_gifter,
emp1.last_name AS last_name_gifter,
emp2.employee_ID AS emp_receiver,
emp2.first_name AS first_name_receiver,
emp2.last_name AS last_name_receiver
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id +1 = emp2.employee_ID;
-- The output has been simplified


--   JOINING MULTIPLE TABLES TOGETHER (3 or more)
-- We're going to be joining the employee_demographics and Salary tables to the parks_departments table.
SELECT *
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id = emp2.employee_ID;
    
SELECT *
FROM parks_departments;
-- This table is a reference table. It is not a table that'll often be altered. It is there to know that "These are the departments
-- that we have, and these are their IDs"
-- Note that the salary table also has a dept_id column. So. what we're going to do is to join the dept_id in the salary table to
-- the  departnment_id in the parks_department table. We go...
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd 
	ON sal.dept_id = pd.department_id;
-- Note that we couldn't join the parks_department table to the employee_demograpgics cos they do not have a common column.
-- The parks_department table and employee_salary have the common columns (dept_id), that was why we could tie them together.
-- Also note that the column names don't have to be the same. As long as the values in the columns are similar, we can tie them together.

