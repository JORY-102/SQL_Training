-- Calculate territory totals after filtering to two products
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    SalesTerritoryKey,
    SalesAmount,
    SUM(SalesAmount) OVER
        (PARTITION BY SalesTerritoryKey) AS FilteredTerritorySales
FROM dbo.FactInternetSales
WHERE ProductKey IN
(
    SELECT DISTINCT TOP (2)
        ProductKey
    FROM dbo.FactInternetSales
    ORDER BY ProductKey
)
ORDER BY SalesTerritoryKey, ProductKey;


-- Find orders with sales above the overall order average
;WITH OrderTotals AS
(
    SELECT
        SalesOrderNumber,
        SUM(SalesAmount) AS OrderSales
    FROM dbo.FactInternetSales
    GROUP BY SalesOrderNumber
),
OrderAverages AS
(
    SELECT
        SalesOrderNumber,
        OrderSales,
        AVG(OrderSales) OVER () AS AvgOrderSales
    FROM OrderTotals
)
SELECT
    SalesOrderNumber,
    OrderSales,
    AvgOrderSales
FROM OrderAverages
WHERE OrderSales > AvgOrderSales
ORDER BY OrderSales DESC;


-- Calculate each sales line's percentage of total sales
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    SalesAmount,
    SUM(SalesAmount) OVER () AS TotalSales,
    ROUND(
        100.0 * SalesAmount
        / NULLIF(SUM(SalesAmount) OVER (), 0),
        2
    ) AS PercentageOfTotal
FROM dbo.FactInternetSales
ORDER BY PercentageOfTotal DESC;


-- Check for duplicate order-line keys
;WITH DuplicateCheck AS
(
    SELECT
        SalesOrderNumber,
        SalesOrderLineNumber,
        COUNT(*) OVER
        (
            PARTITION BY SalesOrderNumber, SalesOrderLineNumber
        ) AS KeyCount
    FROM dbo.FactInternetSales
)
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    KeyCount
FROM DuplicateCheck
WHERE KeyCount > 1;