SELECT
    MaritalStatus,
    SUM(NumberCarsOwned) AS TotalCars,
    COUNT(CustomerKey) AS TotalCustomers
FROM dbo.DimCustomer
GROUP BY MaritalStatus;