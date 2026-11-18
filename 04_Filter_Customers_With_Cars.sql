-- Retrieve customers whose number of cars owned is not equal to 0
SELECT *
FROM dbo.DimCustomer
WHERE NumberCarsOwned != 0;