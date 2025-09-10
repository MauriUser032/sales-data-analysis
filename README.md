Project 1: Sales Data Analysis (Excel + SQL)

Overview

This project applies data cleaning, exploratory data analysis, and SQL queries on a sales dataset (~2,800 records).
The goal was to identify sales patterns, the most profitable customers, and seasonality in the business.
Tools used:

•	Excel → data cleaning, exploratory analysis, pivot tables.

•	PostgreSQL (pgAdmin 4) → SQL queries.

•	Visualizations → pivot charts, bar charts, pie charts.


Data Cleaning

•	Initial dataset: 2,822 rows, 25 columns.

Issues found:

•	Missing values in ADDRESSLINE2 (89%), STATE (53%), and POSTALCODE (2.7%).

•	Decimal values with . instead of , (locale issue in Excel).

•	ORDERDATE column mixed between text and valid date formats.

•	PRICEEACH column with inconsistent rounded values (multiples of 100).

Actions taken:

•	Replaced decimal separators (. → ,) for correct numeric parsing in Excel.

•	Normalized dates using “Text to Columns” and converted all to valid date format.

•	Missing STATE replaced with "N/A".

•	Missing POSTALCODE replaced with "Unknown".

•	Created auxiliary column PRICEEACH_clean = SALES / QUANTITYORDERED.

Final result:

2,817 clean rows, no duplicates, no critical inconsistencies.


Exploratory Analysis in Excel
1. Average Sales
•	Average sales per order: USD 3,553.88.
•	Insight → stable order value.

2. Top Products by Product Line
•	Classic Cars: 39% of total sales (~USD 3.9M).
•	Vintage Cars: 19%.
•	Insight → business highly dependent on two product lines (58% of total sales).

3. Most Profitable Customers
•	Euro Shopping Channel: ~USD 912K (9%).
•	Mini Gifts Distributors Ltd.: ~USD 655K.
•	Insight → top 10% of customers drive a large portion of revenue.

4. Geographic Distribution
•	Key markets: USA, Spain, France.
•	Insight → potential to expand in smaller markets.
 
 
 

SQL Queries (PostgreSQL)

Total Sales

SELECT SUM(SALES) AS total_sales

FROM sales_data;


Result: USD 10,032,628.85


Sales by Year

SELECT YEAR_ID, SUM(SALES) AS total_sales

FROM sales_data

GROUP BY YEAR_ID

ORDER BY YEAR_ID;

Year	Sales

2003	3.5M

2004	4.7M

2005	1.8M



2004 was the strongest year, accounting for ~47% of total sales.


Sales by Country (Top 5)

SELECT COUNTRY, SUM(SALES) AS total_sales

FROM sales_data

GROUP BY COUNTRY

ORDER BY total_sales DESC

LIMIT 5;

Country	Sales

USA	3.62M

Spain	1.21M

France	1.11M

Australia	0.63M

UK	0.47M

USA alone represents over 36% of sales.


Sales by Deal Size

SELECT DEALSIZE, SUM(SALES) AS total_sales, COUNT(*) AS num_orders

FROM sales_data

GROUP BY DEALSIZE

ORDER BY total_sales DESC;

Deal Size	Sales	Orders

Medium	6.08M	1,384

Small	2.64M	1,282

Large	1.30M	157


Medium-sized deals are both the most frequent and the most profitable.


Key Insights

•	Business depends heavily on Classic & Vintage Cars (58% of revenue).

•	Revenue concentration is high: few customers generate the majority of sales.

•	USA is the main market, followed by Spain and France.

•	Clear seasonality: sales peak in Q4 (November), likely due to holiday season demand.




