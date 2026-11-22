USE PizzaSalesDB;
GO

-- Pizza Sales Analysis
-- Data Quality Checks

-- 1. Check row counts

SELECT 'orders' AS TableName, COUNT(*) AS TotalRows
FROM dbo.orders
UNION ALL
SELECT 'order_details', COUNT(*)
FROM dbo.order_details
UNION ALL
SELECT 'pizzas', COUNT(*)
FROM dbo.pizzas
UNION ALL
SELECT 'pizza_types', COUNT(*)
FROM dbo.pizza_types;

-- 2. Check duplicate order IDs
SELECT order_id, COUNT(*) AS DuplicateCount
FROM dbo.orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 3. Check missing order IDs
SELECT COUNT(*) AS MissingOrderIDs
FROM dbo.order_details
WHERE order_id IS NULL;

-- 4. Check invalid quantities
SELECT *
FROM dbo.order_details
WHERE quantity IS NULL OR quantity <= 0;

-- 5. Check missing pizza references
SELECT od.pizza_id
FROM dbo.order_details od
LEFT JOIN dbo.vw_pizzas_clean p
    ON od.pizza_id = p.pizza_id
WHERE p.pizza_id IS NULL;

-- 6. Check cleaned pizza prices
SELECT
    MIN(price) AS MinPrice,
    MAX(price) AS MaxPrice,
    COUNT(*) AS TotalPizzaVariants
FROM dbo.vw_pizzas_clean;

-- 7. Check missing orders

SELECT COUNT(*) AS MissingOrders
FROM dbo.order_details od
LEFT JOIN dbo.orders o
    ON od.order_id = o.order_id
WHERE o.order_id IS NULL;


-- 8. Check missing pizza types

SELECT COUNT(*) AS MissingPizzaTypes
FROM dbo.vw_pizzas_clean p
LEFT JOIN dbo.pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
WHERE pt.pizza_type_id IS NULL;