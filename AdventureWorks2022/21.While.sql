/* WHILE*/

USE [AdventureWorks2022];
GO

-- create procedure
CREATE PROCEDURE ProcessNumbers
AS
BEGIN
    DECLARE @i INT = 1;  -- init counter

    -- loop WHILE
    WHILE @i <= 10
    BEGIN
        -- print actual number
        PRINT @i;
        
        -- if number is 5, out loop
        IF @i = 5
        BEGIN
            PRINT 'Number 5 found. Out of loop.';
            BREAK;
        END
        
        -- Increase the counter
        SET @i = @i + 1;
    END
END
GO
