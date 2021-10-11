--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[CMD_GROUP_Test]    Script Date: 8/19/2021 8:44:17 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[CMD_GROUP_Test](
--	[GROUP_LINK] [numeric](10, 0) Identity(4,1)NOT NULL,
--	[DESCRIPTION] [varchar](255) NULL,
--	[TENANT_ID] [numeric](18, 0) NOT NULL,
--	[DELETED] [char](1) NULL,
--	[VERSION] [numeric](10, 0) NULL,
--	[IMPLEMENTATION] [varchar](255) NULL,
-- CONSTRAINT [PK_CMD_GROUP_Test] PRIMARY KEY CLUSTERED 
--(
--	[GROUP_LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[CMD_GROUP_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[CMD_GROUP_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[CMD_GROUP_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CMD_GROUP1

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

Create Table #CMD_GROUP1 
(
   	
	[DESCRIPTION] [varchar](255) NULL,
	[TENANT_ID] [numeric](18, 0) NOT NULL,
	[DELETED] [char](1) NULL,
	[VERSION] [numeric](10, 0) NULL,
	[IMPLEMENTATION] [varchar](255) NULL)


Insert into #CMD_GROUP1 
( 
           [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION])
Select 

           
           [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
from vision.CMD_GROUP 
where Tenant_id = 0
-- where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CMD_GROUP
(
          [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION])
Select 
  
           [DESCRIPTION]
           ,@ID
           ,[DELETED]
           ,[VERSION]
           ,[IMPLEMENTATION]
from  #CMD_GROUP1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #CMD_GROUP1 


GO

-- Select * from [VISION].[CMD_GROUP]

-- DBCC CHECKIDENT('vision.CMD_GROUP_Test')

-- DBCC CHECKIDENT('vision.CMD_GROUP_Test',reseed,365)



--      Select 596 * 3
--      FINAL Total: 1788


--  DELETE from Vision.CMD_GROUP_test

--  Select count(*) from [VISION].[CMD_GROUP_Test]

--Select * from [VISION].[CMD_GROUP_Test]
--where TENANT_ID =1 