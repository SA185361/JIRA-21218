


DROP Table IF Exists #SecurityT
DROP Table IF Exists #COMMAND_SCRIPT1
DROP Table if exists vision.##COMMAND_SCRIPT2

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

Create Table #COMMAND_SCRIPT1 
(
   	
	[DESCRIPTION] [varchar](30) NULL,
	[SPOKEN_TEXT] [varchar](70) NULL,
	[VERIFIED] [int] NULL,
	[DISPATCHER_MENU] [smallint] NULL,
	[DISPATCHER_SUBMENU] [smallint] NULL,
	[WORKSTATION_MENU] [smallint] NULL,
	[CONNECTION_GROUP_LINK] [smallint] NULL,
	[NOTIFICATION_METHOD] [smallint] NULL,
	[LONG_TEXT] [text] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL)


Insert into #COMMAND_SCRIPT1 
( 
         [DESCRIPTION]
           ,[SPOKEN_TEXT]
           ,[VERIFIED]
           ,[DISPATCHER_MENU]
           ,[DISPATCHER_SUBMENU]
           ,[WORKSTATION_MENU]
           ,[CONNECTION_GROUP_LINK]
           ,[NOTIFICATION_METHOD]
           ,[LONG_TEXT]
           ,[TENANT_ID]
           ,[DELETED])

SELECT 
      [DESCRIPTION]
      ,[SPOKEN_TEXT]
      ,[VERIFIED]
      ,[DISPATCHER_MENU]
      ,[DISPATCHER_SUBMENU]
      ,[WORKSTATION_MENU]
      ,[CONNECTION_GROUP_LINK]
      ,[NOTIFICATION_METHOD]
      ,[LONG_TEXT]
      ,[TENANT_ID]
      ,[DELETED]
  FROM [VISION].[COMMAND_SCRIPT]
  where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from [VISION].[COMMAND_SCRIPT]
print @LINK

SET @sql = '
CREATE TABLE vision.##COMMAND_SCRIPT2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [DESCRIPTION] [varchar](30) NULL,
	[SPOKEN_TEXT] [varchar](70) NULL,
	[VERIFIED] [int] NULL,
	[DISPATCHER_MENU] [smallint] NULL,
	[DISPATCHER_SUBMENU] [smallint] NULL,
	[WORKSTATION_MENU] [smallint] NULL,
	[CONNECTION_GROUP_LINK] [smallint] NULL,
	[NOTIFICATION_METHOD] [smallint] NULL,
	[LONG_TEXT] [text] NULL,
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


Insert into vision.##COMMAND_SCRIPT2
(
       [DESCRIPTION]
      ,[SPOKEN_TEXT]
      ,[VERIFIED]
      ,[DISPATCHER_MENU]
      ,[DISPATCHER_SUBMENU]
      ,[WORKSTATION_MENU]
      ,[CONNECTION_GROUP_LINK]
      ,[NOTIFICATION_METHOD]
      ,[LONG_TEXT]
      ,[TENANT_ID]
      ,[DELETED])
Select 
  
        [DESCRIPTION]
           ,[SPOKEN_TEXT]
           ,[VERIFIED]
           ,[DISPATCHER_MENU]
           ,[DISPATCHER_SUBMENU]
           ,[WORKSTATION_MENU]
           ,[CONNECTION_GROUP_LINK]
           ,[NOTIFICATION_METHOD]
           ,[LONG_TEXT]
           ,@ID
           ,[DELETED]
from  #COMMAND_SCRIPT1

SET @RowCount = @RowCount + 1
END

Select * from vision.##COMMAND_SCRIPT2

DROP TABLE #SecurityT
Drop Table #COMMAND_SCRIPT1 


GO

-- Select * from [VISION].[COMMAND_SCRIPT]
