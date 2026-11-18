-- Show products and the total number of orders
SELECT
    ProductKey,
    EnglishProductName,
    ListPrice,
    (SELECT COUNT(DISTINCT SalesOrderNumber)
     FROM dbo.FactInternetSales) AS TotalOrders
FROM dbo.DimProduct;


-- Find products priced above average
SELECT
    ProductKey,
    EnglishProductName,
    ListPrice
FROM dbo.DimProduct
WHERE ListPrice >
(
    SELECT AVG(ListPrice)
    FROM dbo.DimProduct
);


-- Count orders for each customer
SELECT
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    (SELECT COUNT(DISTINCT o.SalesOrderNumber)
     FROM dbo.FactInternetSales o
     WHERE o.CustomerKey = c.CustomerKey) AS TotalOrders
FROM dbo.DimCustomer c;


-- Find sales for customers in Germany
SELECT
    SalesOrderNumber,
    CustomerKey,
    SalesAmount
FROM dbo.FactInternetSales
WHERE CustomerKey IN
(
    SELECT c.CustomerKey
    FROM dbo.DimCustomer c
    JOIN dbo.DimGeography g
        ON c.GeographyKey = g.GeographyKey
    WHERE g.EnglishCountryRegionName = 'Germany'
);


-- Find sales without a matching German customer
SELECT
    o.SalesOrderNumber,
    o.CustomerKey,
    o.SalesAmount
FROM dbo.FactInternetSales o
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.DimCustomer c
    JOIN dbo.DimGeography g
        ON c.GeographyKey = g.GeographyKey
    WHERE c.CustomerKey = o.CustomerKey
      AND g.EnglishCountryRegionName = 'Germany'
);


-- Compare female employees' pay rates with male employees
SELECT
    EmployeeKey,
    FirstName,
    BaseRate
FROM dbo.DimEmployee
WHERE Gender = 'F'
  AND BaseRate > ANY
(
    SELECT BaseRate
    FROM dbo.DimEmployee
    WHERE Gender = 'M'
);