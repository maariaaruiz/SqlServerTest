
/*FETCH is used in combination with OFFSET for recover 
a subset of rows in a query (useful for pagination results).*/


SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
OFFSET 0 ROWS      -- not skip rows (page 1)
FETCH NEXT 5 ROWS ONLY;


SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
OFFSET 5 ROWS    -- skip the first 5 rows
FETCH NEXT 5 ROWS ONLY;  -- get the next 5 rows


SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
OFFSET 10 ROWS    -- skip the first 10 rows
FETCH NEXT 5 ROWS ONLY;  -- get the next 5 rows


SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
OFFSET 10 ROWS; -- not use FETCh, get all the rest, when ommit some


--can declare varibales
DECLARE @PageNumber INT = 3;  -- actual page (start in 1)
DECLARE @RowsPerPage INT = 5; 

SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
OFFSET (@PageNumber - 1) * @RowsPerPage ROWS    -- skip the first 10 rows
FETCH NEXT @RowsPerPage ROWS ONLY; 
