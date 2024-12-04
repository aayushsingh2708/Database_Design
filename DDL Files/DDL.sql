USE Final_Superstore;
GO

/*********************************************************/
/******************    Schema DDL       ******************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dim' ) 
BEGIN
    EXEC sp_executesql N'CREATE SCHEMA dim AUTHORIZATION dbo;'
END
;

GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'f' ) 
BEGIN
    EXEC sp_executesql N'CREATE SCHEMA f AUTHORIZATION dbo;'
END
;

GO

/*********************************************************/
/****************** Segment DIM DDL **********************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'Segment')
BEGIN
    CREATE TABLE dim.Segment (
        SegmentID BIGINT NOT NULL,
        Segment NVARCHAR(MAX) NULL
    );

    ALTER TABLE dim.Segment
    ADD CONSTRAINT PK_Segment PRIMARY KEY (SegmentID);
END
;

GO

/*********************************************************/
/****************** ShipMode DIM DDL *********************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'ShipMode')
BEGIN
    CREATE TABLE dim.ShipMode (
        ShipModeID BIGINT NOT NULL,
        ShipMode NVARCHAR(MAX) NULL
    );

    ALTER TABLE dim.ShipMode
    ADD CONSTRAINT PK_ShipMode PRIMARY KEY (ShipModeID);
END
;

GO

/*********************************************************/
/****************** Region DIM DDL ***********************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'Region')
BEGIN
    CREATE TABLE dim.Region (
        RegionID BIGINT NOT NULL,
        Region NVARCHAR(MAX) NULL
    );

    ALTER TABLE dim.Region
    ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);
END
;

GO

/*********************************************************/
/****************** Category DIM DDL *********************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'Category')
BEGIN
    CREATE TABLE dim.Category (
        CategoryID BIGINT NOT NULL,
        Category NVARCHAR(MAX) NULL
    );

    ALTER TABLE dim.Category
    ADD CONSTRAINT PK_Category PRIMARY KEY (CategoryID);
END
;

GO

/*********************************************************/
/**************** Sub-Category DIM DDL *******************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'SubCategory')
BEGIN
    CREATE TABLE dim.SubCategory (
        SubCategoryID BIGINT NOT NULL,
        SubCategory NVARCHAR(MAX) NULL
    );

    ALTER TABLE dim.SubCategory
    ADD CONSTRAINT PK_SubCategory PRIMARY KEY (SubCategoryID);
END
;

GO

/*********************************************************/
/****************** Year DIM DDL *************************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'Year')
BEGIN
    CREATE TABLE dim.Year (
        YearID BIGINT NOT NULL,
        Year BIGINT NULL
    );

    ALTER TABLE dim.Year
    ADD CONSTRAINT PK_Year PRIMARY KEY (YearID);
END
;

GO

/*********************************************************/
/****************** Orders Fact Table ********************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'f' AND TABLE_NAME = 'Orders')
BEGIN
    CREATE TABLE f.Orders (
        RowID BIGINT NOT NULL, 
        OrderDate DATETIME2(0) NULL,
        ShipDate DATETIME2(0) NULL,
        ShipModeID BIGINT NULL,
        CustomerName NVARCHAR(MAX) NULL,
        SegmentID BIGINT NULL,
        Country NVARCHAR(MAX) NULL,
        City NVARCHAR(MAX) NULL,
        State NVARCHAR(MAX) NULL,
        RegionID BIGINT NULL,
        CategoryID BIGINT NULL,
        SubCategoryID BIGINT NULL,
        ProductName NVARCHAR(MAX) NULL,
        Sales FLOAT NULL,
        Quantity BIGINT NULL,
        Discount FLOAT NULL,
        Profit FLOAT NULL,
        Year INT NULL,
        YearID BIGINT NULL
    );

    -- Define the PRIMARY KEY on RowID
    ALTER TABLE f.Orders
    ADD CONSTRAINT PK_Orders PRIMARY KEY (RowID);

    -- Add FOREIGN KEY constraints
    ALTER TABLE f.Orders
    ADD CONSTRAINT FK_Orders_Segment FOREIGN KEY (SegmentID)
    REFERENCES dim.Segment (SegmentID);

    ALTER TABLE f.Orders
    ADD CONSTRAINT FK_Orders_ShipMode FOREIGN KEY (ShipModeID)
    REFERENCES dim.ShipMode (ShipModeID);

    ALTER TABLE f.Orders
    ADD CONSTRAINT FK_Orders_Region FOREIGN KEY (RegionID)
    REFERENCES dim.Region (RegionID);

    ALTER TABLE f.Orders
    ADD CONSTRAINT FK_Orders_Category FOREIGN KEY (CategoryID)
    REFERENCES dim.Category (CategoryID);

    ALTER TABLE f.Orders
    ADD CONSTRAINT FK_Orders_SubCategory FOREIGN KEY (SubCategoryID)
    REFERENCES dim.SubCategory (SubCategoryID);

    --  ALTER TABLE f.Orders
    --  ADD CONSTRAINT FK_Orders_Year FOREIGN KEY (YearID)
    --  REFERENCES dim.Year (YearID);
END
;

GO