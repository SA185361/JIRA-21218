


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CXP_GROUP1
DROP Table if exists vision.##CXP_GROUP2

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

Create Table #CXP_GROUP1 
(
   	
	[NAME] [nvarchar](100) NOT NULL,
	[DESCRIPTION] [nvarchar](512) NULL,
	[ORGANIZATION_NAME] [varchar](512) NOT NULL)


Insert into #CXP_GROUP1 
([NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME] )
Select 

         [NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME]
from CXP.CXP_GROUP 
--where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  CXP.CXP_GROUP 
print @LINK

SET @sql = '
CREATE TABLE vision.##CXP_GROUP2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [NAME] [nvarchar](100) NOT NULL,
	[DESCRIPTION] [nvarchar](512) NULL,
	[ORGANIZATION_NAME] [varchar](512) NOT NULL)

	';

EXEC (@sql);

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into  vision.##CXP_GROUP2
(
 [NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME])
Select 
  [NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME]
from  #CXP_GROUP1

SET @RowCount = @RowCount + 1
END


Select * from  vision.##CXP_GROUP2

DROP TABLE #SecurityT
Drop Table #CXP_GROUP1 


GO

-- Select * from [CXP].[CXP_GROUP]
