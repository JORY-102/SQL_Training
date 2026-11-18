-- Keep the latest row for each order
;WITH Orders AS
(
    SELECT
        1 AS OrderID,
        100 AS Sales,
        CAST('2025-01-01' AS DATE) AS CreationDate

    UNION ALL

    SELECT 1, 120, CAST('2025-01-02' AS DATE)

    UNION ALL

    SELECT 2, 80, CAST('2025-01-03' AS DATE)
)
SELECT *
FROM
(
    SELECT
        OrderID,
        Sales,
        CreationDate,
        ROW_NUMBER() OVER
        (
            PARTITION BY OrderID
            ORDER BY CreationDate DESC
        ) AS rn
    FROM Orders
) t
WHERE rn = 1;