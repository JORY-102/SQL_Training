-- Validate date strings and replace invalid values
SELECT
    OrderDate,
    ISDATE(OrderDate) AS IsValidDate,
    CASE
        WHEN ISDATE(OrderDate) = 1
            THEN CAST(OrderDate AS DATE)
        ELSE CAST('99990101' AS DATE)
    END AS NewOrderDate
FROM (
    SELECT '20250820' AS OrderDate
    UNION ALL
    SELECT '20250821'
    UNION ALL
    SELECT '20250823'
    UNION ALL
    SELECT 'Not a date'
) AS t;