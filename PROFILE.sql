--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[PROFILE]    Script Date: 8/30/2021 8:36:06 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[PROFILE_Test](
--	[ID] [bigint] IDENTITY(1,1) NOT NULL,
--	[NAME] [varchar](100) NOT NULL,
--	[DESCRIPTION] [varchar](200) NULL,
--	[USER_ID] [varchar](100) NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[INC_UNDEFINED] [int] NOT NULL,
--	[TERMINAL_CRITERIA] [varbinary](max) NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[PROFILE_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[PROFILE_Test] ADD  DEFAULT ((0)) FOR [INC_UNDEFINED]
--GO

--ALTER TABLE [VISION].[PROFILE_Test]  WITH CHECK ADD  CONSTRAINT [FK_PROFILE_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[PROFILE_Test] CHECK CONSTRAINT [FK_PROFILE_Test_TENANT_ID]
--GO






------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #PROFILE1

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

Create Table #PROFILE1 
(
   	
	[NAME] [varchar](100) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[USER_ID] [varchar](100) NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[INC_UNDEFINED] [int] NOT NULL,
	[TERMINAL_CRITERIA] [varbinary](max) NULL)


Insert into #PROFILE1 
(  [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,[TENANT_ID]
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA] )
Select 

           [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,[TENANT_ID]
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA]
from vision.PROFILE 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.PROFILE
(
   [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,[TENANT_ID]
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA])
Select 
   [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,@ID
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA]
from  #PROFILE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #PROFILE1 


GO

-- Select * from [VISION].[PROFILE]

-- DBCC CHECKIDENT('vision.PROFILE_Test')

-- DBCC CHECKIDENT('vision.PROFILE_Test',reseed,76)



--      Select 596 * 0
--      FINAL Total: 44700


--  DELETE from Vision.PROFILE_test

--  Select count(*) from [VISION].[PROFILE_Test]

--Select * from [VISION].[PROFILE_Test]
--where TENANT_ID =1 