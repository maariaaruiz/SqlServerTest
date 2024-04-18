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
	hierachyid_column HIERARCHYID,
	rowversion_column ROWVERSION
GO