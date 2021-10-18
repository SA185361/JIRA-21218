


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CMD_PROTOCOL1
DROP Table if exists vision.##CMD_PROTOCOL2


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

Create Table #CMD_PROTOCOL1 
(
   	
	[DESCRIPTION] [varchar](255) NULL,
	[TENANT_ID] [numeric](18, 0) NOT NULL,
	[DELETED] [char](1) NULL,
	[VERSION] [numeric](10, 0) NULL,
	[IMPLEMENTATION] [varchar](30) NULL,
	[COMMAND_SCRIPT] [varchar](max) NULL,
	[DISPLAY_ORDER] [numeric](10, 0) NULL,
	[GROUP_LINK] [numeric](10, 0) NOT NULL,
	[TRANSPORTATION_LINK] [numeric](10, 0) NOT NULL,
	[MENU_PROTOCOL_LINK] [smallint] NULL,
	[COMMAND_ROLE] [varchar](100) NULL)


Insert into #CMD_PROTOCOL1 
( 
         [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
           ,[COMMAND_SCRIPT]
           ,[DISPLAY_ORDER]
           ,[GROUP_LINK]
           ,[TRANSPORTATION_LINK]
           ,[MENU_PROTOCOL_LINK]
           ,[COMMAND_ROLE])
Select 

           
          [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
           ,[COMMAND_SCRIPT]
           ,[DISPLAY_ORDER]
           ,[GROUP_LINK]
           ,[TRANSPORTATION_LINK]
           ,[MENU_PROTOCOL_LINK]
           ,[COMMAND_ROLE]
from vision.CMD_PROTOCOL 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation

DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(protocol_link) + 1 from  Vision.CMD_PROTOCOL 
print @LINK

SET @sql = '
CREATE TABLE vision.##CMD_PROTOCOL2(
	[protocol_link] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
  [DESCRIPTION] [varchar](255) NULL,
	[TENANT_ID] [numeric](18, 0) NOT NULL,
	[DELETED] [char](1) NULL,
	[VERSION] [numeric](10, 0) NULL,
	[IMPLEMENTATION] [varchar](30) NULL,
	[COMMAND_SCRIPT] [varchar](max) NULL,
	[DISPLAY_ORDER] [numeric](10, 0) NULL,
	[GROUP_LINK] [numeric](10, 0) NOT NULL,
	[TRANSPORTATION_LINK] [numeric](10, 0) NOT NULL,
	[MENU_PROTOCOL_LINK] [smallint] NULL,
	[COMMAND_ROLE] [varchar](100) NULL)

	';

EXEC (@sql);



WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##CMD_PROTOCOL2
(
          [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
           ,[COMMAND_SCRIPT]
           ,[DISPLAY_ORDER]
           ,[GROUP_LINK]
           ,[TRANSPORTATION_LINK]
           ,[MENU_PROTOCOL_LINK]
           ,[COMMAND_ROLE])
Select 
  
         [DESCRIPTION]
           ,@ID
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
           ,[COMMAND_SCRIPT]
           ,[DISPLAY_ORDER]
           ,[GROUP_LINK]
           ,[TRANSPORTATION_LINK]
           ,[MENU_PROTOCOL_LINK]
           ,[COMMAND_ROLE]
from  #CMD_PROTOCOL1

SET @RowCount = @RowCount + 1
END


Select * from vision.##CMD_PROTOCOL2

DROP TABLE #SecurityT
Drop Table #CMD_PROTOCOL1 


GO

-- Select * from [VISION].[CMD_PROTOCOL]


