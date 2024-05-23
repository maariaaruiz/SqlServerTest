--create CTE query where employe count greater than 5 and employee are now in departament
WITH DepartmentEmployeeCount AS (
    SELECT 
        DepartmentID, 
        COUNT(*) AS EmployeeCount
    FROM HumanResources.EmployeeDepartmentHistory
    WHERE StartDate < GETDATE() AND (EndDate IS NULL OR EndDate > GETDATE())
    GROUP BY DepartmentID
    HAVING COUNT(*) > 5
)
SELECT 
    e.DepartmentID,
    emp.*
FROM 
    HumanResources.EmployeeDepartmentHistory edh
JOIN 
    DepartmentEmployeeCount e ON edh.DepartmentID = e.DepartmentID
JOIN 
    HumanResources.Employee emp ON edh.BusinessEntityID = emp.BusinessEntityID
WHERE edh.StartDate < GETDATE() AND (edh.EndDate IS NULL OR edh.EndDate > GETDATE())
ORDER BY 
    e.DepartmentID, emp.BusinessEntityID;
