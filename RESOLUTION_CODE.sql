
DROP Table IF Exists #SecurityT
DROP Table IF Exists #RESOLUTION_CODE1
DROP Table if exists vision.##RESOLUTION_CODE2


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

Create Table #RESOLUTION_CODE1 
(
   	[DESCRIPTION] [nvarchar](60) NULL,
	[NAME] [varchar](30) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #RESOLUTION_CODE1 
Select 
[DESCRIPTION]
           ,[NAME]
           ,[VERSION]
from vision.RESOLUTION_CODE 
where Tenant_id = 0
--and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.RESOLUTION_CODE 
print @LINK

SET @sql = '
CREATE TABLE vision.##RESOLUTION_CODE2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    	[DESCRIPTION] [nvarchar](60) NULL,
	[NAME] [varchar](30) NOT NULL,
	[VERSION] [int] NOT NULL)

	';

EXEC (@sql);




WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.##RESOLUTION_CODE2
(
[DESCRIPTION]
           ,[NAME]
           ,[VERSION])
Select 
[DESCRIPTION]
           ,[NAME]
           ,[VERSION] 
from  #RESOLUTION_CODE1

SET @RowCount = @RowCount + 1
END


select * from Vision.##RESOLUTION_CODE2

DROP TABLE #SecurityT
Drop Table #RESOLUTION_CODE1 


GO

-- Select * from [VISION].[RESOLUTION_CODE]

-- DBCC CHECKIDENT('vision.RESOLUTION_CODE_Test')

-- DBCC CHECKIDENT('vision.RESOLUTION_CODE_Test',reseed,365)



--      Select 596 * 67
--      FINAL Total: 39932


--  DELETE from Vision.RESOLUTION_CODE_test

--  Select count(*) from [VISION].[RESOLUTION_CODE_Test]

--Select * from [VISION].[RESOLUTION_CODE_Test]
--where TENANT_ID =1 