-- Summarize orders and sales for each customer
;WITH OrderTotals AS
(
    SELECT
        CustomerKey,
        SalesOrderNumber,
        SUM(SalesAmount) AS OrderSales
    FROM dbo.FactInternetSales
    GROUP BY CustomerKey, SalesOrderNumber
)
SELECT
    CustomerKey,
    COUNT(*) AS TotalOrders,
    SUM(OrderSales) AS TotalSales,
    AVG(OrderSales) AS AvgOrderSales,
    MAX(OrderSales) AS HighestOrderSales,
    MIN(OrderSales) AS LowestOrderSales
FROM OrderTotals
GROUP BY CustomerKey
ORDER BY TotalSales DESC;


-- Calculate total sales for each product
SELECT
    ProductKey,
    SUM(SalesAmount) AS TotalSales
FROM dbo.FactInternetSales
GROUP BY ProductKey
ORDER BY TotalSales DESC;