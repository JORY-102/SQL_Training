-- Standardize NULL, empty strings, and spaces
;WITH Orders AS (
    SELECT 1 AS ID, 'A' AS Category
    UNION ALL
    SELECT 2, NULL
    UNION ALL
    SELECT 3, ''
    UNION ALL
    SELECT 4, '  '
)
SELECT
    ID,
    Category,
    DATALENGTH(Category) AS OriginalBytes,
    TRIM(Category) AS TrimmedCategory,
    NULLIF(TRIM(Category), '') AS EmptyToNull,
    COALESCE(NULLIF(TRIM(Category), ''), 'Unknown') AS CleanCategory
FROM Orders
ORDER BY ID;