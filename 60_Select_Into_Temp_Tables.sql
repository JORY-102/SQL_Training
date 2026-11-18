-- Save monthly totals in a new table
SELECT
    DATETRUNC(MONTH, OrderDate) AS OrderMonth,
    COUNT(DISTINCT SalesOrderNumber) AS TotalOrders
INTO dbo.TrainingMonthlyOrders
FROM dbo.FactInternetSales
GROUP BY DATETRUNC(MONTH, OrderDate);

SELECT *
FROM dbo.TrainingMonthlyOrders
ORDER BY OrderMonth;


-- Copy sales lines into a temporary table
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    SalesAmount
INTO #Orders
FROM dbo.FactInternetSales;


-- Keep sales above 100 in the temporary table
DELETE FROM #Orders
WHERE SalesAmount <= 100;

SELECT * FROM #Orders;


-- Save the filtered data in a permanent table
SELECT *
INTO dbo.TrainingOrders
FROM #Orders;


-- Remove the temporary table
DROP TABLE #Orders;


-- Delete training tables only when needed
-- DROP TABLE dbo.TrainingMonthlyOrders;
-- DROP TABLE dbo.TrainingOrders;