-- 1. Employee names not found among customers
SELECT
    FirstName,
    LastName
FROM dbo.DimEmployee

EXCEPT

SELECT
    FirstName,
    LastName
FROM dbo.DimCustomer;


-- 2. Customer names not found among employees
SELECT
    FirstName,
    LastName
FROM dbo.DimCustomer

EXCEPT

SELECT
    FirstName,
    LastName
FROM dbo.DimEmployee;