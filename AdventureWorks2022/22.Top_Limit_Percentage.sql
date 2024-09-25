/* TOP, LIMIT, PERCENT to control the registers that return in a query 

TOP: select first Nrows of query
LIMIT: not avarible in SQL SERVER
PERCENT: in combination with TOP, select a percentage of rows instead of a fixed number */ 

SELECT TOP 5 *
FROM  [HumanResources].[Employee];

SELECT TOP 10 PERCENT *
FROM  [HumanResources].[Employee]
ORDER BY VacationHours DESC;

-- query in mysql with limit

SELECT *
FROM [HumanResources].[Employee]
ORDER BY VacationHours DESC
LIMIT 3 OFFSET 2;