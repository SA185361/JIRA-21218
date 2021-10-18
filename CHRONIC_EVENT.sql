


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CHRONIC_EVENT1
DROP Table if exists vision.##CHRONIC_EVENT2

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

Create Table #CHRONIC_EVENT1 
(
[DESCRIPTION] [varchar](100) NULL,
	[OPEN_STATUS_CODE_LINK] [nvarchar](50) NULL,
	[THRESHOLD_COUNT] [numeric](18, 0) NOT NULL,
	[THRESHOLD_INTERVAL] [numeric](18, 0) NOT NULL,
	[CATEGORY_SELECTION] [numeric](18, 0) NOT NULL,
	[THRESHOLD_SELECTION] [numeric](18, 0) NOT NULL,
	[SELECTION_CRITERIA] [char](1000) NOT NULL,
	[OPEN_ORIGINAL_TICKET] [char](1) NULL,
	[RESET_THRESHOLD_HISTORY] [char](1) NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[ACTIVITY] [int] NOT NULL,
	[EXISTING_STATUS_CODE] [varchar](100) NULL,
	[INCIDENT_ONLY_THRESHOLD] [char](1) NOT NULL,
	[ORDERING] [int] NOT NULL,
	[ACTION_ON_THRESHOLD_REACHED] [int] NOT NULL
)


Insert into #CHRONIC_EVENT1 
(
[DESCRIPTION]
           ,[OPEN_STATUS_CODE_LINK]
           ,[THRESHOLD_COUNT]
           ,[THRESHOLD_INTERVAL]
           ,[CATEGORY_SELECTION]
           ,[THRESHOLD_SELECTION]
           ,[SELECTION_CRITERIA]
           ,[OPEN_ORIGINAL_TICKET]
           ,[RESET_THRESHOLD_HISTORY]
           ,[TENANT_ID]
           ,[ACTIVITY]
           ,[EXISTING_STATUS_CODE]
           ,[INCIDENT_ONLY_THRESHOLD]
           ,[ORDERING]
           ,[ACTION_ON_THRESHOLD_REACHED] )
Select 
[DESCRIPTION]
           ,[OPEN_STATUS_CODE_LINK]
           ,[THRESHOLD_COUNT]
           ,[THRESHOLD_INTERVAL]
           ,[CATEGORY_SELECTION]
           ,[THRESHOLD_SELECTION]
           ,[SELECTION_CRITERIA]
           ,[OPEN_ORIGINAL_TICKET]
           ,[RESET_THRESHOLD_HISTORY]
           ,[TENANT_ID]
           ,[ACTIVITY]
           ,[EXISTING_STATUS_CODE]
           ,[INCIDENT_ONLY_THRESHOLD]
           ,[ORDERING]
           ,[ACTION_ON_THRESHOLD_REACHED]
from vision.CHRONIC_EVENT
where Tenant_id = 0 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.CHRONIC_EVENT
print @LINK

SET @sql = '
CREATE TABLE vision.##CHRONIC_EVENT2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [DESCRIPTION] [varchar](100) NULL,
	[OPEN_STATUS_CODE_LINK] [nvarchar](50) NULL,
	[THRESHOLD_COUNT] [numeric](18, 0) NOT NULL,
	[THRESHOLD_INTERVAL] [numeric](18, 0) NOT NULL,
	[CATEGORY_SELECTION] [numeric](18, 0) NOT NULL,
	[THRESHOLD_SELECTION] [numeric](18, 0) NOT NULL,
	[SELECTION_CRITERIA] [char](1000) NOT NULL,
	[OPEN_ORIGINAL_TICKET] [char](1) NULL,
	[RESET_THRESHOLD_HISTORY] [char](1) NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[ACTIVITY] [int] NOT NULL,
	[EXISTING_STATUS_CODE] [varchar](100) NULL,
	[INCIDENT_ONLY_THRESHOLD] [char](1) NOT NULL,
	[ORDERING] [int] NOT NULL,
	[ACTION_ON_THRESHOLD_REACHED] [int] NOT NULL)

	';

EXEC (@sql);

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##CHRONIC_EVENT2
(
[DESCRIPTION]
           ,[OPEN_STATUS_CODE_LINK]
           ,[THRESHOLD_COUNT]
           ,[THRESHOLD_INTERVAL]
           ,[CATEGORY_SELECTION]
           ,[THRESHOLD_SELECTION]
           ,[SELECTION_CRITERIA]
           ,[OPEN_ORIGINAL_TICKET]
           ,[RESET_THRESHOLD_HISTORY]
           ,[TENANT_ID]
           ,[ACTIVITY]
           ,[EXISTING_STATUS_CODE]
           ,[INCIDENT_ONLY_THRESHOLD]
           ,[ORDERING]
           ,[ACTION_ON_THRESHOLD_REACHED])
Select 
[DESCRIPTION]
           ,[OPEN_STATUS_CODE_LINK]
           ,[THRESHOLD_COUNT]
           ,[THRESHOLD_INTERVAL]
           ,[CATEGORY_SELECTION]
           ,[THRESHOLD_SELECTION]
           ,[SELECTION_CRITERIA]
           ,[OPEN_ORIGINAL_TICKET]
           ,[RESET_THRESHOLD_HISTORY]
           ,@ID
           ,[ACTIVITY]
           ,[EXISTING_STATUS_CODE]
           ,[INCIDENT_ONLY_THRESHOLD]
           ,[ORDERING]
           ,[ACTION_ON_THRESHOLD_REACHED]
from  #CHRONIC_EVENT1

SET @RowCount = @RowCount + 1
END

Select * from vision.##CHRONIC_EVENT2

DROP TABLE #SecurityT
Drop Table #CHRONIC_EVENT1 


GO

-- Select * from [VISION].[CHRONIC_EVENT]

