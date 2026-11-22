USE PizzaSalesDB;
GO

-- Pizza Sales Analysis
-- Advanced Analysis

-- 1. Pizza performance classification
WITH PizzaSales AS (
    SELECT
        pt.name AS PizzaName,
        SUM(od.quantity) AS TotalSold
    FROM dbo.order_details od
    JOIN dbo.vw_pizzas_clean p
        ON od.pizza_id = p.pizza_id
    JOIN dbo.pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.name
)
SELECT
    PizzaName,
    TotalSold,
    CASE
        WHEN TotalSold >= 2000 THEN 'High'
        WHEN TotalSold >= 1000 THEN 'Medium'
        ELSE 'Low'
    END AS Performance
FROM PizzaSales
ORDER BY TotalSold DESC;

-- 2. Pizzas with above-average sales
WITH PizzaSales AS (
    SELECT
        pt.name AS PizzaName,
        SUM(od.quantity) AS TotalSold
    FROM dbo.order_details od
    JOIN dbo.vw_pizzas_clean p
        ON od.pizza_id = p.pizza_id
    JOIN dbo.pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.name
)
SELECT
    PizzaName,
    TotalSold
FROM PizzaSales
WHERE TotalSold > (
    SELECT AVG(TotalSold * 1.0)
    FROM PizzaSales
)
ORDER BY TotalSold DESC;

-- 3. Top 3 pizzas in each category
WITH PizzaRevenue AS (
    SELECT
        pt.category,
        pt.name AS PizzaName,
        SUM(od.quantity * p.price) AS TotalRevenue
    FROM dbo.order_details od
    JOIN dbo.vw_pizzas_clean p
        ON od.pizza_id = p.pizza_id
    JOIN dbo.pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
),
PizzaRanking AS (
    SELECT
        category,
        PizzaName,
        TotalRevenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY TotalRevenue DESC
        ) AS PizzaRank
    FROM PizzaRevenue
)
SELECT *
FROM PizzaRanking
WHERE PizzaRank <= 3
ORDER BY category, PizzaRank;

-- 4. Monthly revenue contribution
WITH MonthlySales AS (
    SELECT
        MONTH(o.date) AS Month,
        SUM(od.quantity * p.price) AS TotalRevenue
    FROM dbo.orders o
    JOIN dbo.order_details od
        ON o.order_id = od.order_id
    JOIN dbo.vw_pizzas_clean p
        ON od.pizza_id = p.pizza_id
    GROUP BY MONTH(o.date)
)
SELECT
    Month,
    TotalRevenue,
    CAST(
        TotalRevenue * 100.0 / SUM(TotalRevenue) OVER ()
        AS DECIMAL(10,2)
    ) AS RevenuePercentage
FROM MonthlySales
ORDER BY Month;

-- 5. Running total of monthly revenue
WITH MonthlySales AS (
    SELECT
        MONTH(o.date) AS Month,
        SUM(od.quantity * p.price) AS TotalRevenue
    FROM dbo.orders o
    JOIN dbo.order_details od
        ON o.order_id = od.order_id
    JOIN dbo.vw_pizzas_clean p
        ON od.pizza_id = p.pizza_id
    GROUP BY MONTH(o.date)
)
SELECT
    Month,
    TotalRevenue,
    SUM(TotalRevenue) OVER (
        ORDER BY Month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM MonthlySales
ORDER BY Month;