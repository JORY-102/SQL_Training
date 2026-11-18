-- 1. Categorize orders and calculate total sales per category
;WITH OrderTotals AS (
    SELECT
        SalesOrderNumber,
        SUM(SalesAmount) AS OrderSales
    FROM dbo.FactInternetSales
    GROUP BY SalesOrderNumber
),
CategorizedOrders AS (
    SELECT
        OrderSales,
        CASE
            WHEN OrderSales > 50 THEN 'High'
            WHEN OrderSales > 20 THEN 'Medium'
            ELSE 'Low'
        END AS Category
    FROM OrderTotals
)
SELECT
    Category,
    SUM(OrderSales) AS TotalSales
FROM CategorizedOrders
GROUP BY Category
ORDER BY TotalSales DESC;


-- 2. Display employee gender as full text
SELECT
    EmployeeKey AS EmployeeID,
    FirstName,
    LastName,
    Gender,
    CASE
        WHEN Gender = 'F' THEN 'Female'
        WHEN Gender = 'M' THEN 'Male'
        ELSE 'Not Available'
    END AS GenderFullText
FROM dbo.DimEmployee;


-- 3. Display country abbreviations using simple CASE
SELECT
    c.CustomerKey AS CustomerID,
    c.FirstName,
    c.LastName,
    g.EnglishCountryRegionName AS Country,
    CASE g.EnglishCountryRegionName
        WHEN 'Germany' THEN 'DE'
        WHEN 'United States' THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbreviation
FROM dbo.DimCustomer AS c
LEFT JOIN dbo.DimGeography AS g
    ON c.GeographyKey = g.GeographyKey;


-- 4. Count orders with sales above 30 for each customer
;WITH OrderTotals AS (
    SELECT
        CustomerKey,
        SalesOrderNumber,
        SUM(SalesAmount) AS OrderSales
    FROM dbo.FactInternetSales
    GROUP BY CustomerKey, SalesOrderNumber
)
SELECT
    CustomerKey AS CustomerID,
    SUM(
        CASE
            WHEN OrderSales > 30 THEN 1
            ELSE 0
        END
    ) AS OrdersAbove30,
    COUNT(*) AS TotalOrders
FROM OrderTotals
GROUP BY CustomerKey
ORDER BY CustomerKey;