-- The 'Where Clause' is used to help filter out records or rows of data

Select *
From employee_salary
Where first_name = 'April';
# The = sign is called a comparison operator. There are others such as <, >, <=, >=...

Select *
From employee_salary
Where Salary >= 50000;

Select *
From employee_demographics
Where gender = 'female';

Select *
From employee_demographics
Where gender != 'female';
# The ! sign is another comparison operator, in the example above, it mean where the gender is not equal to female that is !='female'

Select *
From employee_demographics
Where birth_date > '1985-01-01';

# LOGICAL OPERATORS in the WHERE CLAUSE: AND, OR, NOT

Select *
From employee_demographics
Where birth_date > '1985-01-01'
AND Gender = 'Male';
-- This implies that we're looking for only males born after 1st of January, 1985.

Select *
From employee_demographics
Where birth_date > '1985-01-01'
OR Gender = 'Male';
-- This implies that we're looking for either male or female born after said date or anyone whose gender is male

Select *
From employee_demographics
Where birth_date > '1985-01-01'
OR NOT Gender = 'Male';
-- This implies that we're looking for anyone born after said date or anyone that is not a male. This means that we're also looking for 
-- females born before the date (females born before the date will appear)

Select *
From employee_demographics
WHERE (first_name = 'Donna' AND age = 46) Or Age > 46;
-- Here, we're looking for anyone whose first_name is Donna and their age is 46, or anyone at all whose age is grater than 46


# The Like Statement. This helps look for specific patterns.
# You can add two special characters within the like statement. They are '%' and "_"
# The '%' means anything while the '_' means a specific value

# For the %.
#  If the % comes at the end, it means we're looking for first names that start with A.
Select *
From employee_demographics
WHERE first_name like 'a%';

# If the % come at the beginning and at the end, it means we're looking for first names that have A anywhere in it
Select *
From employee_demographics
WHERE first_name like '%a%';

# If the % comes at the beginning, it means we're looking for first names that end with A.
Select *
From employee_demographics
WHERE first_name like '%a';

# For  the '_'
-- If for example you pick a name that starts with an A and use two __ e.g 'A__". It means you're looking for a first name that starts
-- with an A but has two other letters or characters
Select *
From employee_demographics
Where first_name like 'A__';  -- Here, only Ann appears

-- If it is A and three ___ e.g 'A___". It means you're looking for a first name that starts with an A but has three other letters or characters. Example below
Select *
From employee_demographics
Where first_name like 'A___';


# Now if you add a '%' after the three '_'as in 'A___%', this means the first name starts with an A, has three other letters, and has another letter.
-- E.g. April starts with an A, has three characters/letters after the A, but also has another letter/character which is L. Example below
Select *
From employee_demographics
Where first_name like 'A___%';

# This can also be used for birth_date
Select *
From employee_demographics
Where birth_date like '1989%'
-- This means that we're looking for birth dates that have '1989' anywhere in them

#In conclusion, the LIKE statement helps looks a for a specific sequence within a column that you can search for. It doesn't have to be an exact match,
# as long has it has the specified sequence that you've put anywhere in the cell or column