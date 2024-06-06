USE AdventureWorks2022;
GO

WITH
    SalesCTE
    AS
    (
        -- Calculate total sales for each person sale in 2014
        SELECT
            soh.SalesPersonID,
            per.FirstName,
            SUM(p.ListPrice * s.OrderQty) AS TotalSales
        FROM Sales.SalesOrderDetail s
            INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = s.SalesOrderID
            INNER JOIN Person.Person per ON per.BusinessEntityID = soh.SalesPersonID
            INNER JOIN Production.Product p ON s.ProductID = p.ProductID
        WHERE 
        YEAR(soh.OrderDate) = 2014
        GROUP BY 
        soh.SalesPersonID,
        per.FirstName
    ),
    ProductCountCTE
    AS
    (
        -- Calculate the number of different products sold by each person sale in 2014
        SELECT
            soh.SalesPersonID,
            COUNT(DISTINCT s.ProductID) AS ProductCount
        FROM
            Sales.SalesOrderDetail s
            INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = s.SalesOrderID

        WHERE 
        YEAR(soh.OrderDate) = 2014
            AND SalesPersonID IS NOT NULL
        GROUP BY 
        soh.SalesPersonID
    )
-- Final query to combine the results from the CTEs
SELECT
    sc.SalesPersonID,
    sc.FirstName,
    sc.TotalSales,
    pc.ProductCount
FROM
    SalesCTE sc
    JOIN ProductCountCTE pc ON sc.SalesPersonID = pc.SalesPersonID
WHERE 
    sc.TotalSales > 1000000;
GO
