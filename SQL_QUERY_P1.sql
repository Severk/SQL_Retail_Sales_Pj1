SELECT*
FROM sql_project_p1.retail_sales_analysis;

-- This code shows the correct amount of data imported from excel
SELECT
	COUNT(*)
FROM sql_project_p1.retail_sales_analysis;

-- Data cleaning
-- This shows if there is any NULL in data collected
SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE transactions_id IS NULL;

SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE sale_date IS NULL;

SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE sale_time IS NULL;

SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE customer_id IS NULL;

SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE gender IS NULL;


SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE 
	 age IS NULL
     OR
     category IS NULL
      OR
     quantiy IS NULL
      OR
     price_per_unit IS NULL
      OR
     cogs IS NULL
      OR
     total_sale IS NULL;
     
-- Use this to delete data that is NULL with no records 
-- DELETE FROM sql_project_p1.retail_sales_analysis
-- WHERE 
-- age IS NULL
     -- OR
-- category IS NULL
     -- OR
-- quantiy IS NULL
     -- OR
-- price_per_unit IS NULL
      -- OR
-- cogs IS NULL
     -- OR
-- total_sale IS NULL;


-- Data exploration 

-- How many sales we have?
SELECT
	COUNT(*) AS total_sale
FROM sql_project_p1.retail_sales_analysis;
-- How many unique customers we have?

SELECT
	COUNT(DISTINCT customer_id) AS total_customers
FROM sql_project_p1.retail_sales_analysis;

-- How many unique category we have?

SELECT
	COUNT(DISTINCT category) AS total_category
FROM sql_project_p1.retail_sales_analysis;

SELECT
	DISTINCT category AS category
FROM sql_project_p1.retail_sales_analysis;

-- Data Analysis & Business Key Problems & Answers

-- q.1 write a sql query to retrieve all columns for sales made on '2022-11-05'
-- q.2 write a sql query to retrieve all transactions where the category is 'clothing' and quantity sold is more than 10 in the month of Nov-2022
-- q.3 write a sql query to calculate the total sales for each category
-- q.4 write a sql query to find the average age of cust who purchased items from the 'beauty' category
-- q.5 write a sql query to find all transaction where the total_sale is greater than 1000
-- q.6 write a sql query to find the total number of transactions (transaction_id) made by each gender in each category
-- q.7 write a sql query to calculate the average sale for each month. Find out the best selling month in each year
-- q.8 write a sql query to find the top 5 custmoers based on the highest total sales
-- q.9 write a sql query to find the number of unique customers who purchased items in each category
-- q.10 write a sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 & 17, Evening >17

-- q.1 write a sql query to retrieve all columns for sales made on '2022-11-05'

SELECT*
FROM sql_project_p1.retail_sales_analysis
WHERE sale_date = '2022-11-05'
;

-- q.2 write a sql query to retrieve all transactions where the category is 'clothing' and quantity sold is more than 4 in the month of Nov-2022

    
SELECT *
FROM sql_project_p1.retail_sales_analysis
WHERE 
    category = 'Clothing'
    AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
    AND 
    quantiy >= 4;
    
-- q.3 write a sql query to calculate the total sales for each category

SELECT
	category,
    SUM(total_sale) AS Net_sale,
    COUNT(*) AS Total_orders
FROM  sql_project_p1.retail_sales_analysis
GROUP BY 1;

-- q.4 write a sql query to find the average age of cust who purchased items from the 'beauty' category

SELECT 
	ROUND(AVG(age),2) Avg_age
FROM  sql_project_p1.retail_sales_analysis
WHERE category = 'Beauty'
;
-- q.5 write a sql query to find all transaction where the total_sale is greater than 1000

SELECT*
FROM  sql_project_p1.retail_sales_analysis
WHERE total_sale > 1000 

;
SELECT
	COUNT(*) AS Total_sale_1000
FROM  sql_project_p1.retail_sales_analysis
WHERE total_sale > 1000 ;

-- q.6 write a sql query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT
	category,
    gender,
    COUNT(*) total_trans
FROM  sql_project_p1.retail_sales_analysis
GROUP BY 
	category,
    gender
ORDER BY 1
    ;

-- q.7 write a sql query to calculate the average sale for each month. Find out the best selling month in each year

SELECT
	Year,
    Month,
    avg_total_sale
FROM
(
	SELECT
		YEAR(sale_date) AS Year,
		MONTH(sale_date) AS Month,
		Avg(total_sale) as avg_total_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY  Avg(total_sale) DESC) AS Rank_
	FROM  sql_project_p1.retail_sales_analysis
	GROUP BY 1, 2
	-- ORDER BY 1, 3 desc
) AS T1
WHERE RANK_ = 1
;

-- q.8 write a sql query to find the top 5 custmoers based on the highest total sales

SELECT
	customer_id,
    SUM(total_sale) AS total_sales
FROM  sql_project_p1.retail_sales_analysis
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
;


-- q.9 write a sql query to find the number of unique customers who purchased items in each category

SELECT
	category,
    COUNT(DISTINCT customer_id) AS Unique_cust
FROM  sql_project_p1.retail_sales_analysis
GROUP BY category;


-- q.10 write a sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 & 17, Evening >17

WITH hourly_sale
AS
(
	SELECT*,
		CASE
			WHEN HOUR(sale_time) < 12 THEN 'Morning'
			WHEN  HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS Shift
	FROM  sql_project_p1.retail_sales_analysis
)
SELECT
	Shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY Shift











