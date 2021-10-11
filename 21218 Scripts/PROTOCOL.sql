--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[PROTOCOL]    Script Date: 8/19/2021 4:45:10 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[PROTOCOL_Test](
--	[DESCRIPTION] [nvarchar](30) NULL,
--	[VERIFIED] [int] NULL,
--	[CONNECTION_GROUP_LINK] [smallint] NULL,
--	[NOTIFICATION_METHOD] [smallint] NULL,
--	[DISPATCHER_MENU] [smallint] NULL,
--	[DISPATCHER_SUBMENU] [smallint] NULL,
--	[WORKSTATION_MENU] [smallint] NULL,
--	[SPOKEN_TEXT] [char](70) NULL,
--	[LONG_TEXT] [text] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	[OUTGOING_DIRECTORY] [nvarchar](180) NULL,
--	[INCOMING_DIRECTORY] [nvarchar](180) NULL,
--	[OUTGOING_TEMPLATE] [nvarchar](60) NULL,
--	[INCOMING_TEMPLATE] [nvarchar](60) NULL,
--	[CUSTOMER_CODE] [nvarchar](20) NULL,
--	[INCOMING_POLLING_INTERVAL] [numeric](3, 0) NULL,
--	[LINK] [smallint] IDENTITY(7,1) NOT NULL,
--	[IS_ABSOLUTE_PATH] [char](1) NOT NULL,
-- CONSTRAINT [pk_PROTOCOL_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test] ADD  DEFAULT ((0)) FOR [INCOMING_POLLING_INTERVAL]
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test] ADD  DEFAULT ('N') FOR [IS_ABSOLUTE_PATH]
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_PROTOCOL_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test] CHECK CONSTRAINT [FK_PROTOCOL_Test_TENANT_ID]
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test]  WITH NOCHECK ADD  CONSTRAINT [CHK_PROTOCOL_Test_ABSOLUTE_PATH] CHECK  (([IS_ABSOLUTE_PATH]='N' OR [IS_ABSOLUTE_PATH]='Y'))
--GO

--ALTER TABLE [VISION].[PROTOCOL_Test] CHECK CONSTRAINT [CHK_PROTOCOL_Test_ABSOLUTE_PATH]
--GO


--------------------------------------------------------



DROP Table IF Exists #SecurityT
DROP Table IF Exists #PROTOCOL1

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
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.PROTOCOL
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

-- Select * from [VISION].[PROTOCOL]

-- DBCC CHECKIDENT('vision.PROTOCOL_Test')

-- DBCC CHECKIDENT('vision.PROTOCOL_Test',reseed,365)



--      Select 596 * 7
--      FINAL Total: 4172


--  DELETE from Vision.PROTOCOL_test

--  Select count(*) from [VISION].[PROTOCOL_Test]

--Select * from [VISION].[PROTOCOL_Test]
--where TENANT_ID =1 