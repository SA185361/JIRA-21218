



DROP Table IF Exists #SecurityT
DROP Table IF Exists #PROTOCOL1
DROP Table if exists vision.##PROTOCOL2


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

Create Table #PROTOCOL1 
(
  [DESCRIPTION] [nvarchar](30) NULL,
	[VERIFIED] [int] NULL,
	[CONNECTION_GROUP_LINK] [smallint] NULL,
	[NOTIFICATION_METHOD] [smallint] NULL,
	[DISPATCHER_MENU] [smallint] NULL,
	[DISPATCHER_SUBMENU] [smallint] NULL,
	[WORKSTATION_MENU] [smallint] NULL,
	[SPOKEN_TEXT] [char](70) NULL,
	[LONG_TEXT] [text] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[OUTGOING_DIRECTORY] [nvarchar](180) NULL,
	[INCOMING_DIRECTORY] [nvarchar](180) NULL,
	[OUTGOING_TEMPLATE] [nvarchar](60) NULL,
	[INCOMING_TEMPLATE] [nvarchar](60) NULL,
	[CUSTOMER_CODE] [nvarchar](20) NULL,
	[INCOMING_POLLING_INTERVAL] [numeric](3, 0) NULL,
	[LINK] [smallint] IDENTITY(1,1) NOT NULL,
	[IS_ABSOLUTE_PATH] [char](1) NOT NULL)


Insert into #PROTOCOL1 
Select 
	        [DESCRIPTION]
           ,[VERIFIED]
           ,[CONNECTION_GROUP_LINK]
           ,[NOTIFICATION_METHOD]
           ,[DISPATCHER_MENU]
           ,[DISPATCHER_SUBMENU]
           ,[WORKSTATION_MENU]
           ,[SPOKEN_TEXT]
           ,[LONG_TEXT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[OUTGOING_DIRECTORY]
           ,[INCOMING_DIRECTORY]
           ,[OUTGOING_TEMPLATE]
           ,[INCOMING_TEMPLATE]
           ,[CUSTOMER_CODE]
           ,[INCOMING_POLLING_INTERVAL]
           ,[IS_ABSOLUTE_PATH]
from vision.PROTOCOL 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.PROTOCOL 
print @LINK

SET @sql = '
CREATE TABLE vision.##PROTOCOL2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [DESCRIPTION] [nvarchar](30) NULL,
	[VERIFIED] [int] NULL,
	[CONNECTION_GROUP_LINK] [smallint] NULL,
	[NOTIFICATION_METHOD] [smallint] NULL,
	[DISPATCHER_MENU] [smallint] NULL,
	[DISPATCHER_SUBMENU] [smallint] NULL,
	[WORKSTATION_MENU] [smallint] NULL,
	[SPOKEN_TEXT] [char](70) NULL,
	[LONG_TEXT] [text] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[OUTGOING_DIRECTORY] [nvarchar](180) NULL,
	[INCOMING_DIRECTORY] [nvarchar](180) NULL,
	[OUTGOING_TEMPLATE] [nvarchar](60) NULL,
	[INCOMING_TEMPLATE] [nvarchar](60) NULL,
	[CUSTOMER_CODE] [nvarchar](20) NULL,
	[INCOMING_POLLING_INTERVAL] [numeric](3, 0) NULL,
	[IS_ABSOLUTE_PATH] [char](1) NOT NULL)

	';

EXEC (@sql);







WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##PROTOCOL2
(
 [DESCRIPTION]
,[VERIFIED]
,[CONNECTION_GROUP_LINK]
,[NOTIFICATION_METHOD]
,[DISPATCHER_MENU]
,[DISPATCHER_SUBMENU]
,[WORKSTATION_MENU]
,[SPOKEN_TEXT]
,[LONG_TEXT]
,[TENANT_ID]
,[DELETED]
,[OUTGOING_DIRECTORY]
,[INCOMING_DIRECTORY]
,[OUTGOING_TEMPLATE]
,[INCOMING_TEMPLATE]
,[CUSTOMER_CODE]
,[INCOMING_POLLING_INTERVAL]
,[IS_ABSOLUTE_PATH]
		   )
Select 
	   [DESCRIPTION]
           ,[VERIFIED]
           ,[CONNECTION_GROUP_LINK]
           ,[NOTIFICATION_METHOD]
           ,[DISPATCHER_MENU]
           ,[DISPATCHER_SUBMENU]
           ,[WORKSTATION_MENU]
           ,[SPOKEN_TEXT]
           ,[LONG_TEXT]
           ,@ID
           ,[DELETED]
           ,[OUTGOING_DIRECTORY]
           ,[INCOMING_DIRECTORY]
           ,[OUTGOING_TEMPLATE]
           ,[INCOMING_TEMPLATE]
           ,[CUSTOMER_CODE]
           ,[INCOMING_POLLING_INTERVAL]
           ,[IS_ABSOLUTE_PATH]
from  #PROTOCOL1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #PROTOCOL1 


GO


select * from vision.##PROTOCOL2

-- Select * from [VISION].[PROTOCOL]

-- DBCC CHECKIDENT('vision.PROTOCOL_Test')

-- DBCC CHECKIDENT('vision.PROTOCOL_Test',reseed,365)



--      Select 596 * 7
--      FINAL Total: 4172


--  DELETE from Vision.PROTOCOL_test

--  Select count(*) from [VISION].[PROTOCOL_Test]

--Select * from [VISION].[PROTOCOL_Test]
--where TENANT_ID =1 