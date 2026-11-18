SELECT MaritalStatus, SUM(NumberCarsOwned) AS TotalCars
FROM dbo.DimCustomer
GROUP BY MaritalStatus;