
/* When the optimiser does not choose the optimal index:

Sometimes, the optimiser may make a sub-optimal index selection, 
especially if there are recent changes in the data or outdated statistics.

Such as high-performance queries where response time is crucial (e.g., in transactional systems).

If you have multiple indexes and SQL Server chooses one that causes unnecessary 
table scanning (e.g., in large tables), you could force a more appropriate index. */

-- activate stadistics of time and E/S
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

--query withou force index
SELECT SalesReasonID, Name, ReasonType
FROM [Sales].[SalesReason]
WHERE Name = 'On Promotion';

-- desactivate stadistics
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;


-- activate stadistics of time and E/S
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- force the index
SELECT SalesReasonID, Name, ReasonType
FROM [Sales].[SalesReason]
WITH (INDEX(IX_SalesReason_Name))  
WHERE Name = 'On Promotion';

-- desactivate stadistics
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

