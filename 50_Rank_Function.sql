-- Rank orders from highest to lowest total sales
;WITH OrderTotals AS
(
    SELECT
        SalesOrderNumber,
        OrderDate,
        SUM(SalesAmount) AS OrderSales
    FROM dbo.FactInternetSales
    GROUP BY SalesOrderNumber, OrderDate
)
SELECT
    SalesOrderNumber,
    OrderDate,
    OrderSales,
    RANK() OVER
        (ORDER BY OrderSales DESC) AS SalesRank
FROM OrderTotals
ORDER BY SalesRank, SalesOrderNumber;


-- Rank customers by their total sales
SELECT
    CustomerKey,
    SUM(SalesAmount) AS TotalSales,
    RANK() OVER
        (ORDER BY SUM(SalesAmount) DESC) AS CustomerRank
FROM dbo.FactInternetSales
GROUP BY CustomerKey
ORDER BY CustomerRank, CustomerKey;