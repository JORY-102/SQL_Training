-- Sample data for NULL-handling exercises
DECLARE @Customers TABLE (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Score INT
);

INSERT INTO @Customers
VALUES
    (1, 'Jossef', 'Goldberg', 350),
    (2, 'Kevin', 'Brown', 900),
    (3, 'Mary', NULL, 750),
    (4, 'Mark', 'Schwarz', 500),
    (5, 'Anna', 'Adams', NULL);


-- 1. Replace NULL scores
SELECT
    CustomerID,
    Score,
    ISNULL(Score, 0) AS Score_ISNULL,
    COALESCE(Score, 0) AS Score_COALESCE
FROM @Customers;


-- 2. Compare averages with and without replacing NULL
SELECT
    CustomerID,
    Score,
    AVG(CAST(Score AS DECIMAL(10, 2))) OVER () AS AvgIgnoringNull,
    AVG(CAST(COALESCE(Score, 0) AS DECIMAL(10, 2)))
        OVER () AS AvgIncludingZero
FROM @Customers;


-- 3. Handle NULL before combining names and adding a bonus
SELECT
    CustomerID,
    FirstName + ' ' + COALESCE(LastName, '') AS FullName,
    Score,
    COALESCE(Score, 0) + 10 AS ScoreWithBonus
FROM @Customers;


-- 4. Sort scores in ascending order with NULL last
SELECT
    CustomerID,
    Score
FROM @Customers
ORDER BY
    CASE WHEN Score IS NULL THEN 1 ELSE 0 END,
    Score;


-- 5. Match NULL types when this is the intended join rule
SELECT
    a.OrderYear,
    a.OrderType,
    a.OrderCount,
    b.Sales
FROM (
    VALUES
        (2024, 'a', 30),
        (2024, NULL, 40),
        (2025, 'b', 50),
        (2025, NULL, 60)
) AS a(OrderYear, OrderType, OrderCount)
INNER JOIN (
    VALUES
        (2024, 'a', 100),
        (2024, NULL, 200),
        (2025, 'b', 300),
        (2025, NULL, 200)
) AS b(OrderYear, OrderType, Sales)
    ON a.OrderYear = b.OrderYear
    AND (
        a.OrderType = b.OrderType
        OR (a.OrderType IS NULL AND b.OrderType IS NULL)
    );


-- 6. Prevent division by zero in sales data
SELECT
    SalesOrderNumber AS OrderID,
    SalesOrderLineNumber,
    SalesAmount,
    OrderQuantity,
    SalesAmount / NULLIF(OrderQuantity, 0) AS SalesPerUnit
FROM dbo.FactInternetSales;