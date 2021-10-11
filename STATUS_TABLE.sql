--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[STATUS_TABLE]    Script Date: 8/19/2021 6:48:09 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[STATUS_TABLE_Test](
--	[NAME] [nvarchar](120) NULL,
--	[LENGTH] [smallint] NULL,
--	[STATUS_TYPE] [smallint] NULL,
--	[STATUS_POSITION] [smallint] NULL,
--	[DATE_FORMAT] [smallint] NULL,
--	[DATE_POSITION] [smallint] NULL,
--	[TIME_POSITION] [smallint] NULL,
--	[DEFINED] [smallint] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	[VERSION] [int] NOT NULL,
--	[LINK] [numeric](10, 0) IDENTITY(43,1) NOT NULL,
-- CONSTRAINT [pk_STATUS_TABLE_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[STATUS_TABLE_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[STATUS_TABLE_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[STATUS_TABLE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[STATUS_TABLE_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_STATUS_TABLE_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[STATUS_TABLE_Test] CHECK CONSTRAINT [FK_STATUS_TABLE_Test_TENANT_ID]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #STATUS_TABLE1

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

Create Table #STATUS_TABLE1 
(
[NAME] [nvarchar](120) NULL,
	[LENGTH] [smallint] NULL,
	[STATUS_TYPE] [smallint] NULL,
	[STATUS_POSITION] [smallint] NULL,
	[DATE_FORMAT] [smallint] NULL,
	[DATE_POSITION] [smallint] NULL,
	[TIME_POSITION] [smallint] NULL,
	[DEFINED] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL
)


Insert into #STATUS_TABLE1 
(
[NAME]
           ,[LENGTH]
           ,[STATUS_TYPE]
           ,[STATUS_POSITION]
           ,[DATE_FORMAT]
           ,[DATE_POSITION]
           ,[TIME_POSITION]
           ,[DEFINED]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION] )
Select 
[NAME]
           ,[LENGTH]
           ,[STATUS_TYPE]
           ,[STATUS_POSITION]
           ,[DATE_FORMAT]
           ,[DATE_POSITION]
           ,[TIME_POSITION]
           ,[DEFINED]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
from vision.STATUS_TABLE 
where Tenant_id = 0
-- where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.STATUS_TABLE
(
[NAME]
,[LENGTH]
,[STATUS_TYPE]
,[STATUS_POSITION]
,[DATE_FORMAT]
,[DATE_POSITION]
,[TIME_POSITION]
,[DEFINED]
,[TENANT_ID]
,[DELETED]
,[VERSION])
Select 
[NAME]
,[LENGTH]
,[STATUS_TYPE]
,[STATUS_POSITION]
,[DATE_FORMAT]
,[DATE_POSITION]
,[TIME_POSITION]
,[DEFINED]
,@Id
,[DELETED]
,[VERSION]
from  #STATUS_TABLE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #STATUS_TABLE1 


GO

-- Select * from [VISION].[STATUS_TABLE]

-- DBCC CHECKIDENT('vision.STATUS_TABLE_Test')

-- DBCC CHECKIDENT('vision.STATUS_TABLE_Test',reseed,365)



--      Select 596 * 34
--      FINAL Total: 20264


--  DELETE from Vision.STATUS_TABLE_test

--  Select count(*) from [VISION].[STATUS_TABLE_Test]

--Select * from [VISION].[STATUS_TABLE_Test]
--where TENANT_ID =1 