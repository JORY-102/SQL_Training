-- Create or update the customer summary procedure
CREATE OR ALTER PROCEDURE dbo.GetCustomerSummary
    @Country NVARCHAR(50) = N'United States'
AS
BEGIN
    BEGIN TRY
        DECLARE @TotalCustomers INT;
        DECLARE @AvgCars DECIMAL(10,2);

        -- Copy customers from the selected country
        SELECT
            c.CustomerKey,
            c.NumberCarsOwned
        INTO #Customers
        FROM dbo.DimCustomer c
        JOIN dbo.DimGeography g
            ON c.GeographyKey = g.GeographyKey
        WHERE g.EnglishCountryRegionName = @Country;

        -- Replace missing values in the temporary copy
        IF EXISTS
        (
            SELECT 1
            FROM #Customers
            WHERE NumberCarsOwned IS NULL
        )
        BEGIN
            UPDATE #Customers
            SET NumberCarsOwned = 0
            WHERE NumberCarsOwned IS NULL;

            PRINT 'Missing values replaced with 0';
        END
        ELSE
        BEGIN
            PRINT 'No missing values found';
        END;

        -- Calculate customer statistics
        SELECT
            @TotalCustomers = COUNT(*),
            @AvgCars = AVG(CAST(NumberCarsOwned AS DECIMAL(10,2)))
        FROM #Customers;

        PRINT CONCAT('Country: ', @Country);

        SELECT
            @TotalCustomers AS TotalCustomers,
            @AvgCars AS AvgCars;

        -- Calculate orders and sales for these customers
        SELECT
            COUNT(DISTINCT o.SalesOrderNumber) AS TotalOrders,
            SUM(o.SalesAmount) AS TotalSales
        FROM dbo.FactInternetSales o
        JOIN #Customers c
            ON o.CustomerKey = c.CustomerKey;
    END TRY

    BEGIN CATCH
        SELECT
            ERROR_MESSAGE() AS ErrorMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_LINE() AS ErrorLine,
            ERROR_PROCEDURE() AS ErrorProcedure;
    END CATCH
END;
GO

-- Run with the default country
EXEC dbo.GetCustomerSummary;

-- Run for Germany
EXEC dbo.GetCustomerSummary @Country = N'Germany';