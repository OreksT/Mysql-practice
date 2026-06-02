-- The 'Select Statement' is used to help filter or select actual columns

Select *
From employee_demographics;

-- OR

Select *
From parks_and_recreation.employee_demographics;

# A semi colon is needed at the end of each query because it tells us that we're at the end of the query, so if there's another query at 
-- the end SQL would be able to differentiate them

# PEMDAS is the order of operations for arithmetic or Math wthin MySQL
-- P- Parentheses (brackets)
-- E- Exponent
-- M- Multiplication
-- D- Division
-- A- Addition
-- S- Subtraction... Example below...

Select first_name,
Last_name,
birth_date,
age,
(age + 10) * 10 - 20
From employee_demographics;

# Distinct simply selects only the unique values within a column. Example below...
Select distinct gender
from employee_demographics;

Select distinct gender,
first_name
from employee_demographics
-- Here, there are no unique values in the first_name column. So, the query result shows every names in the coulmn
