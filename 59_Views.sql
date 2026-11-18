-- Create or update the monthly summary view
CREATE OR ALTER VIEW dbo.V_Monthly_Summary AS
SELECT
    DATETRUNC(MONTH, OrderDate) AS OrderMonth,
    SUM(SalesAmount) AS TotalSales,
    COUNT(DISTINCT SalesOrderNumber) AS TotalOrders,
    SUM(OrderQuantity) AS TotalQuantity
FROM dbo.FactInternetSales
GROUP BY DATETRUNC(MONTH, OrderDate);
GO


-- Display the monthly summary
SELECT *
FROM dbo.V_Monthly_Summary
ORDER BY OrderMonth;
GO


-- Create or update the sales details view
CREATE OR ALTER VIEW dbo.V_Order_Details AS
SELECT
    o.SalesOrderNumber,
    o.SalesOrderLineNumber,
    o.OrderDate,
    p.EnglishProductName,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    g.EnglishCountryRegionName AS Country,
    o.SalesAmount,
    o.OrderQuantity
FROM dbo.FactInternetSales o
LEFT JOIN dbo.DimProduct p
    ON o.ProductKey = p.ProductKey
LEFT JOIN dbo.DimCustomer c
    ON o.CustomerKey = c.CustomerKey
LEFT JOIN dbo.DimGeography g
    ON c.GeographyKey = g.GeographyKey;
GO


-- Create a view for sales outside the USA
CREATE OR ALTER VIEW dbo.V_Order_Details_NonUSA AS
SELECT *
FROM dbo.V_Order_Details
WHERE Country <> 'United States';
GO


-- Display sales outside the USA
SELECT *
FROM dbo.V_Order_Details_NonUSA;
GO


-- Delete the monthly view only when needed
-- DROP VIEW dbo.V_Monthly_Summary;