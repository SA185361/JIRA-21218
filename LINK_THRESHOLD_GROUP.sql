

DROP Table IF Exists #SecurityT
DROP Table IF Exists #LINK_THRESHOLD_GROUP1
DROP Table if exists vision.##LINK_THRESHOLD_GROUP2

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

Create Table #LINK_THRESHOLD_GROUP1 
(
    [DESCRIPTION] [char](30) NOT NULL,
	[THRESH_TYPE] [smallint] NULL,
	[EXCEPTIONDAY_1] [smallint] NULL,
	[EXCEPTIONDAY_2] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL)


Insert into #LINK_THRESHOLD_GROUP1 
Select 
[DESCRIPTION]
,[THRESH_TYPE]
,[EXCEPTIONDAY_1]
,[EXCEPTIONDAY_2]
,[TENANT_ID]
,[DELETED]
from vision.LINK_THRESHOLD_GROUP 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.LINK_THRESHOLD_GROUP 
print @LINK

SET @sql = '
CREATE TABLE vision.##LINK_THRESHOLD_GROUP2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [DESCRIPTION] [char](30) NOT NULL,
	[THRESH_TYPE] [smallint] NULL,
	[EXCEPTIONDAY_1] [smallint] NULL,
	[EXCEPTIONDAY_2] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL)

	';

EXEC (@sql);

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##LINK_THRESHOLD_GROUP2
(
[DESCRIPTION]
,[THRESH_TYPE]
,[EXCEPTIONDAY_1]
,[EXCEPTIONDAY_2]
,[TENANT_ID]
,[DELETED])
Select 
[DESCRIPTION]
,[THRESH_TYPE]
,[EXCEPTIONDAY_1]
,[EXCEPTIONDAY_2]
,@ID
,[DELETED]
from  #LINK_THRESHOLD_GROUP1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #LINK_THRESHOLD_GROUP1 


GO

-- Select * from [VISION].[LINK_THRESHOLD_GROUP]

-- DBCC CHECKIDENT('vision.LINK_THRESHOLD_GROUP_Test')

-- DBCC CHECKIDENT('vision.LINK_THRESHOLD_GROUP_Test',reseed,365)



--      Select 596 * 0
--      FINAL Total: 10132


--  DELETE from Vision.LINK_THRESHOLD_GROUP_test

--  Select count(*) from [VISION].[LINK_THRESHOLD_GROUP_Test]

--Select * from [VISION].[LINK_THRESHOLD_GROUP_Test]
--where TENANT_ID =1 