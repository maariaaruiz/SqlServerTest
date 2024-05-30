
BEGIN TRY
    -- Transaction
    BEGIN TRANSACTION;

    -- Update salaries of employees
    UPDATE HumanResources.EmployeePayHistory
    SET Rate = Rate * 1.05;
    -- Confirmar la transacción si no hay errores
    COMMIT;
END TRY
BEGIN CATCH
    -- If failed, come back
    ROLLBACK;

    -- Show failure informartion
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    PRINT 'Failed updated salaries: ' + @ErrorMessage;
END CATCH;


