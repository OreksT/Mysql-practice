-- The Having Clause usually comes after the Group By function. The Having Clause filters the aggregated function column 

Select gender, avg(age)
From employee_demographics
Where avg(age) >40
Group by gender;
#The query above is not going to work because if we're performing an aggregate function on gender, It can only occur after the 'group by' function groups
-- the rows together. Recall that we can only perform aggregate functions when rows have been grouped
-- Hence when we try to filter the avg(age) as in "Where avg(age) >40", the query will be invalid becuase the 'group by' function hasn't happened
-- which means the avg(age) column hasn't been created.

-- This is where the Having Clause comes in. Having clause comes after the group by funtion. After the group by function is run, then we can filter
-- based off of the aggregate function. Example below

Select gender, avg(age)
From employee_demographics
Group by gender
Having avg(age) > 40;
-- This gives us an output that contains only when the average age is greater than 40.


-- USING THE WHERE AND HAVING CLAUSE IN THE SAME QUERY

Select *
From employee_salary;
-- The office manager occupation appears twice in this table. So, to group the occupation row and run the aggregate function 'AVG' on sthe salaries
-- to get the avegrage salary, we go...

Select occupation, avg(salary)
FRom employee_salary
Group by occupation;
-- Here, the occupation row has been grouped, so, the office manager occupation now appears once and the avegrage salary of both office managers gotten.

-- Now, let's see people who are managers. Here, the 'where' function comes into play. We go...

Select occupation, avg(salary)
From employee_salary
Where occupation like '%manager%'
Group by Occupation;
-- This shows the average salaries for only the occupations that have 'manager' in them

-- Next, to look at where any occupation that has 'manager' earns above 75,000 on average. This is where 'Having' comes in. We say...
Select occupation, avg(salary)
From employee_salary
Where occupation like '%manager%'
Group by Occupation
Having avg(salary) > 75000
-- In this query, the where clause filters the occupation row, while the having clause filters at the aggregated function level.
-- Having clause works only for aggregated functions, after the group by functions runs
-- That is the difference between the 'Having clause' and the 'Where clause'

# In conclusion, the 'Having Clause' filters the aggregated function column
