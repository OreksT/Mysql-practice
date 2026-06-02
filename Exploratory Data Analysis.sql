-- EXPLORATORY DATA ANALYSIS

-- We are going to do some exploratory data analysis on the Layoff dataset that we cleaned
-- Before you start the EDA process sometimes, you have an idea what you want to do, or what you're looking for and sometimes while 
-- exploring the data, you find issues that you probably missed during the data cleaning process that you have to clean while exploring.
-- Or sometimes it can be that you don't get to clean the data and explore it separately. Somtimes you have to do them together as you go.
-- For this data set, we don't have a specific agenda, so we're just going to be exploring it
-- We'll start with the basics and work our way up.
-- We're going to be working a lot with the total laid off column. The % laid off is not going to be so useful because we don't know how
-- big the companies are or how many employees they actually had.

Select *
From layoffs_staging2;

-- 1. 
Select Max(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2;
-- Here we an see higest lay off in a single day in the whole data and the highest percentage laid off at once

Select *
From layoffs_staging2
Where percentage_laid_off = 1
Order by total_laid_off desc;

-- Here we can see all the companies that had a 100% lay off and we also ordered by the total laid off in descending order to see which
-- company had the highest lay off out of the sompanies with a 100% lay off

-- 2.
Select Company, sum(total_laid_off)
From layoffs_staging2
Group by Company
Order by 2 Desc;
-- Here we can see sum of the total lay off by each company. 

Select *
From layoffs_staging2
Where company = 'Google';

-- Now to take a look at the date range, that is when they layoffs started and when it ended, in our data. We go...
Select MIN(`date`), Max(`date`)
From layoffs_staging2;
-- that is 11th of March, 2020 until 6th of March, 2023.

-- We can also check for which industry had the most layoff during the period. We go...
Select industry, sum(total_laid_off)
From layoffs_staging2
Group by industry
Order by 2 Desc;

-- We can also see which country had the most layoffs in our data.
Select country, sum(total_laid_off)
From layoffs_staging2
Group by country
Order by 2 Desc;
-- The United States had the most layoffs.

-- Next, we check for which year had the most layoffs. We go...
Select Year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by Year(`date`)
Order by 2 Desc;
-- Here we can see than 2023 was the year where the most layoff happened.

-- We can also check for what stage of company had the most layoffs
Select stage, sum(total_laid_off)
From layoffs_staging2
Group by stage
Order by 2 Desc;
-- Here we can see that the Post-IPO companies had the most layoffs. These are the Googles, the Amazons, and the big companies.

-- One major thing to look at is to check for the progression of the layoffs, like a rolling total. We can do it based off the months.
Select substring(`date`, 6,2) as `Month`, Sum(total_laid_off)
From layoffs_staging2
Group by `Month`;
-- If we do it this way, we'll get only the months, we won't be able to identify which year the months fall under, which would leave 
-- it completely vague. So to do it such that we have the months and the years, we'll go...

Select substring(`date`, 1,7) as `Month`, Sum(total_laid_off)
From layoffs_staging2
Where substring(`date`, 1,7) is not Null
Group by `Month`
Order by 1 asc;
-- With this we'll be able to determine the layoffs per month for the whole 3 year period of the data. We can now go ahead and do our
-- rolling total. Here, we'll use a CTE

WITH Rolling_total AS
(
Select substring(`date`, 1,7) as `Month`, Sum(total_laid_off) AS Total_Off
From layoffs_staging2
Where substring(`date`, 1,7) is not Null
Group by `Month`
Order by 1 asc
)
Select `Month`, Sum(Total_Off) Over (Order by `Month`) AS Rolling_Total
From Rolling_Total;
-- Here we have each month at the rolling total for each. To make it clearer, we'll add the total per month, it makes it easier to 
-- understand the rolling total. We go...

WITH Rolling_total AS
(
Select substring(`date`, 1,7) as `Month`, Sum(total_laid_off) AS Total_Off
From layoffs_staging2
Where substring(`date`, 1,7) is not Null
Group by `Month`
Order by 1 asc
)
Select `Month`, Total_off, Sum(Total_Off) Over (Order by `Month`) AS Rolling_Total
From Rolling_Total;

-- Next thing we want to look at after our rolling total is to see how much each company laid off per year, instead of just looking at
-- the total that they laid off

Select Company, `date`, sum(total_laid_off)
From layoffs_staging2
Group by Company, `date`;
-- What this gives us is just the dates that the lay offs happened for each company and the layoff that happened on the day
-- What we actually want is just they year. We go...

Select Company, Year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by Company, Year(`date`)
Order BY 3 desc;
-- Now we can the companies and how much they laid off per year for the companies that had multiple lay offs

-- Now to see which company had the most layoffs per year and actually rank them, we'll do a CTE again and partition based
-- off of the years. we'll go...

With Company_Year (Company, Years, Total_Laid_Off) AS
(
Select Company, Year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by Company, Year(`date`)
)
Select *, 
Dense_rank() Over(Partition By Years Order by Total_Laid_Off desc) as Ranking
From Company_Year
Where Years is not NUll
Order by Ranking asc;
-- Now we have the rankings of the comapnies with the most layoffs for each year.
-- Now we can filter based on the ranking and just decide to view only the top 5 companies per year. What we'll do is convert the query
-- in the above also to a CTE and then query off of it, as in...

With Company_Year (Company, Years, Total_Laid_Off) AS
(
Select Company, Year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by Company, Year(`date`)
),
Company_Year_Rank AS
(
Select *, 
Dense_rank() Over(Partition By Years Order by Total_Laid_Off desc) as Ranking
From Company_Year
Where Years is not NUll)
Select *
From Company_Year_Rank
Where Ranking <= 5;

-- Now we have the top 5 rankings of the companies with the most layout for each year










