-- 4. Extract parts of the order date
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    DAY(OrderDate) AS OrderDay,
    DATEPART(year, OrderDate) AS Year_dp,
    DATEPART(month, OrderDate) AS Month_dp,
    DATEPART(day, OrderDate) AS Day_dp,
    DATEPART(hour, OrderDate) AS Hour_dp,
    DATEPART(quarter, OrderDate) AS Quarter_dp,
    DATEPART(week, OrderDate) AS Week_dp
FROM dbo.FactInternetSales;
