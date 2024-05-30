BEGIN TRY
    -- Transaction
    BEGIN TRANSACTION;

    -- Update ship base and ship rate of ship method
    UPDATE Purchasing.ShipMethod
    SET ShipBase = ShipBase + 2,
    ShipRate = ShipRate +1
    WHERE ShipMethodID < 3

    -- Confirm transaction if not have errors
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

    PRINT 'Failed updated ship base and ship rate: ' + @ErrorMessage;
END CATCH;



