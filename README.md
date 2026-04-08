#  Walmart Sales Analysis – SQL Business Intelligence Project  
![image](https://github.com/kovidanand/SQL-Walmart_Sales_Analysis_P8/blob/main/Walmart%20pic)

---

## Overview

This project performs SQL-based analysis on Walmart’s retail sales dataset to extract meaningful insights related to customer behavior, sales performance, operational efficiency, and profitability.

The objective is to transform raw transactional data into **actionable business intelligence** that supports better decision-making in retail operations.

---

## Business Context

Retail organizations operate at large scale where decisions around pricing, inventory, staffing, and customer experience directly impact revenue.

This project addresses key challenges such as:

- Understanding customer purchasing and payment behavior  
- Identifying high-performing and low-performing product categories  
- Analyzing customer satisfaction across locations  
- Detecting peak sales periods for operational planning  
- Identifying early signs of revenue decline  

---

## Dataset

The dataset includes structured transactional data covering:

- Branch and city information  
- Product categories  
- Sales, revenue, and quantity  
- Payment methods  
- Customer ratings  
- Date and time of transactions  

This enables comprehensive analysis across multiple business dimensions.

---

## SQL Analysis & Queries

The following queries were used to derive insights from the dataset:

```sql
-- Payment behavior and transaction volume
SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_items_sold
FROM walmart_sales
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- Customer satisfaction across branches and categories
SELECT branch, category, AVG(rating) AS avg_rating
FROM walmart_sales
GROUP BY branch, category;

-- Peak operational days
SELECT 
    branch,
    DAYNAME(date) AS day_name,
    COUNT(*) AS total_transactions
FROM walmart_sales
GROUP BY branch, DAYNAME(date)
ORDER BY total_transactions DESC;

-- Sales volume distribution
SELECT 
    payment_method,
    SUM(quantity) AS total_quantity_sold
FROM walmart_sales
GROUP BY payment_method;

-- Regional customer satisfaction insights
SELECT 
    city,
    category,
    AVG(rating) AS avg_rating,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating
FROM walmart_sales
GROUP BY city, category;

-- Profitability analysis
SELECT 
    category,
    SUM(total) AS total_revenue,
    SUM(profit) AS total_profit
FROM walmart_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Payment preference per branch
SELECT 
    branch,
    payment_method,
    COUNT(*) AS usage_count
FROM walmart_sales
GROUP BY branch, payment_method
ORDER BY usage_count DESC;

-- Sales distribution across day shifts
SELECT 
    branch,
    CASE 
        WHEN HOUR(time) < 12 THEN 'Morning'
        WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS transactions
FROM walmart_sales
GROUP BY branch, shift;

-- Revenue trend analysis
SELECT 
    branch,
    year,
    total_revenue,
    LAG(total_revenue) OVER (PARTITION BY branch ORDER BY year) AS prev_year_revenue,
    (total_revenue - LAG(total_revenue) OVER (PARTITION BY branch ORDER BY year)) AS revenue_change
FROM yearly_sales;
