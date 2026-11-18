-- Divide sales lines into groups
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    SalesAmount,
    NTILE(4) OVER (ORDER BY SalesAmount DESC) AS FourGroups,
    NTILE(3) OVER (ORDER BY SalesAmount DESC) AS ThreeGroups,
    NTILE(2) OVER (ORDER BY SalesAmount DESC) AS TwoGroups
FROM dbo.FactInternetSales
ORDER BY SalesAmount DESC;


-- Classify sales lines as high, medium, or low
SELECT
    *,
    CASE
        WHEN Bucket = 1 THEN 'High'
        WHEN Bucket = 2 THEN 'Medium'
        ELSE 'Low'
    END AS SalesCategory
FROM
(
    SELECT
        SalesOrderNumber,
        SalesOrderLineNumber,
        SalesAmount,
        NTILE(3) OVER (ORDER BY SalesAmount DESC) AS Bucket
    FROM dbo.FactInternetSales
) t
ORDER BY Bucket, SalesAmount DESC;


-- Filter products by their relative price rank
SELECT
    *,
    CONCAT(ROUND(PriceRank * 100, 2), '%') AS RankPercentage
FROM
(
    SELECT
        ProductKey,
        EnglishProductName,
        ListPrice,
        PERCENT_RANK() OVER
        (
            ORDER BY ListPrice DESC
        ) AS PriceRank
    FROM dbo.DimProduct
    WHERE ListPrice IS NOT NULL
) t
WHERE PriceRank <= 0.4
ORDER BY ListPrice DESC;