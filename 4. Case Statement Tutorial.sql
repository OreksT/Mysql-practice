-- CASE STATEMENTS
-- A Case Statement helps to add logic to a Select Statement. Example below
Select first_name, 
last_name,
age,
gender,
CASE
	When age <= 30 THEN 'Young'
    When age Between 31 AND 50 THEN 'Old'
    When age >= 50 THEN 'Gods calling'
End as Age_Bracket
From employee_demographics;

-- In a Case Statement, you can add multiple WHEN statements. After END, as was used to Alliase the column.

-- In the next example, the company decides to offer salary raises and give bonuses to their employees at the end of the year
-- and these are the conditions involved.
-- Any employee that earns below 50,000 gets a 5% raise
-- Any employee that earns above 50,000 gets a 7% raise
-- Employess in the Finance department earn a 10% bonus
-- I.e < 50,000 = 5% raise
--	   > 50,000 = 7% raise
--     Finance Department = 10% bonus.
-- So we go...

Select first_name, last_name, occupation, salary,
CASE
	When salary < 50000 THEN Salary + (salary * 0.05)
    When Salary > 50000 THEN Salary + (salary * 0.07)
END as New_Salary
From employee_salary;
-- When this query is run, we see the salary raises for employees that earn below 50,000 and above 50,000 but not raises for the 
-- employees that earn exactly 50,000 but that's the rule.
-- A shorter way to calculate the salary riase would be to just say salary * 1.05 for example. This is simply multiplying the bracket first
-- then adding it to 'salary +' which is outside the bracket

-- Now to determine the raise for those in the Finace department, we first have to identify those in the department.
-- The employee salary table already has an employee ID column, so we just need to see under which department each ID falls under
-- in the Park Department table. So we run the parks_departments.
 Select *
 From Parks_Departments;
 -- From the above, we can see that any employee with ID 6 is in the finance department, so we can go ahead and calculate their bonus.

Select first_name, last_name, occupation, salary,
CASE
	When salary < 50000 THEN Salary * 1.05
    When Salary > 50000 THEN Salary * 1.07
    ELSE 0
END as New_Salary,
CASE
	When dept_id = 6 THEN Salary * .10
    ELSE 0
END AS Bonus
From employee_salary;

-- We have the salary raises and the bonuses. ELSE was introduced to get rid of the nulls and replace them with number
-- to make it more organized