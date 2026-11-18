-- Find lowest and highest sales for each product
SELECT
    SalesOrderNumber,
    ProductKey,
    SalesAmount,

    FIRST_VALUE(SalesAmount) OVER
    (
        PARTITION BY ProductKey
        ORDER BY SalesAmount
    ) AS LowestSales,

    LAST_VALUE(SalesAmount) OVER
    (
        PARTITION BY ProductKey
        ORDER BY SalesAmount
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS HighestSales,

    SalesAmount - FIRST_VALUE(SalesAmount) OVER
    (
        PARTITION BY ProductKey
        ORDER BY SalesAmount
    ) AS SalesDifference

FROM dbo.FactInternetSales
ORDER BY ProductKey, SalesAmount;