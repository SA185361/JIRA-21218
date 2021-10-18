

DROP Table IF Exists #SecurityT
DROP Table IF Exists #Attribute1
DROP Table if exists vision.##Attribute2

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

Create Table #Attribute1 
(
   	

	[attribute_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[attribute_config] [nvarchar](100) NULL,
	[attribute_value_type] [nvarchar](10) NULL,
	[attribute_display_type] [nvarchar](10) NULL,
	[ref_entity_type_id] [int] NULL,
	[isIndexed] [bit] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver]  AS (CONVERT([bigint],[ROW_VER])) PERSISTED)


Insert into #Attribute1 
([attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,[tenant_id] )
Select 

          [attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,[tenant_id]
from vision.Attribute 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(id) + 1 from  vision.Attribute
print @LINK

SET @sql = '
CREATE TABLE vision.##Attribute2(
	[id] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [attribute_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[attribute_config] [nvarchar](100) NULL,
	[attribute_value_type] [nvarchar](10) NULL,
	[attribute_display_type] [nvarchar](10) NULL,
	[ref_entity_type_id] [int] NULL,
	[isIndexed] [bit] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver]  AS (CONVERT([bigint],[ROW_VER])) PERSISTED)

	';

EXEC (@sql);



WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##Attribute2
(
 [attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,[tenant_id])
Select 
  [attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,@ID
from  #Attribute1

SET @RowCount = @RowCount + 1
END


Select * from vision.##Attribute2

DROP TABLE #SecurityT
Drop Table #Attribute1 


GO

-- Select * from [VISION].[Attribute]

