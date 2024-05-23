-- cte to know monthy sales
WITH MonthlySales AS (
    SELECT
        SalesPersonID,
        YEAR(OrderDate) AS SalesYear,
        MONTH(OrderDate) AS SalesMonth,
        SUM(TotalDue) AS TotalSales
    FROM
        Sales.SalesOrderHeader 
        WHERE SalesPersonID IS NOT NULL
    GROUP BY
       SalesPersonID,
        YEAR(OrderDate),
        MONTH(OrderDate)
),
-- cte to know max total sales for month of year
MaxMonthlySales AS (
    SELECT
        SalesYear,
        SalesMonth,
        MAX(TotalSales) AS MaxTotalSales
    FROM
        MonthlySales
        
    GROUP BY
        SalesYear,
        SalesMonth
)
--query to obtain employee with maximum total sales for month
SELECT
    ms.SalesPersonID,
    emp.NationalIDNumber,
    ms.SalesYear,
    ms.SalesMonth,
    ms.TotalSales
FROM
    MonthlySales ms
    INNER JOIN MaxMonthlySales mms
        ON ms.SalesYear = mms.SalesYear
        AND ms.SalesMonth = mms.SalesMonth
        AND ms.TotalSales = mms.MaxTotalSales
    INNER JOIN HumanResources.Employee emp
        ON emp.BusinessEntityID = ms.SalesPersonID
ORDER BY
    ms.SalesYear,
    ms.SalesMonth ASC;

