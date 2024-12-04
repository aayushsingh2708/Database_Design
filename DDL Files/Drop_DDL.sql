USE Final_Superstore;
GO

/*********************************************************/
/****************** Drop Constraints and Tables **********/
/*********************************************************/

/* Drop Foreign Key Constraints on f.Orders */
IF OBJECT_ID('f.Orders', 'U') IS NOT NULL
BEGIN
    ALTER TABLE f.Orders DROP CONSTRAINT PK_Orders;
    ALTER TABLE f.Orders DROP CONSTRAINT FK_Orders_Segment;
    ALTER TABLE f.Orders DROP CONSTRAINT FK_Orders_ShipMode;
    ALTER TABLE f.Orders DROP CONSTRAINT FK_Orders_Region;
    ALTER TABLE f.Orders DROP CONSTRAINT FK_Orders_Category;
    ALTER TABLE f.Orders DROP CONSTRAINT FK_Orders_SubCategory;
    --ALTER TABLE f.Orders DROP CONSTRAINT FK_Orders_Year;
END;

GO

/* Drop f.Orders Table */
IF OBJECT_ID('f.Orders', 'U') IS NOT NULL
BEGIN
    DROP TABLE f.Orders;
END;

GO

/* Drop dim.Year Table */
IF OBJECT_ID('dim.Year', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dim.Year DROP CONSTRAINT PK_Year;
    DROP TABLE dim.Year;
END;

GO

/* Drop dim.SubCategory Table */
IF OBJECT_ID('dim.SubCategory', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dim.SubCategory DROP CONSTRAINT PK_SubCategory;
    DROP TABLE dim.SubCategory;
END;

GO

/* Drop dim.Category Table */
IF OBJECT_ID('dim.Category', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dim.Category DROP CONSTRAINT PK_Category;
    DROP TABLE dim.Category;
END;

GO

/* Drop dim.Region Table */
IF OBJECT_ID('dim.Region', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dim.Region DROP CONSTRAINT PK_Region;
    DROP TABLE dim.Region;
END;

GO

/* Drop dim.ShipMode Table */
IF OBJECT_ID('dim.ShipMode', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dim.ShipMode DROP CONSTRAINT PK_ShipMode;
    DROP TABLE dim.ShipMode;
END;

GO

/* Drop dim.Segment Table */
IF OBJECT_ID('dim.Segment', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dim.Segment DROP CONSTRAINT PK_Segment;
    DROP TABLE dim.Segment;
END;

GO

/*********************************************************/
/**************** Drop Schemas ***************************/
/*********************************************************/

/* Drop f Schema */
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'f')
BEGIN
    DROP SCHEMA f;
END;

GO

/* Drop dim Schema */
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'dim')
BEGIN
    DROP SCHEMA dim;
END;

GO


