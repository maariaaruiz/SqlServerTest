
-- query to obtain products quantity sale order DESC
SELECT prd.ProductID,
       prd.Name,
       SUM(sod.OrderQty) ProductTotalQuantitySale
FROM Production.Product prd
    LEFT JOIN Sales.SalesOrderDetail sod ON sod.ProductID = prd.ProductID
GROUP BY prd.ProductID, prd.Name
ORDER BY ProductTotalQuantitySale DESC
