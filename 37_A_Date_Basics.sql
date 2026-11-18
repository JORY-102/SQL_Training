-- 1. Display order and shipping dates
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    ShipDate
FROM dbo.FactInternetSales;


-- 2. Display a hard-coded date
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    '2025-08-20' AS HardCoded
FROM dbo.FactInternetSales;


-- 3. Display the current date and time
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    '2025-08-20' AS HardCoded,
    GETDATE() AS Today
FROM dbo.FactInternetSales;
