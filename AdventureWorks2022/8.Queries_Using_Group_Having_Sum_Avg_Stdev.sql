
-- Sum salaries for departament

SELECT dep.Name as [Departament], sum (eph.Rate) as TotalSalary
FROM HumanResources.Employee emp 
INNER JOIN HumanResources.EmployeeDepartmentHistory edh 
    ON emp.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department dep 
    ON dep.DepartmentID = edh.DepartmentID
INNER JOIN HumanResources.EmployeePayHistory eph 
    ON eph.BusinessEntityID = emp.BusinessEntityID
    GROUP BY dep.Name;

-- Avg salaries for departament using having
SELECT dep.Name as [Departament], avg (eph.Rate) as TotalSalary
FROM HumanResources.Employee emp 
INNER JOIN HumanResources.EmployeeDepartmentHistory edh 
    ON emp.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department dep 
    ON dep.DepartmentID = edh.DepartmentID
INNER JOIN HumanResources.EmployeePayHistory eph 
    ON eph.BusinessEntityID = emp.BusinessEntityID
    GROUP BY dep.Name
    HAVING avg(eph.Rate) > 30;

-- Calculate the standard deviation of salaries by department.

SELECT dep.Name as [Departament], STDEV (eph.Rate) as StandarDeviationSalary
FROM HumanResources.Employee emp 
INNER JOIN HumanResources.EmployeeDepartmentHistory edh 
    ON emp.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department dep 
    ON dep.DepartmentID = edh.DepartmentID
INNER JOIN HumanResources.EmployeePayHistory eph 
    ON eph.BusinessEntityID = emp.BusinessEntityID
    GROUP BY dep.Name;