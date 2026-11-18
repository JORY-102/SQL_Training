-- Find names shared by customers and employees
SELECT
    FirstName,
    LastName
FROM dbo.DimCustomer

INTERSECT

SELECT
    FirstName,
    LastName
FROM dbo.DimEmployee;
