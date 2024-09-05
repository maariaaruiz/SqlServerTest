-- should be in unique index

-- Create index of fulltext in Name Column
DECLARE @StartTime DATETIME, @EndTime DATETIME;
SET @StartTime = GETDATE();

--Search with CONTAINS
SELECT SalesReasonID, Name, ReasonType, ModifiedDate
FROM [Sales].[SalesReason]
WHERE CONTAINS(Name, 'Television');

SELECT DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS ExecutionTimeMs;
--searches for documents containing the word ‘Customer’ in the column Name


-- Search with FREETEXT
SELECT SalesReasonID, Name, ReasonType, ModifiedDate
FROM [Sales].[SalesReason]
WHERE FREETEXT(Name, 'Event');

-- Search with CONTAINSTABLE
SELECT SalesReasonID, Name, ReasonType, ModifiedDate, KeyTbl.RANK
FROM CONTAINSTABLE([Sales].[SalesReason], Name, 'Review')
AS KeyTbl
JOIN [Sales].[SalesReason] ON [Sales].[SalesReason].SalesReasonID = KeyTbl.[KEY];

-- Search with FREETEXTTABLE
SELECT SalesReasonID, Name, ReasonType, ModifiedDate, KeyTbl.RANK
FROM FREETEXTTABLE([Sales].[SalesReason], Name, 'quality')
AS KeyTbl
JOIN [Sales].[SalesReason] ON [Sales].[SalesReason].SalesReasonID = KeyTbl.[KEY];



