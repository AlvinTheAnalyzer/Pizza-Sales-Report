/*
Author: Alvin Hartridge Jr.
Project Title: Pizza Sale Report

Purpose: Analyze key indicators our pizza sales data to gain insights into our business performance. Specifically, calucate the following metrics:
	1. Total Revenue: The sum of the total price of all pizza orders.
	2. Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders.
	3. Total Pizzas Sold: The sum of the quantities of all pizzas sold.
	4. Total Orders: The total number of orders placed.
	5. Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.
*/ 

-- Show all data within table
SELECT * FROM pizza_sales

/*
	Calculating KPI's 
*/
	-- Total Revenue
SELECT 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales

	-- Average Pizza Value
SELECT 
	SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales

	-- Total Pizza's Sold
SELECT 
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

	-- Total Orders
SELECT 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

	-- Average Pizza Per order
SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / 
	CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS AVG_Pizza_Per_Order
FROM pizza_sales


/*
	Creating variables for Charting
*/

	--Daily Trend for Total Orders 
SELECT 
	DATENAME(DW, order_date) AS Order_date, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

	--Monthly Trend for Total Orders
SELECT 
	DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

	--Percentage of Sales by Pizza Category & Size
SELECT 
	pizza_category, 
	CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS PCT
FROM pizza_sales 
GROUP BY pizza_category
/* To filter this query to show only  wanted months, use a WHERE clause. NOTE: using 1 in the WHERE clause translates to the month of January, using 4 translate to April.
EXAMPLE: WHERE MONTH(order_date) = 1 */

SELECT 
	pizza_size, 
	CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

	-- Top 5 Best Sellers by Revenue, Total Quantity, and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC;

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity DESC;

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Orders DESC;

	-- Bottom 5 Best Sellers by Revenue, Total Quantity, and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue ASC;

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity ASC;

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Orders ASC;
