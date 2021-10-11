--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[LINK_THRESHOLD_GROUP]    Script Date: 8/18/2021 11:25:29 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[LINK_THRESHOLD_GROUP_TEST](
--	[LINK] [smallint] NOT NULL,
--	[DESCRIPTION] [char](30) NOT NULL,
--	[THRESH_TYPE] [smallint] NULL,
--	[EXCEPTIONDAY_1] [smallint] NULL,
--	[EXCEPTIONDAY_2] [smallint] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
-- CONSTRAINT [pk_LINK_THRESHOLD_GROUP_TEST] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[LINK_THRESHOLD_GROUP_TEST] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[LINK_THRESHOLD_GROUP_TEST] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[LINK_THRESHOLD_GROUP_TEST]  WITH CHECK ADD  CONSTRAINT [FK_LINK_THRES_GROUP_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[LINK_THRESHOLD_GROUP_TEST] CHECK CONSTRAINT [FK_LINK_THRES_GROUP_TENANT_ID]
--GO



------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #LINK_THRESHOLD_GROUP1

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

Create Table #LINK_THRESHOLD_GROUP1 
(
    [DESCRIPTION] [char](30) NOT NULL,
	[THRESH_TYPE] [smallint] NULL,
	[EXCEPTIONDAY_1] [smallint] NULL,
	[EXCEPTIONDAY_2] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL)


Insert into #LINK_THRESHOLD_GROUP1 
Select 
[DESCRIPTION]
,[THRESH_TYPE]
,[EXCEPTIONDAY_1]
,[EXCEPTIONDAY_2]
,[TENANT_ID]
,[DELETED]
from vision.LINK_THRESHOLD_GROUP 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.LINK_THRESHOLD_GROUP
(
[DESCRIPTION]
,[THRESH_TYPE]
,[EXCEPTIONDAY_1]
,[EXCEPTIONDAY_2]
,[TENANT_ID]
,[DELETED])
Select 
[DESCRIPTION]
,[THRESH_TYPE]
,[EXCEPTIONDAY_1]
,[EXCEPTIONDAY_2]
,@ID
,[DELETED]
from  #LINK_THRESHOLD_GROUP1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #LINK_THRESHOLD_GROUP1 


GO

-- Select * from [VISION].[LINK_THRESHOLD_GROUP]

-- DBCC CHECKIDENT('vision.LINK_THRESHOLD_GROUP_Test')

-- DBCC CHECKIDENT('vision.LINK_THRESHOLD_GROUP_Test',reseed,365)



--      Select 596 * 0
--      FINAL Total: 10132


--  DELETE from Vision.LINK_THRESHOLD_GROUP_test

--  Select count(*) from [VISION].[LINK_THRESHOLD_GROUP_Test]

--Select * from [VISION].[LINK_THRESHOLD_GROUP_Test]
--where TENANT_ID =1 