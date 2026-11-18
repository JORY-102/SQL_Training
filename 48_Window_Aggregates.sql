-- Compare sales lines with overall and product statistics
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate,
    ProductKey,
    SalesAmount,
    SUM(SalesAmount) OVER () AS TotalSales,
    SUM(SalesAmount) OVER
        (PARTITION BY ProductKey) AS ProductSales,
    AVG(SalesAmount) OVER () AS AvgLineSales,
    AVG(SalesAmount) OVER
        (PARTITION BY ProductKey) AS AvgProductLineSales,
    MAX(SalesAmount) OVER () AS HighestLineSales,
    MIN(SalesAmount) OVER () AS LowestLineSales,
    MAX(SalesAmount) OVER
        (PARTITION BY ProductKey) AS HighestProductLineSales,
    MIN(SalesAmount) OVER
        (PARTITION BY ProductKey) AS LowestProductLineSales
FROM dbo.FactInternetSales
ORDER BY ProductKey, SalesOrderNumber, SalesOrderLineNumber;


-- Calculate sales for each product and territory combination
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    SalesTerritoryKey,
    SalesAmount,
    SUM(SalesAmount) OVER
    (
        PARTITION BY ProductKey, SalesTerritoryKey
    ) AS ProductTerritorySales
FROM dbo.FactInternetSales
ORDER BY ProductKey, SalesTerritoryKey;


-- Count all orders and orders for each customer
;WITH OrderTotals AS
(
    SELECT
        SalesOrderNumber,
        CustomerKey,
        OrderDate,
        SUM(SalesAmount) AS OrderSales
    FROM dbo.FactInternetSales
    GROUP BY SalesOrderNumber, CustomerKey, OrderDate
)
SELECT
    SalesOrderNumber,
    OrderDate,
    CustomerKey,
    OrderSales,
    COUNT(*) OVER () AS TotalOrders,
    COUNT(*) OVER
        (PARTITION BY CustomerKey) AS CustomerOrders
FROM OrderTotals
ORDER BY CustomerKey, SalesOrderNumber;


-- Compare row counts with non-null value counts
SELECT
    CustomerKey,
    FirstName,
    MiddleName,
    LastName,
    COUNT(*) OVER () AS TotalCustomers,
    COUNT(1) OVER () AS TotalCustomersOne,
    COUNT(MiddleName) OVER () AS CustomersWithMiddleName
FROM dbo.DimCustomer
ORDER BY CustomerKey;