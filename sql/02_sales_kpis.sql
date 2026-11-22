USE PizzaSalesDB;
GO
-- =======================================
-- PIZZA SALES ANALYSIS
-- 02 - SALES KPI ANALYSIS
-- =======================================

-- Q1: What is the total number of orders?

-- Q2: How many pizzas were sold?

-- Q3: What is the total revenue?

-- Q4: What is the average order value?

-- 1. Total number of orders
SELECT COUNT(*) AS TotalOrders
FROM dbo.orders;


-- 2. Total pizzas sold
SELECT SUM(quantity) AS TotalPizzasSold
FROM dbo.order_details;


-- 3. Total revenue
SELECT
    ROUND(SUM(od.quantity * p.price), 2) AS TotalRevenue
FROM dbo.order_details od
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id;


-- 4. Average order value
SELECT
    ROUND(
        SUM(od.quantity * p.price) /
        COUNT(DISTINCT od.order_id), 2
    ) AS AverageOrderValue
FROM dbo.order_details od
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id;