/* A filtered index is a type of non-clustered index that applies only
 to a subset of the rows in a table, based on a defined filter condition. */

-- create index in state column
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_Status_5
ON [Sales].[SalesOrderHeader] (OrderDate)
WHERE [Status] = 5;
GO

SET SHOWPLAN_ALL ON;
GO
--query of order with state 5, that uses the filter index
SELECT SalesOrderID, OrderDate, TotalDue
FROM [Sales].[SalesOrderHeader]
WHERE [Status] = 5
ORDER BY OrderDate;
GO

SET SHOWPLAN_ALL OFF;
GO

/* Benefits:

 - Faster queries: only includes rows of the filter
 - Less disk space: index is smaller
 - Lower maintenance cost: insert and update on non-pending rows not affect this index
*/