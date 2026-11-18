-- 1. Customers without sales
SELECT c.CustomerKey, c.FirstName
FROM dbo.DimCustomer AS c
LEFT JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey
WHERE s.CustomerKey IS NULL;


-- 2. Sales without matching customers
SELECT s.CustomerKey, s.SalesOrderNumber, s.SalesAmount
FROM dbo.DimCustomer AS c
RIGHT JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey
WHERE c.CustomerKey IS NULL;


-- 3. Customers without sales and sales without customers
SELECT
    c.CustomerKey,
    c.FirstName,
    s.CustomerKey AS SalesCustomerKey,
    s.SalesOrderNumber,
    s.SalesAmount
FROM dbo.DimCustomer AS c
FULL JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey
WHERE c.CustomerKey IS NULL
   OR s.CustomerKey IS NULL;


-- 4. All combinations of two small samples
SELECT
    c.CustomerKey,
    c.FirstName,
    s.SalesOrderNumber,
    s.SalesOrderLineNumber
FROM (
    SELECT TOP 3 CustomerKey, FirstName
    FROM dbo.DimCustomer
    ORDER BY CustomerKey
) AS c
CROSS JOIN (
    SELECT TOP 3 SalesOrderNumber, SalesOrderLineNumber
    FROM dbo.FactInternetSales
    ORDER BY SalesOrderNumber, SalesOrderLineNumber
) AS s;