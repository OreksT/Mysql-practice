-- Temporary Tables
-- They are tables that are only visible to the session they're created in. If you create a Temporary table and exit mysql, when you come
-- back, it's not gonna be there anymore. 
-- One of their main use is to store intermediate results for complex queries, similar to CTEs
-- They are also used to manipulate data before storing them into a more permanent table

-- There are two ways to create a Temp table.
-- First is...

CREATE TEMPORARY TABLE Temp_Tablee
(First_name varchar(50),
Last_name varchar(50),
Favortie_movie varchar (100)
);
-- Not the table has been created
-- Note if we take out the 'Temporary' it creates a Permanent table in the park and recreation database but we don't want that
-- To see the created table, we go...
Select *
from temp_tablee;
-- Here we can we can see the already created table. We can then go ahead and insert our data into the table created 

INSERT INTO Temp_Tablee
Values('Taiwo', 'Orekoya', 'The Secret Soldiers of Benghazi');
-- After inserting the data, we can then go ahead and rerun the query and the data will be in the table already.
Select *
from temp_tablee;
-- This is the first way to create a temporary table.

-- The other one, which is most commonly used...
Select *
From employee_salary;
-- Assume we need just a part of this table, not every info in it, for example we want the information of those that earn 50000 and above
-- So we want to create a temporary table for those who earn 50,000 or above, we go... 

CREATE TEMPORARY TABLE Salary_over_50000
Select *
From employee_salary
Where salary >= 50000;
-- Here we're creating a temporary table based off of an already existing table.
-- Now the table has been created we can now go ahead and extract the information that we need. We go..

Select *
From Salary_over_50000;
-- This returns the information of everyone that earns 50k and above

-- Temporary tables last only as long as you're within that session, even if you create a new window and run the query, we're still going
-- to get the table BUT if we exit mysql totally and come back, the table wouldn't exist anymore













