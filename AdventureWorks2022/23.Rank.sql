/*
RANK is used to asing the rank for each row in a partition
of a subset of results, based on the order of a specific column.

It is useful for sorting data and managing scenarios to 
assigning positions or ranks to rows in groups*/

SELECT BusinessEntityID, Gender, VacationHours,
RANK() OVER (PARTITION BY Gender ORDER BY VacationHours DESC) AS RankResult
FROM [HumanResources].[Employee]

/*Benefits:
- Tie management: assigns the same rank to rows that have the same value in the sort column,
  which is useful when you need to handle ties properly

- Sorting within partitions: Allows data to be sorted within groups or partitions, 
 providing a hierarchical or tiered view of the data
*/