

DROP Table IF Exists #SecurityT
DROP Table IF Exists #CMD_GROUP1
DROP Table if exists vision.##CMD_GROUP2

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

Create Table #CMD_GROUP1 
(
   	
	[DESCRIPTION] [varchar](255) NULL,
	[TENANT_ID] [numeric](18, 0) NOT NULL,
	[DELETED] [char](1) NULL,
	[VERSION] [numeric](10, 0) NULL,
	[IMPLEMENTATION] [varchar](255) NULL)


Insert into #CMD_GROUP1 
( 
           [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION])
Select 

           
           [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
from vision.CMD_GROUP 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(group_link) + 1 from  vision.CMD_GROUP 
print @LINK

SET @sql = '
CREATE TABLE vision.##CMD_GROUP2(
	[group_link] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [DESCRIPTION] [varchar](255) NULL,
	[TENANT_ID] [numeric](18, 0) NOT NULL,
	[DELETED] [char](1) NULL,
	[VERSION] [numeric](10, 0) NULL,
	[IMPLEMENTATION] [varchar](255) NULL)

	';

EXEC (@sql);



WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##CMD_GROUP2
(
          [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION])
Select 
  
           [DESCRIPTION]
           ,@ID
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
from  #CMD_GROUP1

SET @RowCount = @RowCount + 1
END


Select * from vision.##CMD_GROUP2
DROP TABLE #SecurityT
Drop Table #CMD_GROUP1 


GO

-- Select * from [VISION].[CMD_GROUP]
