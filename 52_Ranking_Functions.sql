-- Compare ranking functions
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    SalesAmount,
    ROW_NUMBER() OVER (ORDER BY SalesAmount DESC) AS RowNum,
    RANK() OVER (ORDER BY SalesAmount DESC) AS SalesRank,
    DENSE_RANK() OVER (ORDER BY SalesAmount DESC) AS DenseRank
FROM dbo.FactInternetSales
ORDER BY RowNum;


-- Find the highest sales line for each product
SELECT *
FROM
(
    SELECT
        SalesOrderNumber,
        ProductKey,
        SalesAmount,
        ROW_NUMBER() OVER
        (
            PARTITION BY ProductKey
            ORDER BY SalesAmount DESC
        ) AS ProductRank
    FROM dbo.FactInternetSales
) t
WHERE ProductRank = 1;


-- Find the two customers with the lowest total sales
SELECT *
FROM
(
    SELECT
        CustomerKey,
        SUM(SalesAmount) AS TotalSales,
        ROW_NUMBER() OVER
        (
            ORDER BY SUM(SalesAmount), CustomerKey
        ) AS CustomerRank
    FROM dbo.FactInternetSales
    GROUP BY CustomerKey
) t
WHERE CustomerRank <= 2
ORDER BY CustomerRank;


-- Assign a sequential number to each sales line
SELECT
    ROW_NUMBER() OVER
    (
        ORDER BY SalesOrderNumber, SalesOrderLineNumber
    ) AS RowID,
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    SalesAmount
FROM dbo.FactInternetSales
ORDER BY RowID;