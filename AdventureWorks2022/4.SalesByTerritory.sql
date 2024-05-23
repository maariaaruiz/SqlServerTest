SELECT sty.Name, 
SUM(soh.TotalDue) TotalSales
FROM Sales.SalesTerritory sty
    INNER JOIN Sales.SalesTerritoryHistory sth 
        ON sth.TerritoryID = sty.TerritoryID
    INNER JOIN Sales.SalesPerson ssp 
        ON ssp.BusinessEntityID = sth.BusinessEntityID 
        AND ssp.TerritoryID = sth.TerritoryID
    INNER join Sales.SalesOrderHeader soh ON soh.SalesPersonID = ssp.BusinessEntityID
GROUP BY STY.Name