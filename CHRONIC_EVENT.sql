--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[CHRONIC_EVENT]    Script Date: 8/19/2021 7:48:20 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[CHRONIC_EVENT_Test](
--	[DESCRIPTION] [varchar](100) NULL,
--	[OPEN_STATUS_CODE_LINK] [nvarchar](50) NULL,
--	[THRESHOLD_COUNT] [numeric](18, 0) NOT NULL,
--	[THRESHOLD_INTERVAL] [numeric](18, 0) NOT NULL,
--	[CATEGORY_SELECTION] [numeric](18, 0) NOT NULL,
--	[THRESHOLD_SELECTION] [numeric](18, 0) NOT NULL,
--	[SELECTION_CRITERIA] [char](1000) NOT NULL,
--	[OPEN_ORIGINAL_TICKET] [char](1) NULL,
--	[RESET_THRESHOLD_HISTORY] [char](1) NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[ACTIVITY] [int] NOT NULL,
--	[EXISTING_STATUS_CODE] [varchar](100) NULL,
--	[LINK] [numeric](18, 0) IDENTITY(26,1) NOT NULL,
--	[INCIDENT_ONLY_THRESHOLD] [char](1) NOT NULL,
--	[ORDERING] [int] NOT NULL,
--	[ACTION_ON_THRESHOLD_REACHED] [int] NOT NULL,
-- CONSTRAINT [PK_CHRONIC_EVENT_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] ADD  DEFAULT ((0)) FOR [ACTIVITY]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] ADD  DEFAULT ('N') FOR [INCIDENT_ONLY_THRESHOLD]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] ADD  DEFAULT ((1)) FOR [ORDERING]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] ADD  DEFAULT ((1)) FOR [ACTION_ON_THRESHOLD_REACHED]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_ACTION_ON_THRESHOLD_REACHED] FOREIGN KEY([ACTION_ON_THRESHOLD_REACHED])
--REFERENCES [VISION].[GLOBAL_ATTRIBUTES_VALUES] ([ID])
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] CHECK CONSTRAINT [FK_ACTION_ON_THRESHOLD_REACHED]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CHRONIC_EVENT_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] CHECK CONSTRAINT [FK_CHRONIC_EVENT_Test_TENANT_ID]
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_ORDERING] FOREIGN KEY([ORDERING])
--REFERENCES [VISION].[GLOBAL_ATTRIBUTES_VALUES] ([ID])
--GO

--ALTER TABLE [VISION].[CHRONIC_EVENT_Test] CHECK CONSTRAINT [FK_ORDERING]
--GO






----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CHRONIC_EVENT1

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


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CHRONIC_EVENT
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

DROP TABLE #SecurityT
Drop Table #CHRONIC_EVENT1 


GO

-- Select * from [VISION].[CHRONIC_EVENT]

-- DBCC CHECKIDENT('vision.CHRONIC_EVENT_Test')

-- DBCC CHECKIDENT('vision.CHRONIC_EVENT_Test',reseed,365)



--      Select 596 * 15
--      FINAL Total: 8940


--  DELETE from Vision.CHRONIC_EVENT_test

--  Select count(*) from [VISION].[CHRONIC_EVENT_Test]

Select * from [VISION].[CHRONIC_EVENT_Test]
where TENANT_ID =1 