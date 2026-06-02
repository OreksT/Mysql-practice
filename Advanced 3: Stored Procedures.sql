-- STORED PROCEDURES
-- Stored procedure are ways to save SQL codes so they can be used over and over again. When we save them we can recall the stored procedures
-- and it's going to execute all the codes that we wrote withing the stored procedure.
-- It is useful for storing complex queries, simplifying repetitive codes and enhancing performance.

-- How to create a Stored Procedure... We'll start easy
Select *
From employee_salary
Where Salary >= 50000;
-- Now we want to save the code above in a stored procedure. All we need to do is to say...
CREATE PROCEDURE Large_Salaries() -- i.e we name the stored procedure as large salaries
Select *
From employee_salary
Where Salary >= 50000;
-- When we run this query above, the procedure is already stored. (Check 'tables' under parks amd recreation)

-- Now to call the already Stored Procudure all we simply do is say...
Call Large_Salaries();
-- To also call it we can just simply click on the little lightning bolt sign beside the 'Large_Salaries' under the parks and recreation 
-- table and we get the exact same output

-- There's so much more to do with Stored Procedures. We can have multiple queries within a stored procedure
-- Let's try to add another query to the one above
CREATE PROCEDURE Large_Salaries2() 
Select *
From employee_salary
Where Salary >= 50000;
Select *
From employee_salary
Where Salary >= 10000;

-- Now if we run this we're just gonna get an output, the queries would not have been stored and that's not what we want.
-- This is where a DELIMITER comes in. A Delimiter is used to identify the end of one query so two or more query don't get mixed up.
-- For example, we already know about the semi colon (;). Other commomnly used are // and $$. We'll be making use of $$ here
-- Now to insert a Delimiter into the query to make sure the two different queries get saved in the stored procedures, we go...

Delimiter $$
CREATE PROCEDURE Large_Salaries3() -- What's happening here is that we're changing the delimiter here to the dollar sign
Begin
	Select *
	From employee_salary
	Where Salary >= 50000;
	Select *
	From employee_salary
	Where Salary >= 10000;
End $$
Delimiter ;

-- Now when we run this the whole query will be saved in one stored procudure.
-- The 'End $$' signifies the end of the query and it's also best practice to chance the delimiter back to the semi colon after the query
-- if not we have to continue with the dollar sign

-- Now to call the stored procedure, we say...
Call Large_Salaries3();
-- Now we have the two different queries under one stored procedure
-- If we go under the park and recreation table under the and right click the Large_Salaries3, and futher click on 'Alter Stored Procedure'
-- We'll see both queries stored under one proceudre. 

-- Another way to add queries to the stored procedures instead of writting it all out is, go to the parks and recreation table,
-- right click 'stored procedures and click 'create stored procedure'.
-- We'll use the same codes in the above query. When we do this, we insert the query and click 'apply', when we click apply, it generates
-- a script. In the script we'll see something like "drop procedure if exists".
-- It is important to write it out sometimes when writing our own code, so that if we have already created a stored procedure with the 
-- same name earlier, it replaces it.

-- When we click apply, it goes ahead and executes the statement. We'll realize that it looks exaclty like the Large_salries3 that we 
-- created earlier

-- Next is PARAMETER
-- Parameters are variables that are passed as inputs into a stored procedure and they allow the stored procedure to accept the input value
-- and place it into our code

Delimiter $$
CREATE PROCEDURE Large_Salaries4()
Begin
	Select *
	From employee_salary
	Where Salary >= 50000; 
End $$
Delimiter ;

Call Large_Salaries4(1)

-- Let's say for example we have already created this stored procedure and we want to call a particular employee Id from the table and
-- we want to retrieve their salary. When we call it, we're going to pass in 1 into the parenthesis, which is Leslie Knope, and then we
-- want the salary to be the output.
-- We then select salary from the employee salary table but how do we know that the '1' is the person we're looking for is that when we're 
-- creating the procedure, we indicate it in the parenthesis at the top. It is what tells the store procedure to accept the input value 
-- when we call it. After we name the parameter the the top which in 'employee id', we then go ahead and indicate the data type
-- This is necessary, so that when we're calling, we let the stored proedure know that the data we're calling is to be an Integer

Delimiter $$
CREATE PROCEDURE Large_Salaries4(employee_id_param INT)
Begin
	Select salary
	From employee_salary
    Where employee_id_param = employee_id
    ;
End $$
Delimiter ;
-- The first employee ID is indicating that that is what should be called when calling, the 2nd indicates the employeeid from the 
-- employee salary table

-- Now the stored procedure has been created. Now when we want to call it 
Call Large_Salaries4(1);
