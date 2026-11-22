USE PizzaSalesDB;
GO

-- Pizza Sales Analysis
-- Product Analysis

-- 1. Top 10 best-selling pizzas
SELECT TOP 10
    pt.name AS PizzaName,
    SUM(od.quantity) AS TotalSold
FROM dbo.order_details od
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id
JOIN dbo.pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY TotalSold DESC;

-- 2. Top 10 pizzas by revenue
SELECT TOP 10
    pt.name AS PizzaName,
    ROUND(SUM(od.quantity * p.price), 2) AS TotalRevenue
FROM dbo.order_details od
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id
JOIN dbo.pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY TotalRevenue DESC;

-- 3. Sales by pizza category
SELECT
    pt.category AS Category,
    SUM(od.quantity) AS TotalSold,
    ROUND(SUM(od.quantity * p.price), 2) AS TotalRevenue
FROM dbo.order_details od
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id
JOIN dbo.pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY TotalRevenue DESC;

-- 4. Sales by pizza size
SELECT
    p.size AS PizzaSize,
    SUM(od.quantity) AS TotalSold,
    ROUND(SUM(od.quantity * p.price), 2) AS TotalRevenue
FROM dbo.order_details od
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY TotalRevenue DESC;
