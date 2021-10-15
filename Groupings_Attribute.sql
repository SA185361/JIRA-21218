


DROP Table IF Exists #SecurityT
DROP Table IF Exists #Groupings_Attribute1
DROP Table if exists vision.##Groupings_Attribute2


CREATE TABLE #SecurityT (
 RowID int IDENTITY(1, 1),
  ID int,
 [Name] varchar(500)
)
DECLARE @NumberRecords int, @RowCount int
DECLARE @ID int, @NAME varchar(200)


INSERT INTO #SecurityT (ID,Name)
	SELECT
		ID, NAME
	FROM vision.SECURITY_TENANT
	WHERE shared = 0;

SET @NumberRecords = @@rowcount
SET @RowCount = 1

Create Table #Groupings_Attribute1 
(
   	
	[groupings_id] [int] NOT NULL,
	[attribute_id] [int] NULL,
	[groupings_order] [int] NOT NULL,
	[filters] [varchar](4000) NULL,
	[parent_attribute_id] [int] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Groupings_Attribute1 
( [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,[tenant_id] )
Select 

          [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,[tenant_id]
from vision.Groupings_Attribute 
where Tenant_id = 0
--and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.Groupings_Attribute
print @LINK

SET @sql = '
CREATE TABLE vision.##Groupings_Attribute2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [groupings_id] [int] NOT NULL,
	[attribute_id] [int] NULL,
	[groupings_order] [int] NOT NULL,
	[filters] [varchar](4000) NULL,
	[parent_attribute_id] [int] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)

	';

EXEC (@sql);

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##Groupings_Attribute2
(
  [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,[tenant_id])
Select 
   [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,@ID
from  #Groupings_Attribute1

SET @RowCount = @RowCount + 1
END


select * from vision.##Groupings_Attribute2

DROP TABLE #SecurityT
Drop Table #Groupings_Attribute1 


GO

-- Select * from [VISION].[Groupings_Attribute]

-- DBCC CHECKIDENT('vision.Groupings_Attribute_Test')

-- DBCC CHECKIDENT('vision.Groupings_Attribute_Test',reseed,76)



--      Select 596 * 1
--      FINAL Total: 596


--  DELETE from Vision.Groupings_Attribute_test

--  Select count(*) from [VISION].[Groupings_Attribute_Test]

--Select * from [VISION].[Groupings_Attribute_Test]
--where TENANT_ID =1 