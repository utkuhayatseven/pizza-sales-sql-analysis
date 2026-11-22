USE PizzaSalesDB;
GO

-- Pizza Sales Analysis
-- Time Analysis

-- 1. Monthly sales revenue
SELECT
    MONTH(o.date) AS Month,
    ROUND(SUM(od.quantity * p.price), 2) AS TotalRevenue
FROM dbo.orders o
JOIN dbo.order_details od
    ON o.order_id = od.order_id
JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id
GROUP BY MONTH(o.date)
ORDER BY Month;

-- 2. Orders by day of the week
SELECT
    DATENAME(WEEKDAY, date) AS DayOfWeek,
    COUNT(*) AS TotalOrders
FROM dbo.orders
GROUP BY DATENAME(WEEKDAY, date)
ORDER BY TotalOrders DESC;

-- 3. Orders by hour
SELECT
    DATEPART(HOUR, time) AS OrderHour,
    COUNT(*) AS TotalOrders
FROM dbo.orders
GROUP BY DATEPART(HOUR, time)
ORDER BY TotalOrders DESC;

-- 4. Monthly order trends
SELECT
    MONTH(date) AS Month,
    COUNT(*) AS TotalOrders
FROM dbo.orders
GROUP BY MONTH(date)
ORDER BY Month;

-- 5. Top 10 busiest days
SELECT TOP 10
    date AS OrderDate,
    COUNT(*) AS TotalOrders
FROM dbo.orders
GROUP BY date
ORDER BY TotalOrders DESC;