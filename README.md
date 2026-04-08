#  Walmart Sales Analysis – SQL Business Intelligence Project  
![image](https://github.com/kovidanand/Walmart_Analysis_P8/blob/main/logo.png)

---

## Overview

This project performs structured SQL-based analysis on Walmart’s retail sales dataset to uncover customer behavior, sales performance, operational patterns, and profitability insights.

The objective is to demonstrate how transactional retail data can be transformed into **actionable business intelligence** for improving revenue, customer experience, and operational efficiency.

---

## Business Problem

**Retail businesses like Walmart operate at scale and rely on data to:**

- Understand customer purchasing behavior  
- Optimize payment systems and checkout experience  
- Identify high-performing product categories  
- Improve customer satisfaction across regions  
- Manage staffing and inventory during peak hours  
- Detect underperforming branches and revenue decline  

---

## Dataset Description

The dataset includes structured transactional data with the following attributes:

- Branch and City  
- Product Category  
- Sales and Revenue  
- Quantity Sold  
- Payment Methods  
- Customer Ratings  
- Date and Time of Transactions  

This enables multi-dimensional analysis across **sales, customers, and operations**.

---

## Key SQL Analysis

### 1. Payment Method Analysis

```sql
SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_items_sold
FROM walmart_sales
GROUP BY payment_method
ORDER BY total_transactions DESC;
