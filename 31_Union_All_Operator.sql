-- Combine employee and customer names including duplicates
SELECT
    FirstName,
    LastName
FROM dbo.DimEmployee

UNION ALL

SELECT
    FirstName,
    LastName
FROM dbo.DimCustomer;
