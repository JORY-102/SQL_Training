USE AdventureWorksDW2022;

-- Retrieve sales with reseller, product, and employee details
SELECT
    s.SalesOrderNumber AS OrderID,
    s.SalesOrderLineNumber AS OrderLine,
    r.ResellerName AS CustomerName,
    p.EnglishProductName AS ProductName,
    s.SalesAmount AS Sales,
    s.UnitPrice AS Price,
    e.FirstName AS SalesPersonFirstName,
    e.LastName AS SalesPersonLastName
FROM dbo.FactResellerSales AS s
LEFT JOIN dbo.DimReseller AS r
ON s.ResellerKey = r.ResellerKey
LEFT JOIN dbo.DimProduct AS p
ON s.ProductKey = p.ProductKey
LEFT JOIN dbo.DimEmployee AS e
ON s.EmployeeKey = e.EmployeeKey;