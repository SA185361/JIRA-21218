--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[HOLIDAY_Test]    Script Date: 8/18/2021 11:02:32 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[HOLIDAY_Test](
--	[DESCRIPTION] [nvarchar](30) NULL,
--	[DEFINED] [smallint] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	[VERSION] [int] NOT NULL,
--	[LINK] [smallint] IDENTITY(1,1) NOT NULL,
-- CONSTRAINT [pk_HOLIDAY_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[HOLIDAY_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[HOLIDAY_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[HOLIDAY_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[HOLIDAY_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_HOLIDAY_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[HOLIDAY_Test] CHECK CONSTRAINT [FK_HOLIDAY_Test_TENANT_ID]
--GO


----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #HOLIDAY1

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

Create Table #HOLIDAY1 
(
   	[DESCRIPTION] [nvarchar](30) NULL,
	[DEFINED] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #HOLIDAY1 
(
   [DESCRIPTION]
           ,[DEFINED]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION])
Select 
            [DESCRIPTION]
           ,[DEFINED]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
from vision.HOLIDAY 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.HOLIDAY
(
 [DESCRIPTION]
 ,[DEFINED]
 ,[TENANT_ID]
 ,[DELETED]
 ,[VERSION]
 )
Select 
[DESCRIPTION]
,[DEFINED]
,@ID
,[DELETED]
,[VERSION]

from  #HOLIDAY1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #HOLIDAY1 


GO

-- Select * from [VISION].[HOLIDAY]

-- DBCC CHECKIDENT('vision.HOLIDAY_Test')

-- DBCC CHECKIDENT('vision.HOLIDAY_Test',reseed,365)



--      Select 596 * 7 + 17 +7
--      FINAL Total: 14304


--  DELETE from Vision.HOLIDAY_test

--  Select count(*) from [VISION].[HOLIDAY_Test]

Select * from [VISION].[HOLIDAY_Test]
where TENANT_ID =1 