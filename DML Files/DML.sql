USE Final_Superstore;
GO

/*
  Load the Segment dimension data ...
*/
INSERT INTO dim.Segment (SegmentID, Segment)
SELECT DISTINCT 
       s.SegmentID, 
       s.Segment
FROM stg.dim_Segment s
WHERE s.SegmentID NOT IN (SELECT SegmentID FROM dim.Segment);
GO

/*
  Load the ShipMode dimension data ...
*/
INSERT INTO dim.ShipMode (ShipModeID, ShipMode)
SELECT DISTINCT 
       sm.ShipModeID, 
       sm.[Ship Mode]
FROM stg.dim_ShipMode sm
WHERE sm.ShipModeID NOT IN (SELECT ShipModeID FROM dim.ShipMode);
GO

/*
  Load the Region dimension data ...
*/
INSERT INTO dim.Region (RegionID, Region)
SELECT DISTINCT 
       r.RegionID, 
       r.Region
FROM stg.dim_Region r
WHERE r.RegionID NOT IN (SELECT RegionID FROM dim.Region);
GO

/*
  Load the Category dimension data ...
*/
INSERT INTO dim.Category (CategoryID, Category)
SELECT DISTINCT 
       c.CategoryID, 
       c.Category
FROM stg.dim_Category c
WHERE c.CategoryID NOT IN (SELECT CategoryID FROM dim.Category);
GO

/*
  Load the SubCategory dimension data ...
*/
INSERT INTO dim.SubCategory (SubCategoryID, SubCategory)
SELECT DISTINCT 
       sc.[Sub-CategoryID], 
       sc.[Sub-Category]
FROM stg.[dim_Sub-Category] sc
WHERE sc.[Sub-CategoryID] NOT IN (SELECT SubCategoryID FROM dim.SubCategory);
GO

/*
  Inserting the Year dimension data ...
*/
INSERT INTO dim.Year (YearID, Year)
VALUES 
        (1000000, 2011),
        (1000001, 2012),
        (1000002, 2013),
        (1000003, 2014);
GO

/*
  Load the Orders fact table data ...
*/
INSERT INTO f.Orders 
    (RowID, OrderDate, ShipDate, ShipModeID, CustomerName, SegmentID, Country, City, State, RegionID, 
    CategoryID, SubCategoryID, ProductName, Sales, Quantity, Discount, Profit, Year, YearID)
SELECT DISTINCT
    o.[Row ID] AS RowID, 
    o.[Order Date] AS OrderDate, 
    o.[Ship Date] AS ShipDate,
    o.ShipModeID,
    o.[Customer Name] AS CustomerName,
    o.SegmentID,
    o.Country,
    o.City,
    o.State,
    o.RegionID,
    o.CategoryID,
    o.[Sub-CategoryID] AS SubCategoryID,
    o.[Product Name] AS ProductName,
    o.Sales, 
    o.Quantity, 
    o.Discount, 
    o.Profit,
    YEAR(o.[Order Date]) AS Year,
    CASE YEAR(o.[Order Date])                        
        WHEN 2011 THEN 1000000
        WHEN 2012 THEN 1000001
        WHEN 2013 THEN 1000002
        WHEN 2014 THEN 1000003
    END AS YearID
FROM stg.Orders o
-- Ensure these column names exist and are correctly referenced
JOIN stg.dim_Segment seg ON o.SegmentID = seg.SegmentID
JOIN stg.dim_ShipMode sm ON o.ShipModeID = sm.ShipModeID
JOIN stg.dim_Region r ON o.RegionID = r.RegionID
JOIN stg.dim_Category cat ON o.CategoryID = cat.CategoryID
JOIN stg.[dim_Sub-Category] sc ON o.[Sub-CategoryID] = sc.[Sub-CategoryID]
JOIN dim.Year y ON YEAR(o.[Order Date]) = y.Year;
GO


