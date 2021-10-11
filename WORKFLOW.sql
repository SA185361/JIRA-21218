--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[WORKFLOW]    Script Date: 8/30/2021 11:46:23 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[WORKFLOW_Test](
--	[DESCRIPTION] [nvarchar](200) NULL,
--	[PROCESS_ID] [varchar](50) NOT NULL,
--	[CODE] [nvarchar](max) NULL,
--	[CREATED_DATE] [datetime] NULL,
--	[CREATED_BY] [varchar](50) NULL,
--	[MODIFIED_DATE] [datetime] NULL,
--	[MODIFIED_BY] [varchar](50) NULL,
--	[DELETED] [char](1) NOT NULL,
--	[TENANT_ID] [numeric](19, 0) NULL,
--	[VERSION] [int] NOT NULL,
--	[WORKFLOW_ID] [numeric](5, 0) IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
-- CONSTRAINT [PK_WORKFLOW_Test_ID] PRIMARY KEY CLUSTERED 
--(
--	[WORKFLOW_ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[WORKFLOW_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[WORKFLOW_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[WORKFLOW_Test]  WITH CHECK ADD  CONSTRAINT [FK_WORKFLOW_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[WORKFLOW_Test] CHECK CONSTRAINT [FK_WORKFLOW_Test_TENANT_ID]
--GO






------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #WORKFLOW1

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

Create Table #WORKFLOW1 
(
   	
	[DESCRIPTION] [nvarchar](200) NULL,
	[PROCESS_ID] [varchar](50) NOT NULL,
	[CODE] [nvarchar](max) NULL,
	[CREATED_DATE] [datetime] NULL,
	[CREATED_BY] [varchar](50) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[MODIFIED_BY] [varchar](50) NULL,
	[DELETED] [char](1) NOT NULL,
	[TENANT_ID] [numeric](19, 0) NULL,
	[VERSION] [int] NOT NULL,)


Insert into #WORKFLOW1 
(   [DESCRIPTION]
           ,[PROCESS_ID]
           ,[CODE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[DELETED]
           ,[TENANT_ID]
           ,[VERSION] )
Select 

            [DESCRIPTION]
           ,[PROCESS_ID]
           ,[CODE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[DELETED]
           ,[TENANT_ID]
           ,[VERSION]
from vision.WORKFLOW 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.WORKFLOW
(
   [DESCRIPTION]
           ,[PROCESS_ID]
           ,[CODE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[DELETED]
           ,[TENANT_ID]
           ,[VERSION])
Select 
     [DESCRIPTION]
           ,[PROCESS_ID]
           ,[CODE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[DELETED]
           ,@ID
           ,[VERSION]
from  #WORKFLOW1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #WORKFLOW1 


GO

-- Select * from [VISION].[WORKFLOW]

-- DBCC CHECKIDENT('vision.WORKFLOW_Test')

-- DBCC CHECKIDENT('vision.WORKFLOW_Test',reseed,76)



--      Select 596 * 37
--      FINAL Total: 22052


--  DELETE from Vision.WORKFLOW_test

--  Select count(*) from [VISION].[WORKFLOW_Test]

--Select * from [VISION].[WORKFLOW_Test]
--where TENANT_ID =1 