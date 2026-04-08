SELECT * FROM walmart

DROP TABLE walmart;

-- Data Exploration

SELECT 
     payment_method,
	 COUNT(*)
FROM walmart
GROUP BY 1


SELECT 
    DISTINCT(branch)
FROM walmart;


SELECT 
    MAX(quantity)
FROM walmart;

SELECT 
    MIN(quantity)
FROM walmart;


-- BUSINESS PROBLEMS -- 

-- Q1. What are the different payment methods, and how many transactions and
--     items were sold with each method?


SELECT
    payment_method,
	count(*) AS no_of_transactions,
	sum(quantity) AS Total_qty_of_Items
FROM walmart
group by 1


/*
==================================================================================
Purpose: This helps understand customer preferences for payment methods, aiding in
payment optimization strategies.
==================================================================================
*/




-- Q2. Which category received the highest average rating in each branch?


SELECT *
FROM
(SELECT 
    branch,
	category,
	AVG(rating) as avg_rating,
	RANK() OVER(PARTITION BY branch order by AVG(rating) desc) AS rank
FROM walmart
GROUP BY 1,2
)
WHERE 
   rank = 1


/*
====================================================================================
Purpose: This allows Walmart to recognize and promote popular categories in specific
branches, enhancing customer satisfaction and branch-specific marketing.
====================================================================================
*/


-- Q3. What is the busiest day of the week for each branch based on transaction
--     volume?


SELECT *
FROM
(SELECT 
   branch,
   TO_CHAR(TO_DATE(date, 'DD/MM/YY'),'Day') AS day_name,
   COUNT(*) AS no_transactions,
   RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
FROM walmart
group by 1,2
)
WHERE
    rank = 1


/*
====================================================================================
Purpose: This insight helps in optimizing staffing and inventory management to
accommodate peak days.
====================================================================================
*/


-- Q4. How many items were sold through each payment method?


SELECT 
	 payment_method,
	 -- COUNT(*) as no_payments,
	 SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method

/*
====================================================================================
Purpose: This helps Walmart track sales volume by payment type, providing insights
into customer purchasing habits.
====================================================================================
*/



-- Q 5. Determine the average, minimum, and maximum rating of category for each city. 
--      List the city, average_rating, min_rating, and max_rating.

SELECT 
     city,
	 category,
	 AVG(rating),
	 MIN(rating),
	 MAX(rating)
FROM walmart 
GROUP BY 1,2


/*
=================================================================================
 Purpose: This data can guide city-level promotions, allowing Walmart to address
regional preferences and improve customer experiences.
=================================================================================
*/


-- Q6. What is the total profit for each category, ranked from highest to lowest?


SELECT 
	category,
	ROUND(SUM(total_sales):: numeric,2) as total_revenue,
	ROUND(SUM(total_sales * profit_margin):: numeric,2) as profit
FROM walmart
GROUP BY 1
   

/*
====================================================================================
 Purpose: Identifying high-profit categories helps focus efforts on expanding these
products or managing pricing strategies effectively.
====================================================================================
*/


--Q 7. What is the most frequently used payment method in each branch?

SELECT * FROM walmart


WITH cte
AS
(SELECT
    branch,
	payment_method,
	count(*) AS Total_tran,
	RANK() OVER(PARTITION BY branch order by count(*) desc) AS rank
FROM walmart 
GROUP BY 1, 2
)
SELECT *
FROM cte 
WHERE rank = 1


/*
====================================================================================
Purpose: This information aids in understanding branch-specific payment preferences,
potentially allowing branches to streamline their payment processing systems
=====================================================================================
*/


-- Q 8.  How many transactions occur in each shift (Morning, Afternoon, Evening)
--       across branches?



SELECT
	branch,
CASE 
		WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC















