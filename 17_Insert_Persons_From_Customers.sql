CREATE TABLE dbo.TrainingPersons (
    id INT PRIMARY KEY,
    person_name NVARCHAR(50),
    birth_date DATE,
    phone VARCHAR(15)
);

INSERT INTO dbo.TrainingPersons (id, person_name, birth_date, phone)
SELECT TOP 3
    CustomerKey,
    FirstName,
    NULL,
    'Unknown'
FROM dbo.DimCustomer
ORDER BY CustomerKey;

SELECT *
FROM dbo.TrainingPersons;
