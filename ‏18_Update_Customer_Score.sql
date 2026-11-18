UPDATE dbo.TrainingCustomers
SET score = 0
WHERE score IS NULL;

SELECT *
FROM dbo.TrainingCustomers
WHERE score IS NULL;