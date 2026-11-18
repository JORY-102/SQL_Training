USE AdventureWorksDW2022;
GO

-- Create a rowstore table
SELECT *
INTO dbo.TrainingSales_RS
FROM dbo.FactInternetSales;

CREATE CLUSTERED INDEX idx_TrainingSales_RS
ON dbo.TrainingSales_RS
    (SalesOrderNumber, SalesOrderLineNumber);

-- Create a columnstore table
SELECT *
INTO dbo.TrainingSales_CS
FROM dbo.FactInternetSales;

CREATE CLUSTERED COLUMNSTORE INDEX idx_TrainingSales_CS
ON dbo.TrainingSales_CS;

-- Compare the same calculation
SELECT ProductKey, SUM(SalesAmount) AS TotalSales
FROM dbo.TrainingSales_RS
GROUP BY ProductKey;

SELECT ProductKey, SUM(SalesAmount) AS TotalSales
FROM dbo.TrainingSales_CS
GROUP BY ProductKey;

-- Drop the clustered columnstore index
DROP INDEX idx_TrainingSales_CS
ON dbo.TrainingSales_CS;

-- Create a nonclustered columnstore index
CREATE NONCLUSTERED COLUMNSTORE INDEX idx_TrainingSales_NCS
ON dbo.TrainingSales_CS (ProductKey, SalesAmount);