-- Convert order date to DATE
SELECT
    SalesOrderNumber,
    CAST(OrderDate AS DATE) AS OrderDateOnly
FROM dbo.FactInternetSales;

-- Format order date as yyyy-mm-dd
SELECT
    SalesOrderNumber,
    CONVERT(VARCHAR(10), OrderDate, 23) AS FormattedDate
FROM dbo.FactInternetSales;

-- Convert text to a number
SELECT CAST('123' AS INT) AS ConvertedNumber;