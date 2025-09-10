-- ==============================================
-- Project: Sales Data Analysis
-- File: queries.sql
-- Description: SQL queries for exploratory analysis
-- Database: PostgreSQL
-- ==============================================

-- 1. Total Sales
SELECT SUM(SALES) AS total_sales
FROM sales_data;

-- 2. Average Sales by Product Line
SELECT PRODUCTLINE, ROUND(AVG(SALES),2) AS avg_sales
FROM sales_data
GROUP BY PRODUCTLINE
ORDER BY avg_sales DESC;

-- 3. Top 5 Customers by Revenue
SELECT CUSTOMERNAME, ROUND(SUM(SALES),2) AS total_revenue
FROM sales_data
GROUP BY CUSTOMERNAME
ORDER BY total_revenue DESC
LIMIT 5;

-- 4. Sales by Year
SELECT YEAR_ID, SUM(SALES) AS total_sales
FROM sales_data
GROUP BY YEAR_ID
ORDER BY YEAR_ID;

-- 5. Sales by Country
SELECT COUNTRY, SUM(SALES) AS total_sales
FROM sales_data
GROUP BY COUNTRY
ORDER BY total_sales DESC;

-- 6. Sales by Deal Size
SELECT DEALSIZE, SUM(SALES) AS total_sales, COUNT(*) AS num_orders
FROM sales_data
GROUP BY DEALSIZE
ORDER BY total_sales DESC;

-- 7. Top 3 Products by Customer
SELECT *
FROM (
  SELECT CUSTOMERNAME, PRODUCTLINE, SUM(SALES) AS total_sales,
         ROW_NUMBER() OVER (PARTITION BY CUSTOMERNAME ORDER BY SUM(SALES) DESC) AS rn
  FROM sales_data
  GROUP BY CUSTOMERNAME, PRODUCTLINE
) sub
WHERE rn <= 3;
