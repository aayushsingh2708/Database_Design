USE Final_Superstore;
GO

/*********************************************************/
/****************** Delete Fact Table Data ***************/
/*********************************************************/
DELETE FROM f.Orders
WHERE OrderDate IS NOT NULL
  AND ShipDate IS NOT NULL
  AND ShipModeID IS NOT NULL;
GO

/*********************************************************/
/****************** Delete Year Dimension Data ***********/
/*********************************************************/
DELETE FROM dim.Year
WHERE YearID IN (1000000, 1000001, 1000002, 1000003);
GO

/*********************************************************/
/****************** Delete SubCategory Data **************/
/*********************************************************/
DELETE FROM dim.SubCategory
WHERE SubCategoryID IN (
    SELECT sc.[Sub-CategoryID]
    FROM stg.[dim_Sub-Category] sc
);
GO

/*********************************************************/
/****************** Delete Category Data *****************/
/*********************************************************/
DELETE FROM dim.Category
WHERE CategoryID IN (
    SELECT c.CategoryID
    FROM stg.dim_Category c
);
GO

/*********************************************************/
/****************** Delete Region Data *******************/
/*********************************************************/
DELETE FROM dim.Region
WHERE RegionID IN (
    SELECT r.RegionID
    FROM stg.dim_Region r
);
GO

/*********************************************************/
/****************** Delete ShipMode Data *****************/
/*********************************************************/
DELETE FROM dim.ShipMode
WHERE ShipModeID IN (
    SELECT sm.ShipModeID
    FROM stg.dim_ShipMode sm
);
GO

/*********************************************************/
/****************** Delete Segment Data ******************/
/*********************************************************/
DELETE FROM dim.Segment
WHERE SegmentID IN (
    SELECT s.SegmentID
    FROM stg.dim_Segment s
);
GO
