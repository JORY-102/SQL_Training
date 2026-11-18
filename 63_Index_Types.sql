USE AdventureWorksDW2022;
GO

-- Copy customer data
SELECT
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    g.EnglishCountryRegionName AS Country,
    c.NumberCarsOwned
INTO dbo.TrainingIndexCustomers
FROM dbo.DimCustomer c
LEFT JOIN dbo.DimGeography g
    ON c.GeographyKey = g.GeographyKey;

-- Create a clustered index
CREATE CLUSTERED INDEX idx_TrainingCustomer_Key
ON dbo.TrainingIndexCustomers (CustomerKey);

-- Drop the index
DROP INDEX idx_TrainingCustomer_Key
ON dbo.TrainingIndexCustomers;

-- Create a unique clustered index
CREATE UNIQUE CLUSTERED INDEX idx_TrainingCustomer_Key
ON dbo.TrainingIndexCustomers (CustomerKey);

-- Create a nonclustered index
CREATE NONCLUSTERED INDEX idx_TrainingCustomer_LastName
ON dbo.TrainingIndexCustomers (LastName);

SELECT *
FROM dbo.TrainingIndexCustomers
WHERE LastName = 'Brown';

-- Create another nonclustered index
CREATE INDEX idx_TrainingCustomer_FirstName
ON dbo.TrainingIndexCustomers (FirstName);

-- Create a composite index
CREATE INDEX idx_TrainingCustomer_CountryCars
ON dbo.TrainingIndexCustomers (Country, NumberCarsOwned);

SELECT *
FROM dbo.TrainingIndexCustomers
WHERE Country = 'United States'
  AND NumberCarsOwned > 1;

-- Create a filtered index
CREATE NONCLUSTERED INDEX idx_TrainingCustomer_US
ON dbo.TrainingIndexCustomers (Country)
WHERE Country = N'United States';

SELECT *
FROM dbo.TrainingIndexCustomers
WHERE Country = N'United States';

-- List indexes
EXEC sp_helpindex 'dbo.TrainingIndexCustomers';