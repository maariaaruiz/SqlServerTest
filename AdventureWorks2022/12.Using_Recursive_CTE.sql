
USE AdventureWorks2022;
GO
-- Define the starting point of the recursive query
DECLARE @StartBusinessEntityID INT = 2;

-- Define recursive CTE
WITH EmployeeHierarchy AS (
    -- Non-recursive part: select root node
    SELECT 
        BusinessEntityID, 
        NationalIDNumber, 
        LoginID, 
        OrganizationNode, 
        OrganizationLevel, 
        JobTitle, 
        BirthDate, 
        MaritalStatus, 
        Gender, 
        HireDate, 
        SalariedFlag, 
        VacationHours, 
        SickLeaveHours, 
        CurrentFlag, 
        rowguid, 
        ModifiedDate
    FROM 
        HumanResources.Employee
    WHERE 
        BusinessEntityID = @StartBusinessEntityID

    UNION ALL

    -- Recursive part: joins with the non-recursive part to get all descendants
    SELECT 
        e.BusinessEntityID, 
        e.NationalIDNumber, 
        e.LoginID, 
        e.OrganizationNode, 
        e.OrganizationLevel, 
        e.JobTitle, 
        e.BirthDate, 
        e.MaritalStatus, 
        e.Gender, 
        e.HireDate, 
        e.SalariedFlag, 
        e.VacationHours, 
        e.SickLeaveHours, 
        e.CurrentFlag, 
        e.rowguid, 
        e.ModifiedDate
    FROM 
        HumanResources.Employee e
    INNER JOIN 
        EmployeeHierarchy eh ON e.OrganizationNode.GetAncestor(1) = eh.OrganizationNode
)

-- Select all records in the hierarchy
SELECT 
    BusinessEntityID, 
    NationalIDNumber, 
    LoginID, 
    OrganizationNode, 
    OrganizationLevel, 
    JobTitle, 
    BirthDate, 
    MaritalStatus, 
    Gender, 
    HireDate, 
    SalariedFlag, 
    VacationHours, 
    SickLeaveHours, 
    CurrentFlag, 
    rowguid, 
    ModifiedDate
FROM 
    EmployeeHierarchy;
GO
