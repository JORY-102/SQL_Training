-- Compare product, running, and three-line moving averages
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    OrderDate,
    SalesAmount,

    AVG(SalesAmount) OVER
    (
        PARTITION BY ProductKey
    ) AS AvgByProduct,

    AVG(SalesAmount) OVER
    (
        PARTITION BY ProductKey
        ORDER BY OrderDate, SalesOrderNumber, SalesOrderLineNumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningAvg,

    AVG(SalesAmount) OVER
    (
        PARTITION BY ProductKey
        ORDER BY OrderDate, SalesOrderNumber, SalesOrderLineNumber
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvgLast3Lines

FROM dbo.FactInternetSales
ORDER BY
    ProductKey,
    OrderDate,
    SalesOrderNumber,
    SalesOrderLineNumber;