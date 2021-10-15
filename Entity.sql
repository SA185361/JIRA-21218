

DROP Table IF Exists #SecurityT
DROP Table IF Exists #Entity1
DROP Table if exists vision.##Entity2


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

Create Table #Entity1 
(
   	
	[entity_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[external_id] [nvarchar](50) NULL,
	[version] [int] NULL,
	[logical_delete] [bit] NOT NULL,
	[entity_info] [varchar](100) NULL,
	[entity_type_id] [int] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Entity1 
(           [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,[tenant_id] )
Select 

        [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,[tenant_id]
from vision.Entity 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.Entity
print @LINK

SET @sql = '
CREATE TABLE vision.##Entity2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [entity_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[external_id] [nvarchar](50) NULL,
	[version] [int] NULL,
	[logical_delete] [bit] NOT NULL,
	[entity_info] [varchar](100) NULL,
	[entity_type_id] [int] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##Entity2
(
 
        [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,[tenant_id])
Select 
  
         [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,@ID
from  #Entity1

SET @RowCount = @RowCount + 1
END


Select * from vision.##Entity2

DROP TABLE #SecurityT
Drop Table #Entity1 


GO

-- Select * from [VISION].[Entity]

-- DBCC CHECKIDENT('vision.Entity_Test')

-- DBCC CHECKIDENT('vision.Entity_Test',reseed,365)



--      Select 596 * 5419
--      FINAL Total: 3229724


--  DELETE from Vision.Entity_test

--  Select count(*) from [VISION].[Entity_Test]

--Select * from [VISION].[Entity_Test]
--where TENANT_ID =1 