USE [GLOBAL]
GO

/****** Object:  Table [VISION].[CMD_PROTOCOL_Test]    Script Date: 8/19/2021 8:51:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [VISION].[CMD_PROTOCOL_Test](
	[PROTOCOL_LINK] [numeric](10, 0) IDENTITY(31,1) NOT NULL,
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
	[COMMAND_ROLE] [varchar](100) NULL,
 CONSTRAINT [PK_CMD_PROTOCOL_Test] PRIMARY KEY CLUSTERED 
(
	[PROTOCOL_LINK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test] ADD  DEFAULT ('N') FOR [DELETED]
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test] ADD  DEFAULT ((1)) FOR [VERSION]
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CT_CMD_PROTOCOL_LINK] FOREIGN KEY([GROUP_LINK])
REFERENCES [VISION].[CMD_PROTOCOL] ([GROUP_LINK])
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test] CHECK CONSTRAINT [FK_CT_CMD_PROTOCOL_LINK]
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CT_CMD_TRANSPORTATION_LINK] FOREIGN KEY([TRANSPORTATION_LINK])
REFERENCES [VISION].[CMD_TRANSPORTATION] ([TRANSPORTATION_LINK])
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test] CHECK CONSTRAINT [FK_CT_CMD_TRANSPORTATION_LINK]
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CT_MENU_PROTOCOL] FOREIGN KEY([MENU_PROTOCOL_LINK])
REFERENCES [VISION].[MENU_PROTOCOL] ([LINK])
GO

ALTER TABLE [VISION].[CMD_PROTOCOL_Test] CHECK CONSTRAINT [FK_CT_MENU_PROTOCOL]
GO





----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CMD_PROTOCOL1

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
where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CMD_PROTOCOL_test
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

DROP TABLE #SecurityT
Drop Table #CMD_PROTOCOL1 


GO

-- Select * from [VISION].[CMD_PROTOCOL]

-- DBCC CHECKIDENT('vision.CMD_PROTOCOL_Test')

-- DBCC CHECKIDENT('vision.CMD_PROTOCOL_Test',reseed,31)



--      Select 596 * 28
--      FINAL Total: 16688


--  DELETE from Vision.CMD_PROTOCOL_test

--  Select count(*) from [VISION].[CMD_PROTOCOL_Test]

Select * from [VISION].[CMD_PROTOCOL_Test]
where TENANT_ID =1 