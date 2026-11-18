SELECT *
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M';

SELECT *
FROM dbo.DimCustomer
WHERE MaritalStatus != 'M';

SELECT *
FROM dbo.DimCustomer
WHERE NumberCarsOwned > 2;

SELECT *
FROM dbo.DimCustomer
WHERE NumberCarsOwned >= 2;

SELECT *
FROM dbo.DimCustomer
WHERE NumberCarsOwned < 2;

SELECT *
FROM dbo.DimCustomer
WHERE NumberCarsOwned <= 2;