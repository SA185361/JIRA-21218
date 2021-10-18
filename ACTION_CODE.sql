


DROP Table IF Exists #SecurityT
DROP Table IF Exists #ACTION_CODE1
DROP Table if exists vision.##ACTION_CODE2

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

Create Table #ACTION_CODE1 
(
   	
	[DESCRIPTION] [nvarchar](30) NULL,
	[RGB_COLOR] [int] NULL,
	[REOPEN_LIMIT] [smallint] NULL,
	[ACTION_COLUMN] [smallint] NULL,
	[FILTER] [int] NULL,
	[COLOR] [smallint] NULL,
	[ARRIVAL_TO_CLEAR] [int] NULL,
	[PERFORMANCE_COL] [smallint] NULL,
	[PERFORMANCE_132COL] [smallint] NULL,
	[AUTODIALER] [smallint] NULL,
	[DOWNHOURS1] [int] NULL,
	[DOWNCOLOR1] [int] NULL,
	[DOWNHOURS2] [int] NULL,
	[DOWNCOLOR2] [int] NULL,
	[DOWNHOURS3] [int] NULL,
	[DOWNCOLOR3] [int] NULL,
	[VERSION] [int] NOT NULL,
	[MAINTENANCE_MODE_EXCEPTION] [char](1) NULL)


Insert into #ACTION_CODE1 
([DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION] )
Select 

          [DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION]
from vision.ACTION_CODE 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.ACTION_CODE
print @LINK

SET @sql = '
CREATE TABLE vision.##ACTION_CODE2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [DESCRIPTION] [nvarchar](30) NULL,
	[RGB_COLOR] [int] NULL,
	[REOPEN_LIMIT] [smallint] NULL,
	[ACTION_COLUMN] [smallint] NULL,
	[FILTER] [int] NULL,
	[COLOR] [smallint] NULL,
	[ARRIVAL_TO_CLEAR] [int] NULL,
	[PERFORMANCE_COL] [smallint] NULL,
	[PERFORMANCE_132COL] [smallint] NULL,
	[AUTODIALER] [smallint] NULL,
	[DOWNHOURS1] [int] NULL,
	[DOWNCOLOR1] [int] NULL,
	[DOWNHOURS2] [int] NULL,
	[DOWNCOLOR2] [int] NULL,
	[DOWNHOURS3] [int] NULL,
	[DOWNCOLOR3] [int] NULL,
	[VERSION] [int] NOT NULL,
	[MAINTENANCE_MODE_EXCEPTION] [char](1) NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##ACTION_CODE2
(
 [DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION])
Select 
  [DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION]
from  #ACTION_CODE1

SET @RowCount = @RowCount + 1
END

Select * from vision.##ACTION_CODE2

DROP TABLE #SecurityT
Drop Table #ACTION_CODE1 


GO

-- Select * from [VISION].[ACTION_CODE]
