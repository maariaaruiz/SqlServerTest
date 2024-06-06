/* WHERE:

Filtra filas antes de que se apliquen las funciones de agregación (SUM, COUNT, AVG, ...)
y antes de que se realicen las agruprupaciones

Filtra filas por condiciones específicas
*/

USE AdventureWorks2022;
GO

SELECT prd.ProductID, prd.Name, prd.ListPrice
FROM Production.Product prd
WHERE prd.ListPrice > 3000;


/* HAVING:

Filtra filas despúes de que se apliquen las funciones de agregación
y después de que se realicen las agrupaciones

Filtra grupos por condiciones específicas
*/

SELECT prd.Color, AVG(prd.ListPrice) AS AveragePrice
FROM Production.Product prd
GROUP BY prd.Color
HAVING AVG(prd.ListPrice) > 0;
