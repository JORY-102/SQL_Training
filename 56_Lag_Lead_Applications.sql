-- Compare monthly sales with the previous month
SELECT
    *,
    CurrentSales - PreviousSales AS SalesChange,
    ROUND(
        100.0 * (CurrentSales - PreviousSales)
        / NULLIF(PreviousSales, 0),
        1
    ) AS ChangePercentage
FROM
(
    SELECT
        YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth,
        SUM(SalesAmount) AS CurrentSales,
        LAG(SUM(SalesAmount)) OVER
        (
            ORDER BY YEAR(OrderDate), MONTH(OrderDate)
        ) AS PreviousSales
    FROM dbo.FactInternetSales
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
) t
ORDER BY OrderYear, OrderMonth;


-- Rank customers by average days between orders
;WITH CustomerOrders AS
(
    SELECT DISTINCT
        CustomerKey,
        SalesOrderNumber,
        OrderDate
    FROM dbo.FactInternetSales
),
OrderGaps AS
(
    SELECT
        CustomerKey,
        DATEDIFF(
            DAY,
            OrderDate,
            LEAD(OrderDate) OVER
            (
                PARTITION BY CustomerKey
                ORDER BY OrderDate, SalesOrderNumber
            )
        ) AS DaysUntilNextOrder
    FROM CustomerOrders
)
SELECT
    CustomerKey,
    AVG(1.0 * DaysUntilNextOrder) AS AvgDays,
    RANK() OVER
    (
        ORDER BY COALESCE(AVG(1.0 * DaysUntilNextOrder), 999999)
    ) AS CustomerRank
FROM OrderGaps
GROUP BY CustomerKey
ORDER BY CustomerRank, CustomerKey;