/* NTILE: splits the subset of results into a specific number of buckets based
 on the order of specific column. Distribute the rows equally among the buckets (partitions) */

SELECT BusinessEntityID, Gender, VacationHours,
NTILE(4) OVER (PARTITION BY Gender ORDER BY VacationHours DESC) AS Quartile
FROM [HumanResources].[Employee]

/*Benefits:
- Equal Splitting: NTILE helps to split data into roughly equal partitions, 
  which is useful for statistical analysis or when you need to compare groups of similar size.
  
- Relative Sorting: Allows you to sort data into groups (such as quartiles, deciles)
  based on their order, providing a clear view of how the data is distributed.*/