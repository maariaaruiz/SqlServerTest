
/* LIMIT and OFFSET uses to paginate results.
 Divide the results of query in smaller pages.

 Not valid to SQL SERVER
*/

SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
LIMIT 5 OFFSET 10;

SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate
LIMIT 10, 5; --with due arguments ( first ommit, second get)