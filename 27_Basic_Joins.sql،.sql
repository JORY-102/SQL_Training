SELECT *
FROM dbo.DimCustomer;

SELECT *
FROM dbo.FactInternetSales;


SELECT
    c.CustomerKey,
    c.FirstName,
    s.SalesOrderNumber,
    s.SalesAmount
FROM dbo.DimCustomer AS c
INNER JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey;


SELECT
    c.CustomerKey,
    c.FirstName,
    s.SalesOrderNumber,
    s.SalesAmount
FROM dbo.DimCustomer AS c
LEFT JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey;


SELECT
    c.CustomerKey,
    c.FirstName,
    s.SalesOrderNumber,
    s.SalesAmount
FROM dbo.DimCustomer AS c
RIGHT JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey;


SELECT
    c.CustomerKey,
    c.FirstName,
    s.SalesOrderNumber,
    s.SalesAmount
FROM dbo.DimCustomer AS c
FULL JOIN dbo.FactInternetSales AS s
ON c.CustomerKey = s.CustomerKey;