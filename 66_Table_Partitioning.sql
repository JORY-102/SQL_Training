-- Define date boundaries
CREATE PARTITION FUNCTION TrainingPartitionByYear (DATE)
AS RANGE RIGHT FOR VALUES
('20240101', '20250101', '20260101');

-- Assign partitions to storage
CREATE PARTITION SCHEME TrainingPartitionScheme
AS PARTITION TrainingPartitionByYear
ALL TO ([PRIMARY]);

-- Create a partitioned training table
CREATE TABLE dbo.TrainingPartitionOrders (
    OrderID INT,
    OrderDate DATE,
    Sales INT
)
ON TrainingPartitionScheme (OrderDate);

-- Insert sample data
INSERT INTO dbo.TrainingPartitionOrders
    (OrderID, OrderDate, Sales)
VALUES
    (1, '20230515', 100),
    (2, '20240720', 50),
    (3, '20251231', 20),
    (4, '20260101', 20);

-- Show the partition for each row
SELECT
    OrderID,
    OrderDate,
    Sales,
    $PARTITION.TrainingPartitionByYear(OrderDate) AS PartitionNumber
FROM dbo.TrainingPartitionOrders;

-- Filter by date
SELECT *
FROM dbo.TrainingPartitionOrders
WHERE OrderDate = '20260101';