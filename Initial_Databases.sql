-- create smcdb1 database
USE master;
GO
CREATE DATABASE smcdb1
COLLATE Modern_Spanish_CI_AI;
GO

-- create table Test on smcdb1 with primary key
USE smcdb1;
GO
CREATE TABLE Test (
	Code VARCHAR(20) NOT NULL PRIMARY KEY
);
GO

-- create smcdb2 database
USE master;
GO
CREATE DATABASE smcdb2
COLLATE Latin1_General_CS_AS;
GO

-- create diferent column types
USE smcdb1;
GO

ALTER TABLE Test
ADD
	-- character data types
 	char_column CHAR(10),
	varchar_column VARCHAR(100),	
	text_column TEXT,
	nchar_column NCHAR(10),
    nvarchar_column NVARCHAR(100),   
	ntext_column NTEXT,   

	-- numeric data types
	int_column INT,
	smallint_column SMALLINT,
	decimal_column DECIMAL(10,2),
	float_column FLOAT,
	bigint_column BIGINT,
	numeric_column NUMERIC(10,3),
	bit_column BIT,
	money_column MONEY,
	smallmoney_column SMALLMONEY,
	real_column REAL,
	tinyint_colum TINYINT,

	-- date time types
	date_column DATE,
	time_colum TIME,
	datetime_column DATETIME,
	datetime2_column DATETIME2,
	datetimeoffset_column DATETIMEOFFSET,
	smalldatetime_colum SMALLDATETIME,

	-- binary data types
	varbinary_column VARBINARY(100),
	binary_column BINARY(10),

	-- identity data types
	uniqueidentifier_column UNIQUEIDENTIFIER,

	--other data types
	xml_column XML,
	image_column IMAGE,
	geography_column GEOGRAPHY,
	geometry_column GEOMETRY,
	hierachyid_column HIERARCHYID	
GO

-- default Test data

INSERT INTO [dbo].[Test] (
	[Code],
    char_column,
    varchar_column,
    text_column,
    nchar_column,
    nvarchar_column,
    ntext_column,
    int_column,
    smallint_column,
    decimal_column,
    float_column,
    bigint_column,
    numeric_column,
    bit_column,
    money_column,
    smallmoney_column,
    real_column,
    tinyint_colum,
    date_column,
    time_colum,
    datetime_column,
    datetime2_column,
    datetimeoffset_column,
    smalldatetime_colum,
    varbinary_column,
    binary_column,
    uniqueidentifier_column,
    xml_column,
    image_column,
    geography_column,
    geometry_column,
    hierachyid_column   
) VALUES (
	'Code 001',
    'valorVhar',
    'valorVarchar',
    'valorText',
    N'valorNchar',
    N'valorNvarchar',
    N'valorNtext',
    123,
    456,
    78.90,
    123.45,
    1234567890,
    123.456,
    1,
    100.50,
    50.25,
    3.14159,
    5,
    '2024-04-25',
    '12:34:56',
    '2024-04-25T12:34:56',
    '2024-04-25T12:34:56.1234567',
    '2024-04-25T12:34:56.1234567-07:00',
    '2024-04-25T12:34:56',
    0x0123456789ABCDEF, -- valor varbinary
    0x0123456789, -- valor binary 
    'F961CFFF-8D55-4C36-99D9-107C44A80F6C', -- valor uniqueidentifier 
    '<xml>datos</xml>', -- valor xml 
    0x012345, -- valor image 
    geography::Point(47.65100, -122.34900, 4326), -- valor geography 
    geometry::Point(47.65100, -122.34900, 4326), -- valor geometry 
    '/1/' -- valor hierarchyid    
);
GO

-- copy table test from smcdb1 to smcdb2
SELECT *
INTO smcdb2.dbo.Test
FROM smcdb1.dbo.Test;
GO


-- join tables and databases
SELECT *
FROM smcdb1.dbo.Test AS t1
INNER JOIN smcdb2.dbo.Test AS t2
	ON t1.nvarchar_column COLLATE Latin1_General_CS_AS = t2.nvarchar_column

--create table customers

USE smcdb1;
GO

CREATE SCHEMA Sales; -- create schema
GO

CREATE TABLE Sales.Customers (
    CustomerId UNIQUEIDENTIFIER PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    DocumentNumber VARCHAR(15) UNIQUE NOT NULL
);
GO

--create table Country

USE smcdb1;
GO

CREATE TABLE Sales.Countries (
    CountryId UNIQUEIDENTIFIER PRIMARY KEY,
    CountryName VARCHAR(50) NOT NULL
);
GO

-- create table Address

USE smcdb1;
GO

CREATE TABLE Sales.Address (
    AddressId UNIQUEIDENTIFIER PRIMARY KEY,
    Street VARCHAR(100) NOT NULL,
    CountryId UNIQUEIDENTIFIER,
    FOREIGN KEY (CountryId) REFERENCES Sales.Countries(CountryId));
GO

-- create table InvoicesHeader
USE smcdb1;
GO

CREATE TABLE Sales.InvoicesHeader (
	InvoiceId UNIQUEIDENTIFIER PRIMARY KEY,
    InvoiceDate DATETIME DEFAULT GETDATE(),
    CustomerId UNIQUEIDENTIFIER,
    AddressId UNIQUEIDENTIFIER,
    TaxBase MONEY NOT NULL,
    TotalVat MONEY NOT NULL,
    Total MONEY NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Sales.Customers(CustomerId),
    FOREIGN KEY (AddressId) REFERENCES Sales.Address(AddressId),
);
GO

-- create table Products

USE smcdb1;
GO

CREATE TABLE Sales.Products(
	ProductId UNIQUEIDENTIFIER PRIMARY KEY,
	ProductName VARCHAR(100) NOT NULL
);
GO


-- create table VatTypes

USE smcdb1;
GO

CREATE TABLE Sales.VatTypes(
	VatTypeId UNIQUEIDENTIFIER PRIMARY KEY,
	VatTypeName VARCHAR(50) NOT NULL,
	Rate DECIMAL(5, 2) NOT NULL
);

GO

-- create table InvoicesDetail

USE smcdb1;
GO

CREATE TABLE Sales.InvoicesDetail(
	InvoiceId UNIQUEIDENTIFIER,
	RowNumber INT,
	ProductId UNIQUEIDENTIFIER,
	Description VARCHAR(255) NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice MONEY NOT NULL,
	Discount DECIMAL(10,2),
	VatTypeId UNIQUEIDENTIFIER,
	TotalLine MONEY NOT NULL
	PRIMARY KEY (InvoiceId, RowNumber)
    FOREIGN KEY (VatTypeId) REFERENCES Sales.VatTypes(VatTypeId),
    FOREIGN KEY (ProductId) REFERENCES Sales.Products(ProductId),
    FOREIGN KEY (InvoiceId) REFERENCES Sales.InvoicesHeader(InvoiceId)
);

GO

-- create trigger when insert InvoicesDetail or update TotalLine in InvoicesDetail

USE smcdb1;
GO 

CREATE OR ALTER TRIGGER UpdateTotalIfUpdateDetail
ON Sales.InvoicesDetail
AFTER INSERT, UPDATE
AS
BEGIN
    IF UPDATE(Quantity) OR UPDATE(UnitPrice) OR UPDATE(Discount) OR UPDATE(VatTypeId)
    BEGIN
        UPDATE Sales.InvoicesDetail
        SET 
        TotalLine = inserted.Quantity *  
            ((inserted.UnitPrice * ((100 - ISNULL(inserted.Discount, 0)) / 100)) + 
            ((inserted.UnitPrice * ((100 - ISNULL(inserted.Discount, 0)) / 100)) * 
            (ISNULL((SELECT Rate FROM Sales.VatTypes WHERE VatTypeId = inserted.VatTypeId), 0) / 100)))
        FROM inserted
        WHERE Sales.InvoicesDetail.InvoiceId = inserted.InvoiceId AND Sales.InvoicesDetail.RowNumber = inserted.RowNumber;
    END;

    BEGIN 
    UPDATE inh
    SET 
        TaxBase = (SELECT SUM(ind.Quantity * ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100)))) 
                    FROM Sales.InvoicesDetail AS ind 
                    WHERE ind.InvoiceId = inh.InvoiceId), 
        TotalVat = (SELECT SUM(ind.TotalLine - (ind.Quantity * ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100))))) 
                    FROM Sales.InvoicesDetail AS ind 
                    WHERE ind.InvoiceId = inh.InvoiceId),
        Total = (SELECT SUM(ind.TotalLine) 
                FROM Sales.InvoicesDetail AS ind 
                WHERE ind.InvoiceId = inh.InvoiceId)
    FROM Sales.InvoicesHeader AS inh
        INNER JOIN inserted ON inserted.InvoiceId = inh.InvoiceId
    END;

END;
GO

-- create trigger when delete InvoicesDetail

CREATE OR ALTER TRIGGER UpdateInvoicesHeaderIfDeleteInvoicesDetail
ON Sales.InvoicesDetail
AFTER DELETE
AS
BEGIN
    UPDATE inh
    SET 
    TaxBase = (ISNULL((
        SELECT SUM(ind.Quantity * ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100)))) 
        FROM Sales.InvoicesDetail AS ind 
        WHERE ind.InvoiceId = inh.InvoiceId), 0)),
    TotalVat = (ISNULL((
        SELECT SUM(ind.TotalLine - (ind.Quantity * ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100))))) 
        FROM Sales.InvoicesDetail AS ind 
        WHERE ind.InvoiceId = inh.InvoiceId), 0)),
    Total = (ISNULL((
        SELECT SUM(ind.TotalLine) 
        FROM Sales.InvoicesDetail AS ind 
        WHERE ind.InvoiceId = inh.InvoiceId), 0))
    FROM Sales.InvoicesHeader AS inh
    INNER JOIN deleted ON deleted.InvoiceId = inh.InvoiceId
END;
GO

-- create trigger when update VatTypes

CREATE OR ALTER TRIGGER UpdateTotalOnUpdateRate
ON Sales.VatTypes
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Rate)
    BEGIN
        UPDATE ind
        SET TotalLine = ind.Quantity * 
            ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100)) + 
            ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100)) * 
            (ISNULL((SELECT Rate FROM Sales.VatTypes WHERE VatTypeId = ind.VatTypeId), 0) / 100)))
        FROM Sales.InvoicesDetail AS ind
        INNER JOIN inserted ON ind.VatTypeId = inserted.VatTypeId
    END;

    BEGIN
        UPDATE inh
        SET TaxBase = (SELECT SUM(ind.Quantity * ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100)))) 
                        FROM Sales.InvoicesDetail AS ind 
                        WHERE ind.InvoiceId = inh.InvoiceId),
            TotalVat = (SELECT SUM(ind.TotalLine - (ind.Quantity * ((ind.UnitPrice * ((100 - ISNULL(ind.Discount, 0)) / 100))))) 
                        FROM Sales.InvoicesDetail AS ind 
                        WHERE ind.InvoiceId = inh.InvoiceId),
            Total = (SELECT SUM(ind.TotalLine) 
                        FROM Sales.InvoicesDetail AS ind 
                        WHERE ind.InvoiceId = inh.InvoiceId)
        FROM Sales.InvoicesHeader AS inh
        INNER JOIN Sales.InvoicesDetail AS ind ON ind.InvoiceId = inh.InvoiceId
        INNER JOIN inserted ON inserted.VatTypeId = ind.VatTypeId
    END;
END;
GO

-- insert data to customers
USE smcdb1;
GO 
INSERT INTO Sales.Customers VALUES (NEWID(),'Piter', 'Jackson','87569821K');
GO

-- insert data to country
USE smcdb1;
GO 
INSERT INTO Sales.Countries VALUES (NEWID(),'Country 1');
GO

-- insert data to address
USE smcdb1;
GO 

BEGIN
DECLARE @CountryId UNIQUEIDENTIFIER;
SELECT TOP 1 @CountryId = CountryId FROM Sales.Countries ORDER BY NEWID(); 
INSERT INTO Sales.Address VALUES (NEWID(),'Street 1', @CountryId);
END
GO

-- insert data to products
USE smcdb1;
GO 
INSERT INTO Sales.Products VALUES (NEWID(),'Product 1');
GO


-- insert data to vat types
USE smcdb1;
GO 
INSERT INTO Sales.VatTypes VALUES (NEWID(),'Vat Type 1', 0.21);
INSERT INTO Sales.VatTypes VALUES (NEWID(),'Vat Type 2', 0.10);
GO

--generate aleathory invoices (35 min)

DECLARE @CustomerId UNIQUEIDENTIFIER;
DECLARE @AddressId UNIQUEIDENTIFIER;
DECLARE @ProductId UNIQUEIDENTIFIER;
DECLARE @VatTypeId1 UNIQUEIDENTIFIER;
DECLARE @VatTypeId2 UNIQUEIDENTIFIER;
DECLARE @InvoiceId UNIQUEIDENTIFIER;
DECLARE @RowNumber INT;
DECLARE @NumberOfInvoices INT = 10000; -- number of invoices to generate

-- get IDs
SELECT TOP 1 @CustomerId = CustomerId FROM Sales.Customers ORDER BY NEWID(); 
SELECT TOP 1 @AddressId = AddressId FROM Sales.Address ORDER BY NEWID();
SELECT TOP 1 @ProductId = ProductId FROM Sales.Products ORDER BY NEWID(); 
SELECT TOP 1 @VatTypeId1 = VatTypeId FROM Sales.VatTypes WHERE Rate = 0.21; 
SELECT TOP 1 @VatTypeId2 = VatTypeId FROM Sales.VatTypes WHERE Rate = 0.10; 

-- process
DECLARE @i INT = 1;
WHILE @i <= @NumberOfInvoices
BEGIN
    
    SET @InvoiceId = NEWID();

    -- generate invoice header data
    DECLARE @InvoiceDate DATETIME = DATEADD(day, -RAND() * 365, GETDATE());
    DECLARE @TaxBase MONEY = RAND() * 1000 + 100;
    DECLARE @TotalVat MONEY = @TaxBase * 0.21; -- IVA al 21%
    DECLARE @Total MONEY = @TaxBase + @TotalVat;

    -- insert header
    INSERT INTO Sales.InvoicesHeader (InvoiceId, InvoiceDate, CustomerId, AddressId, TaxBase, TotalVat, Total)
    VALUES (@InvoiceId, @InvoiceDate, @CustomerId, @AddressId, @TaxBase, @TotalVat, @Total);


    DECLARE @NumberOfLines INT = 50;

    -- insert lines in header invoice
    SET @RowNumber = 1;
    WHILE @RowNumber <= @NumberOfLines
    BEGIN
        -- generate invoice lines data
        DECLARE @Quantity INT = RAND() * 10 + 1;
        DECLARE @UnitPrice MONEY = RAND() * 100 + 10;
        DECLARE @Discount DECIMAL(10,2) = RAND() * 0.1;
        DECLARE @VatTypeId UNIQUEIDENTIFIER = CASE WHEN RAND() > 0.5 THEN @VatTypeId1 ELSE @VatTypeId2 END;
        DECLARE @TotalLine MONEY = @Quantity * @UnitPrice * (1 - @Discount) * (1 + (SELECT Rate FROM Sales.VatTypes WHERE VatTypeId = @VatTypeId));

        -- insert invoice lines data
        INSERT INTO Sales.InvoicesDetail (InvoiceId, RowNumber, ProductId, Description, Quantity, UnitPrice, Discount, VatTypeId, TotalLine)
        VALUES (@InvoiceId, @RowNumber, @ProductId, 'Producto ' + CAST(@RowNumber AS VARCHAR(10)), @Quantity, @UnitPrice, @Discount, @VatTypeId, @TotalLine);

        SET @RowNumber = @RowNumber + 1;
    END;

    SET @i = @i + 1;
END;


-- different collation in table
USE smcdb1;
GO 
CREATE TABLE DifferentCollation (
    DifferentCollationId UNIQUEIDENTIFIER PRIMARY KEY,
    LatinGeneralCollation NVARCHAR(100) COLLATE Latin1_General_CI_AS, -- collation for the general Latin language (case-insensitive)
    FrenchCollation NVARCHAR(100) COLLATE French_CI_AI, --  collation for the French language (case-insensitive and accent-insensitive)
);
GO

-- query without 12 months
USE smcdb1;
GO 
SELECT 
    pro.ProductName as 'Type',
    YEAR(inh.InvoiceDate) AS Year, 
    SUM(inh.Total) AS TotalInvoices, 
    SUM(inh.TotalVat) AS TotalVat, 
    COUNT(id.Quantity) AS Quantity ,
    AVG(inh.Total) AS AvgTotalInvoices,
    STDEV(inh.Total) AS StDevTotalInvoice
FROM Sales.Products AS pro
    INNER JOIN Sales.InvoicesHeader AS inh 
    INNER JOIN Sales.InvoicesDetail AS id ON id.InvoiceId = inh.InvoiceId
    ON pro.ProductId = id.ProductId
GROUP BY pro.ProductName, YEAR(InvoiceDate);
GO

--query without finish 
SELECT
    YEAR(calendar.fecha) AS año,
    MONTH(calendar.fecha) AS mes,
    COALESCE(SUM(ih1.Total), 0) AS gasto_total
FROM (
    SELECT
        YEAR(ih.InvoiceDate) AS año,
        months.mes AS mes,
        CONCAT(
            YEAR(ih.InvoiceDate), 
            '-', 
            CASE 
                WHEN months.mes < 10 THEN CONCAT('0', months.mes)
                ELSE CAST(months.mes AS CHAR)
            END,
            '-01'
        ) AS fecha
    FROM
        Sales.InvoicesHeader ih 
    CROSS JOIN (
        SELECT 1 AS mes UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL 
        SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
    ) AS months
    GROUP BY
        YEAR(ih.InvoiceDate),
        months.mes
) AS calendar
LEFT JOIN
    Sales.InvoicesHeader ih1 ON YEAR(calendar.fecha) = YEAR(ih1.InvoiceDate) AND MONTH(calendar.fecha) = MONTH(ih1.InvoiceDate)
GROUP BY
    YEAR(calendar.fecha),
    MONTH(calendar.fecha)
ORDER BY
    año,
    mes;


