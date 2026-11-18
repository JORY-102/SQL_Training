-- 1. Display dates in different formats
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    FORMAT(OrderDate, 'MM-dd-yyyy', 'en-US') AS USA_Format,
    FORMAT(OrderDate, 'dd', 'en-US') AS DayNumber,
    FORMAT(OrderDate, 'ddd', 'en-US') AS ShortDayName,
    FORMAT(OrderDate, 'dddd', 'en-US') AS FullDayName,
    FORMAT(OrderDate, 'MM', 'en-US') AS MonthNumber,
    FORMAT(OrderDate, 'MMM', 'en-US') AS ShortMonthName,
    FORMAT(OrderDate, 'MMMM', 'en-US') AS FullMonthName
FROM dbo.FactInternetSales;


-- 2. Count sales rows by formatted month and year
SELECT
    FORMAT(OrderDate, 'MMM yy', 'en-US') AS MonthYear,
    COUNT(*) AS TotalSalesRows
FROM dbo.FactInternetSales
GROUP BY FORMAT(OrderDate, 'MMM yy', 'en-US')
ORDER BY MIN(OrderDate);