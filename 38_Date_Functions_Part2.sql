-- 5. Extract month and weekday names
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    DATENAME(month, OrderDate) AS MonthName,
    DATENAME(weekday, OrderDate) AS WeekdayName
FROM dbo.FactInternetSales;


-- 6. Truncate the date to the minute and day
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    DATETRUNC(minute, OrderDate) AS MinuteStart,
    DATETRUNC(day, OrderDate) AS DayStart
FROM dbo.FactInternetSales;


-- 7. Count sales rows by month
SELECT
    DATETRUNC(month, OrderDate) AS MonthStart,
    COUNT(*) AS TotalSalesRows
FROM dbo.FactInternetSales
GROUP BY DATETRUNC(month, OrderDate)
ORDER BY MonthStart;


-- 8. Count sales rows by year
SELECT
    DATETRUNC(year, OrderDate) AS YearStart,
    COUNT(*) AS TotalSalesRows
FROM dbo.FactInternetSales
GROUP BY DATETRUNC(year, OrderDate)
ORDER BY YearStart;


-- 9. Display the start and end of each month
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    EOMONTH(OrderDate) AS EndMonth,
    DATETRUNC(month, OrderDate) AS StartMonth,
    CAST(DATETRUNC(month, OrderDate) AS DATE) AS StartOfMonth
FROM dbo.FactInternetSales;