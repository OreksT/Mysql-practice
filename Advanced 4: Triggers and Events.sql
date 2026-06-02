-- TRIGGERS AND EVENTS
-- A trigger is a block of codes that executes automatically when an event takes place on a specific table.
-- For example. A new employee is hired, their information and salary is put into the employee salary table and some people forget to put in
-- their other details in the employee demographics table. So what trigger does is that when the employee salary table is updated, it 
-- automatically updates in the employee demographics table. SO here, we write a trigger. 

Delimiter $$
CREATE TRIGGER Employee_Insertt
	AFTER INSERT ON employee_salary -- We said after because we're saying after the details have been entered in the emp_sal table. We could also do before
    FOR EACH ROW -- This means that the trigger is activated for each row that is inserted. SO we we have for new informations, the triggers is activated 4 times
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
Delimiter ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Taiwo', 'Orekoya', 'Entertainment staff', 100000 , NULL);







-- EVENTS
-- Events are similar to triggers. Triggers happen when an event takes place while an event takes place when  it's scheduled
-- It's useful in a lot of ways such as, you can pull data from a specific file path on a schedule. You can build reports and export it into
-- a file on a schedule. 
-- For example, the company decides to retire employees that over the age of 60. We can create an event that checks every day or month
-- When the event check and sees that there's anyone over the age of 60 already, it automatically deletes them from the table
-- This is what we do

Select *
From employee_demographics;
-- Here Jerry is over 60, so to eliminate him from the table, we go

Delimiter $$
Create Event Delete_Retirees
ON Schedule Every 30 second
Do
Begin
	Delete 
    From employee_demographics
    Where age >= 60;
End $$
Delimiter ;
-- When we run this we'll see that this event has been created. When we  run the employee demographics again, we'll find that Jerry
-- has been eliminated as he's the only that's turned 60 and above

Select *
From employee_demographics;

-- Make sure event scheduler is on and this is how to check below
SHOW VARIABLES LIKE 'EVENT%';




