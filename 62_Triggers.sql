USE AdventureWorksDW2022;
GO

-- Create a training table
SELECT EmployeeKey, FirstName, LastName
INTO dbo.TrainingEmployees
FROM dbo.DimEmployee;

-- Create a log table
CREATE TABLE dbo.TrainingEmployeeLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeKey INT,
    LogMessage VARCHAR(255),
    LogDate DATETIME
);
GO

-- Log new employees
CREATE TRIGGER trg_AfterInsertTrainingEmployee
ON dbo.TrainingEmployees
AFTER INSERT
AS
BEGIN
    INSERT INTO dbo.TrainingEmployeeLogs
        (EmployeeKey, LogMessage, LogDate)
    SELECT
        EmployeeKey,
        'New Employee Added = ' + CAST(EmployeeKey AS VARCHAR(20)),
        GETDATE()
    FROM inserted;
END;
GO

-- Test the trigger
INSERT INTO dbo.TrainingEmployees (FirstName, LastName)
VALUES ('Maria', 'Doe');

-- Check the results
SELECT * FROM dbo.TrainingEmployeeLogs;