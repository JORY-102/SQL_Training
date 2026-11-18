-- Show customer sales and latest order date
;WITH CustomerSales AS
(
    SELECT
        CustomerKey,
        SUM(SalesAmount) AS TotalSales
    FROM dbo.FactInternetSales
    GROUP BY CustomerKey
),
LastOrders AS
(
    SELECT
        CustomerKey,
        MAX(OrderDate) AS LastOrderDate
    FROM dbo.FactInternetSales
    GROUP BY CustomerKey
)
SELECT
    c.CustomerKey,
    c.FirstName,
    s.TotalSales,
    o.LastOrderDate
FROM dbo.DimCustomer c
LEFT JOIN CustomerSales s
    ON c.CustomerKey = s.CustomerKey
LEFT JOIN LastOrders o
    ON c.CustomerKey = o.CustomerKey;


-- Show employee hierarchy
;WITH EmployeeHierarchy AS
(
    SELECT
        EmployeeKey,
        FirstName,
        ParentEmployeeKey,
        1 AS EmployeeLevel
    FROM dbo.DimEmployee
    WHERE ParentEmployeeKey IS NULL

    UNION ALL

    SELECT
        e.EmployeeKey,
        e.FirstName,
        e.ParentEmployeeKey,
        h.EmployeeLevel + 1
    FROM dbo.DimEmployee e
    JOIN EmployeeHierarchy h
        ON e.ParentEmployeeKey = h.EmployeeKey
)
SELECT *
FROM EmployeeHierarchy
ORDER BY EmployeeLevel, EmployeeKey;