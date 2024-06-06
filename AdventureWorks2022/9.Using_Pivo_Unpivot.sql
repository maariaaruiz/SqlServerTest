-- get customw where buy products in may of years 2011, 2012, 2014 and the price by date of months with PIVOT

USE AdventureWorks2022;
GO

SELECT 
    PersonName,
    [2011-05] AS May2011,
    [2012-05] AS May2012,
    [2014-05] AS May2014
FROM 
    (
        SELECT 
            per.FirstName as PersonName,
            FORMAT(sod.OrderDate, 'yyyy-MM') AS SaleMonth,
            sod.TotalDue As TotalDue

        FROM 
            Sales.SalesOrderHeader sod 
            INNER JOIN Sales.Customer cst ON cst.CustomerID = sod.CustomerID
            INNER JOIN Person.Person per ON per.BusinessEntityID = cst.PersonID
    ) AS SourceTable
PIVOT
    (
        SUM(TotalDue)
        FOR SaleMonth IN ([2011-05], [2012-05], [2014-05])
    ) AS PivotTable;


-- get with UNPIVOT the dates by type of sales dates for orders

USE AdventureWorks2022;
GO

SELECT 
    SalesOrderID,
    TypeDate,
    Dates
FROM 
    Sales.SalesOrderHeader
UNPIVOT
    (
        Dates FOR TypeDate IN (OrderDate, DueDate, ShipDate)
    ) AS UnpivotedTable;
GO
