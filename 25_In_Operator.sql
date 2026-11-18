SELECT FirstName, NumberCarsOwned
FROM dbo.DimCustomer
WHERE NumberCarsOwned IN (1, 3);
