--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[REGION]    Script Date: 8/19/2021 8:02:18 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[REGION_TEST](
--	[LINK] [smallint] NOT NULL IDENTITY (310,1),
--	[DESCRIPTION] [nvarchar](30) NULL,
--	[PRCNT] [smallint] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	[VERSION] [int] NOT NULL,
-- CONSTRAINT [pk_REGION_TEST] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[REGION_TEST] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[REGION_TEST] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[REGION_TEST] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[REGION_TEST]  WITH NOCHECK ADD  CONSTRAINT [FK_REGION_TEST_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[REGION_TEST] CHECK CONSTRAINT [FK_REGION_TEST_TENANT_ID]
--GO




------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #REGION1

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

Create Table #REGION1 
(
   	
	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #REGION1 
([DESCRIPTION]
           ,[PRCNT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION] )
Select 

           [DESCRIPTION]
           ,[PRCNT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
from vision.REGION 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.REGION
(
 
           [DESCRIPTION]
           ,[PRCNT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION])
Select 
  
           [DESCRIPTION]
           ,[PRCNT]
           ,@ID
           ,[DELETED]
           ,[VERSION]
from  #REGION1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #REGION1 


GO

-- Select * from [VISION].[REGION]

-- DBCC CHECKIDENT('vision.REGION_Test')

-- DBCC CHECKIDENT('vision.REGION_Test',reseed,365)



--      Select 596 * 136
--      FINAL Total: 81056


--  DELETE from Vision.REGION_test

--  Select count(*) from [VISION].[REGION_Test]

--Select * from [VISION].[REGION_Test]
--where TENANT_ID =1 