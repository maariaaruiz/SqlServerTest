

-- Non-Clustured index with diferrent options

CREATE NONCLUSTERED INDEX IX_Employee_Salary
ON [HumanResources].[Employee] (VacationHours)
INCLUDE (SickLeaveHours, HireDate)
WITH (
    FILLFACTOR = 80,
    PAD_INDEX = ON,
    STATISTICS_NORECOMPUTE = OFF,
    IGNORE_DUP_KEY = OFF,
    ALLOW_PAGE_LOCKS = ON,
    ALLOW_ROW_LOCKS = ON,
    ONLINE = ON
);

/*
FILLFACTOR: leaves 20% space free.
PAD_INDEX: ON leaves additional space on pages.
STATISTICS_NORECOMPUTE: OFF allows automatic recomputation of statistics.
IGNORE_DUP_KEY: OFF doues not ignore duplicates
ALLOW_PAGE_LOCKS:  ON  and ALLOW_ROW_LOCKS: ON -> enable page and row locking
ONLINE: ON allows index creation while the table is in use
*/