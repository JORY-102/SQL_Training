CREATE TABLE dbo.TrainingCustomers (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    country VARCHAR(50),
    score INT
);

INSERT INTO dbo.TrainingCustomers (id, first_name, country, score)
VALUES
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100);

SELECT *
FROM dbo.TrainingCustomers;