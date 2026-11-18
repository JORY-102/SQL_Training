-- 1. Combine the customer's first name and country
SELECT
    c.FirstName,
    g.EnglishCountryRegionName AS Country,
    CONCAT(c.FirstName, ' ', g.EnglishCountryRegionName) AS NameCountry
FROM dbo.DimCustomer AS c
LEFT JOIN dbo.DimGeography AS g
ON c.GeographyKey = g.GeographyKey;


-- 2. Convert first names to lowercase and uppercase
SELECT
    FirstName,
    LOWER(FirstName) AS LowerName,
    UPPER(FirstName) AS UpperName
FROM dbo.DimCustomer;


-- 3. Find first names with leading or trailing spaces
SELECT
    FirstName,
    TRIM(FirstName) AS CleanName
FROM dbo.DimCustomer
WHERE DATALENGTH(FirstName) != DATALENGTH(TRIM(FirstName));


-- 4. Remove dashes from a phone number
SELECT
    '123-456-7890' AS Phone,
    REPLACE('123-456-7890', '-', '') AS CleanPhone;


-- 5. Calculate the length of each first name
SELECT
    FirstName,
    LEN(FirstName) AS NameLength
FROM dbo.DimCustomer;


-- 6. Retrieve the first two characters
SELECT
    FirstName,
    LEFT(FirstName, 2) AS FirstTwoCharacters
FROM dbo.DimCustomer;


-- 7. Retrieve the last two characters
SELECT
    FirstName,
    RIGHT(FirstName, 2) AS LastTwoCharacters
FROM dbo.DimCustomer;


-- 8. Remove the first character from each trimmed first name
SELECT
    FirstName,
    SUBSTRING(TRIM(FirstName), 2, LEN(TRIM(FirstName))) AS SubName
FROM dbo.DimCustomer;