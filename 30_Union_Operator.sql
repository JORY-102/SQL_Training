-- 1. Combine customer and employee names
SELECT
    FirstName,
    LastName
FROM dbo.DimCustomer

UNION

SELECT
    FirstName,
    LastName
FROM dbo.DimEmployee;


-- 2. Combine customer and employee keys with last names
SELECT
    CustomerKey,
    LastName
FROM dbo.DimCustomer

UNION

SELECT
    EmployeeKey,
    LastName
FROM dbo.DimEmployee;


-- 3. Combine results with clear column names
SELECT
    CustomerKey AS ID,
    LastName AS [Last Name]
FROM dbo.DimCustomer

UNION

SELECT
    EmployeeKey,
    LastName
FROM dbo.DimEmployee;