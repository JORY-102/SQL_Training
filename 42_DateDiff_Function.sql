-- 1. Calculate approximate employee age
SELECT
    EmployeeKey AS EmployeeID,
    BirthDate,
    DATEDIFF(year, BirthDate, GETDATE()) AS ApproxAge
FROM dbo.DimEmployee;


-- 2. Calculate shipping duration in days
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate,
    ShipDate,
    DATEDIFF(day, OrderDate, ShipDate) AS DaysToShip
FROM dbo.FactInternetSales;


-- 3. Calculate average shipping duration per month
SELECT
    DATETRUNC(month, OrderDate) AS MonthStart,
    AVG(
        CAST(DATEDIFF(day, OrderDate, ShipDate) AS DECIMAL(10, 2))
    ) AS AvgShippingDays
FROM (
    SELECT DISTINCT
        SalesOrderNumber,
        OrderDate,
        ShipDate
    FROM dbo.FactInternetSales
) AS Orders
GROUP BY DATETRUNC(month, OrderDate)
ORDER BY MonthStart;


-- 4. Calculate days between consecutive orders
SELECT
    SalesOrderNumber AS OrderID,
    OrderDate AS CurrentOrderDate,
    LAG(OrderDate) OVER (
        ORDER BY OrderDate, SalesOrderNumber
    ) AS PreviousOrderDate,
    DATEDIFF(
        day,
        LAG(OrderDate) OVER (
            ORDER BY OrderDate, SalesOrderNumber
        ),
        OrderDate
    ) AS DaysBetweenOrders
FROM (
    SELECT DISTINCT
        SalesOrderNumber,
        OrderDate
    FROM dbo.FactInternetSales
) AS Orders
ORDER BY OrderDate, SalesOrderNumber;