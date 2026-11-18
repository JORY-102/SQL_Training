SELECT *
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M' AND NumberCarsOwned > 2;

SELECT *
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M' OR NumberCarsOwned > 2;

SELECT *
FROM dbo.DimCustomer
WHERE NOT (NumberCarsOwned < 2);