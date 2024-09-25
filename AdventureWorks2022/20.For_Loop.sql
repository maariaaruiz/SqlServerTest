
/*
FOR LOOP is supported in PL/SQL (Oracle and PostgreSQL).
Is uses to execute  code block repeated a specific number of times
*/

--oracle
BEGIN
    -- Bucle FOR que itera desde 1 hasta 10
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('Value: ' || i);
    END LOOP;
END;

-- postgreSQL
DO $$
DECLARE
    i INT;
BEGIN
    -- Bucle FOR que itera desde 1 hasta 10
    FOR i IN 1..10 LOOP
        RAISE NOTICE 'Value: %', i;
    END LOOP;
END $$;