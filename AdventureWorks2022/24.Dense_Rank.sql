/*
DENSE_RANK: is same than RANK.
The difference is the hole for the rank numbers when there is a tie.
The new range will have the following secuential number instead of saving the hole
*/


SELECT BusinessEntityID, Gender, VacationHours,
DENSE_RANK() OVER (PARTITION BY Gender ORDER BY VacationHours DESC) AS RankResult
FROM [HumanResources].[Employee]