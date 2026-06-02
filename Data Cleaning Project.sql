-- PROJECT: DATA CLEANING IN MYSQL

-- Data cleaning simply involves getting data in a more usable format. Here we fix a lot of the issues in the raw data so going forward the
-- data is actually useful and there aren't issues with it.

-- First we create a database. After doing this, we then go to tables, under the data base to import the data
-- Now that the data has been imported, we can now take a look at the table.

Select *
From layoffs;
-- To clean this data, we're going to go through multiple steps.
-- 1. REMOVE DUPLICATES IF ANY. If the data doesn't need duplicates or if there are repitions, it's necessary to remove duplicates
-- 2. STANDARDIZE THE DATA. This simply means making sure the data is in correct order by checking for issues with spelling and so on
-- 3. NULL AND BLANK VALUES. Here we see if we can populate the blank and null values. There are times we can and times we shouldnt'
-- 4. REMOVE UNNECESARY ROW AND COLUMNS. There are also instances where we can and shouldn't do this 

-- Now it can be dangerous to delete rows or column in raw data because once they're gone, there's no bringing them back, so what we can do
-- is to create a staging for the raw data set. We'll create a table and copy the raw data into it. We go..

CREATE TABLE layoffs_staging
LIKE layoffs;

Select*
From layoffs_staging;
-- Now that the table has been created we can then move the data into it by saying
INSERT Into layoffs_staging
Select *
From layoffs;
-- Here the data have been moved into the staging table. If we check, we'll find it all in it.

-- The reason for this is that we're going to change the staging table a lot and if there's a mistake, we want to have the raw data
-- still available and untampered. It's not advisable to work on the raw data. 

-- 1. REMOVING DUPLICATES
-- First thing to do is a row number. It'll help identify the rows easily. We'll match against the columns and then check for duplicates

Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as Row_Num
From layoffs_staging;
-- Now we'll ignore the unique ones and filter based on the rows that have row numbers higher than one, signifying they appeared more 
-- than once. We can do a CTE for this
WITH duplicate_cte as
(
Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as Row_Num
From layoffs_staging
)
Select *
From duplicate_cte
Where row_num > 1;
-- Now we can see the duplicates. 
-- What we'll do next is create a staging table like we did earlier, So we can eliminate the duplicates.
-- There are some duplicates that have sliglty different values, we don't want to delete those. We go...

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
From layoffs_staging2;

INSERT INTO layoffs_staging2
Select *,
ROW_NUMBER() OVER(PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as Row_Num
From layoffs_staging;
-- Now that the data have been inserted into the table where, we can identify the duplicates

Select *
From layoffs_staging2
Where row_num > 1;
-- Next we delete them. We go... 
Delete 
From layoffs_staging2
Where row_num > 1;
-- Now the duplicates have been deleted and it all looks so much better if we run the table again.
Select *
From layoffs_staging2;

-- Next up is STANDARDIZING THE DATA. 
-- 	This involves finding issues in the data a fixing them
-- If we run this table, we'll find that there are some rows that have spaces before the value. We have you eliminate those spaces and
-- make the data look standard.
Select trim(company)
From layoffs_staging2;
-- Here we have eliminated the spaces in the 'company' column. Next thing to do is update it. We go

UPDATE layoffs_staging2
SET company = trim(company); -- The spaces would've been eliminated when we run the layoffs_staging2 again

-- Next is to standardize the Industry column
Select distinct Industry
From layoffs_staging2
Order by 1;
-- When we run this query, we'll find for example that there are differnt Crypto industries, some just 'crypto' and some'crypto currency'
-- Now to have these under one distince industry (we'll be using crypto) and this is becuase when we start to do exploratory data analysis
-- and we start to visulaize, we want them to be classed under one industry instead of them appearing separately. What we need to do is...
-- first check them out. We go

Select *
From layoffs_staging2
Where Industry like 'crypto%';
-- Now that we have them, we can now do ahead and classify them into one distinct Industry (crypto). We go..

Update layoffs_staging2
Set industry = 'Crypto'
Where Industry like 'crypto%';
-- When we run this and check, we'll find that they have all been updated to one distince industry (Crypto).

-- We can go ahead to check all the other colums for issues that need fixing
-- Next one is Country. The rest seem good so far. So we goo

Select distinct country
From layoffs_staging2
Order by 1;
-- We found one Issue. There are two United States. One has a full stop the other doesn't, now we're going to have to eliminate the (.)
-- We can either update, or just do a Trim i.e

Update layoffs_staging2
Set Country = 'United States'
Where Country like 'United States';

--     OR

Select distinct Country, Trim(Trailing '.' From Country)
From layoffs_staging2
Order by 1;
-- And then do an update
-- Either way the '.' disappears

-- Now, the date is currently in text. That's what the raw data gave is. If we're doing Visualizations, Time series and all that, we have
-- to change the dates from text to actual dates column. Here's what we do

Select `date`,
Str_to_date (`date`, '%m/%d/%Y')
From layoffs_staging2;
-- Now the the dates have successfully been converted from Strings (which is text) to dates. Which is the standard date format in mysql.
-- Now we update the date colums to the actual date. We go...
Update layoffs_staging2
Set `date` = Str_to_date (`date`, '%m/%d/%Y'); -- It's been successfully updated.
-- We can now change it to an actual date column. We go...

Alter table layoffs_staging2
Modify column `date` date;
-- It has successfully been updated to a date column
-- It is advisable to always modify columns in the Staging Table and not on the actual raw table because we're completely changing the
-- data set of the actual column
-- Now the table has fairly been standardized, we can now move to the next step, which is...


-- FIXING NULL AND BLANK VALUES
-- In this step, we can either choose to make all the values blank, make them nulls or we can choose to populate them. It all depends.
-- First one we'll look at is the total laid off
Select *
From layoffs_staging2
Where total_laid_off is null
And percentage_laid_off is null;
-- The total laid off and percentage laid off column are kind of intertwined. Meaning that in the case that both of them are blank, that
-- gives is nothing to work with, so we can delete the rows where they are both blank. but if we have rows that have values in either
-- of them, we can leave those, but we've not gotten to removing rows and columns step, which is the last

-- Next one we want to take a look at is the industry. They were some null and blank values
Select *
From layoffs_staging2
Where Industry is null
Or Industry = '';
-- When we run this we find that there are 4 industries that are either null or blank. Now to get rid of the null or blanks, we can check
-- if any of the companies where they fall under had multiple layoffs. If they do and some of the other companies have an indutry or the
-- industry column is not null or blank, we can populate the blank indusrty columns with it

-- For example, we can check if the airbnb had multiple layoffs
Select *
From layoffs_staging2
Where company = 'Airbnb';
-- When we run this, we'll the that the same compnay (airbnb) had another layoff and the indutry column in the other one had 'travel', so
-- we can go ahead and populate the one that has a blank industry column with the same value. The reason why we can try to populate blank
-- columns is because when we're to look at what idustries were affected the most, the blank one is going to be useless.

-- To go about this, we can do a JOIN.
Select *
From layoffs_staging2 as t1
Join layoffs_staging2 as t2
	ON t1.company = t2.company
    And t1.location = t2.location
Where (t1.industry is null or t1.industry ='')
And t2.industry is not null;

-- When we run this JOIN, we'll see the companies that have have multiple layoffs with blank industries, which will be table 1(t1) and 
-- the ones where the indutries are not blank which is table 2(t2). SO now we can populate t1 with the values of t2
-- Now to update, we'll go

Update layoffs_staging2 as t1
Join layoffs_staging2 as t2
	ON t1.company = t2.company
    And t1.location = t2.location
Set t1.industry = t2.industry
Where (t1.industry is null or t1.industry ='')
And t2.industry is not null;
-- Now this didn't work and it could be because the colums were blank and not nulls. One way to go about this is to convert the blank
-- values to null.

Update layoffs_staging2
Set industry = Null
Where Industry = '';
-- Now that we've converted the blank values to null, we can try the previous query again
-- After we run it, we can now check to confirm that the null industry columns have been populated
-- Ballys remained null because it didn't have another layoff where the industry wasn't blank or null, so there was nothing we could
-- populate with.

-- That's all we'll do on populating null values.
-- Columns like the total laid off and percentage laid off will only be possible to populate if there was like a Update layoffs_staging2
-- if there was. we'd do some calulations to know the amount of staff laid off or the % laid off. For example if there's a company total
-- column with 50 employess, and the percentage laid off is 100%, we can easily populate the total laid off column, if it's blank. That
-- is all 50 employees were laid off.

-- Now to the last step which is Deleting Unncessary Rows and Columns
-- We were talking earlier about deleting rows where both total laid off and percentage laid off column are both blank because when were
-- doing exploratory data analysis on the data we're going to be using a lot of the two columns, so if they're both blank it 
-- gives us nothing to work with, so we can delete the rows where they are both blank.
-- We go...

Select *
From layoffs_staging2
Where total_laid_off is null
And percentage_laid_off is null;

-- SO to delete, we go...
Delete 
From layoffs_staging2
Where total_laid_off is null
And percentage_laid_off is null;
-- Now they've been deleted from the table entirely.
-- We call also delete the row_num column because we don't need it anymore
-- It's going to be a bit different because here we're completely dropping the entire column. We go...

ALTER TABLE layoffs_staging2
Drop column row_num;

-- If we run the entire table again, it should be gone.
Select *
From layoffs_staging2

-- Here we have a finalized clean data!!!









