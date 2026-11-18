-- 1. First name starts with M
SELECT FirstName
FROM dbo.DimCustomer
WHERE FirstName LIKE 'M%';

-- 2. First name ends with n
SELECT FirstName
FROM dbo.DimCustomer
WHERE FirstName LIKE '%n';

-- 3. First name contains r
SELECT FirstName
FROM dbo.DimCustomer
WHERE FirstName LIKE '%r%';

-- 4. Third letter is r
SELECT FirstName
FROM dbo.DimCustomer
WHERE FirstName LIKE '__r%';
