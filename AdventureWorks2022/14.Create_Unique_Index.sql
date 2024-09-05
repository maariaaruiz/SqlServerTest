
--Unique index
CREATE UNIQUE NONCLUSTERED INDEX IX_Employee_NationalIDNumber
ON [HumanResources].[Employee] (NationalIDNumber);
