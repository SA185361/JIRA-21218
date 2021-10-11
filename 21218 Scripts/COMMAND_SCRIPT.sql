--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[COMMAND_SCRIPT]    Script Date: 8/19/2021 9:58:08 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[COMMAND_SCRIPT_Test](
--	[LINK] [smallint] NOT NULL Identity(19,1),
--	[DESCRIPTION] [varchar](30) NULL,
--	[SPOKEN_TEXT] [varchar](70) NULL,
--	[VERIFIED] [int] NULL,
--	[DISPATCHER_MENU] [smallint] NULL,
--	[DISPATCHER_SUBMENU] [smallint] NULL,
--	[WORKSTATION_MENU] [smallint] NULL,
--	[CONNECTION_GROUP_LINK] [smallint] NULL,
--	[NOTIFICATION_METHOD] [smallint] NULL,
--	[LONG_TEXT] [text] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
-- CONSTRAINT [pk_COMMAND_SCRIPT_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[COMMAND_SCRIPT_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[COMMAND_SCRIPT_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[COMMAND_SCRIPT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_COMMAND_SCRIPT_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[COMMAND_SCRIPT_Test] CHECK CONSTRAINT [FK_COMMAND_SCRIPT_Test_TENANT_ID]
--GO







------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #COMMAND_SCRIPT1

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
  FROM [GLOBAL].[VISION].[COMMAND_SCRIPT]
  where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.COMMAND_SCRIPT
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

DROP TABLE #SecurityT
Drop Table #COMMAND_SCRIPT1 


GO

-- Select * from [VISION].[COMMAND_SCRIPT]

-- DBCC CHECKIDENT('vision.COMMAND_SCRIPT_Test')

-- DBCC CHECKIDENT('vision.COMMAND_SCRIPT_Test',reseed,31)



--      Select 596 * 18
--      FINAL Total: 10728


--  DELETE from Vision.COMMAND_SCRIPT_test

--  Select count(*) from [VISION].[COMMAND_SCRIPT_Test]

--Select * from [VISION].[COMMAND_SCRIPT_Test]
--where TENANT_ID =1 