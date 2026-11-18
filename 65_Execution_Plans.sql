USE AdventureWorksDW2022;
GO

-- Create a heap table
SELECT *
INTO dbo.TrainingResellerSales
FROM dbo.FactResellerSales;

-- Check the scan and sort
SELECT *
FROM dbo.TrainingResellerSales
ORDER BY SalesOrderNumber;

-- Create a clustered index
CREATE CLUSTERED INDEX idx_TrainingReseller_Order
ON dbo.TrainingResellerSales
    (SalesOrderNumber, SalesOrderLineNumber);

-- Run again and compare the plan
SELECT *
FROM dbo.TrainingResellerSales
ORDER BY SalesOrderNumber;

-- Check the plan before adding an index
SELECT *
FROM dbo.TrainingResellerSales
WHERE CarrierTrackingNumber = N'4911-403C-98';

-- Add a nonclustered index
CREATE NONCLUSTERED INDEX idx_TrainingReseller_Tracking
ON dbo.TrainingResellerSales (CarrierTrackingNumber);

-- Run again and compare the plan
SELECT *
FROM dbo.TrainingResellerSales
WHERE CarrierTrackingNumber = N'4911-403C-98';