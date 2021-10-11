--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[TERMINAL]    Script Date: 8/30/2021 11:27:41 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[TERMINAL_Test](
--	[ID] [bigint] IDENTITY(5540,1) NOT NULL,
--	[NAME] [nvarchar](30) NOT NULL,
--	[IP_ADDRESS] [nvarchar](30) NULL,
--	[ENTITY_REF_ID] [int] NULL,
--	[MAC_ADDRESS] [nvarchar](30) NULL,
--	[WORKSTATION_NAME] [nvarchar](30) NULL,
--	[UUID] [nvarchar](36) NULL,
--	[ENTITY_PAIRED] [bit] NULL,
--	[CUSTOMER_CODE] [nvarchar](50) NULL,
--	[TERMINAL_TYPE] [nvarchar](3) NULL,
--	[POLLING_MODE] [nvarchar](10) NULL,
--	[DEFAULT_POLLING_INTERVAL] [int] NULL,
--	[ACTIVE_POLLING_INTERVAL] [int] NULL,
--	[ACTIVE_POLLING_PERIOD] [int] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[UA_VERSION] [varchar](50) NULL,
--	[CREATED_DATE] [datetime] NULL,
--	[UPDATED_DATE] [datetime] NULL,
--	[ATM_VERSION] [varchar](50) NULL,
-- CONSTRAINT [PK_TERMINAL_Test] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[TERMINAL_Test] ADD  DEFAULT ((0)) FOR [ENTITY_PAIRED]
--GO

--ALTER TABLE [VISION].[TERMINAL_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[TERMINAL_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_TERMINAL_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[TERMINAL_Test] CHECK CONSTRAINT [FK_TERMINAL_Test_TENANT_ID]
--GO




------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #TERMINAL1

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

Create Table #TERMINAL1 
(
   	
	[NAME] [nvarchar](30) NOT NULL,
	[IP_ADDRESS] [nvarchar](30) NULL,
	[ENTITY_REF_ID] [int] NULL,
	[MAC_ADDRESS] [nvarchar](30) NULL,
	[WORKSTATION_NAME] [nvarchar](30) NULL,
	[UUID] [nvarchar](36) NULL,
	[ENTITY_PAIRED] [bit] NULL,
	[CUSTOMER_CODE] [nvarchar](50) NULL,
	[TERMINAL_TYPE] [nvarchar](3) NULL,
	[POLLING_MODE] [nvarchar](10) NULL,
	[DEFAULT_POLLING_INTERVAL] [int] NULL,
	[ACTIVE_POLLING_INTERVAL] [int] NULL,
	[ACTIVE_POLLING_PERIOD] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[UA_VERSION] [varchar](50) NULL,
	[CREATED_DATE] [datetime] NULL,
	[UPDATED_DATE] [datetime] NULL,
	[ATM_VERSION] [varchar](50) NULL)


Insert into #TERMINAL1 
( [NAME]
           ,[IP_ADDRESS]
           ,[ENTITY_REF_ID]
           ,[MAC_ADDRESS]
           ,[WORKSTATION_NAME]
           ,[UUID]
           ,[ENTITY_PAIRED]
           ,[CUSTOMER_CODE]
           ,[TERMINAL_TYPE]
           ,[POLLING_MODE]
           ,[DEFAULT_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_PERIOD]
           ,[TENANT_ID]
           ,[UA_VERSION]
           ,[CREATED_DATE]
           ,[UPDATED_DATE]
           ,[ATM_VERSION] )
Select 

         [NAME]
           ,[IP_ADDRESS]
           ,[ENTITY_REF_ID]
           ,[MAC_ADDRESS]
           ,[WORKSTATION_NAME]
           ,[UUID]
           ,[ENTITY_PAIRED]
           ,[CUSTOMER_CODE]
           ,[TERMINAL_TYPE]
           ,[POLLING_MODE]
           ,[DEFAULT_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_PERIOD]
           ,[TENANT_ID]
           ,[UA_VERSION]
           ,[CREATED_DATE]
           ,[UPDATED_DATE]
           ,[ATM_VERSION]
from vision.TERMINAL 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.TERMINAL
(
  [NAME]
           ,[IP_ADDRESS]
           ,[ENTITY_REF_ID]
           ,[MAC_ADDRESS]
           ,[WORKSTATION_NAME]
           ,[UUID]
           ,[ENTITY_PAIRED]
           ,[CUSTOMER_CODE]
           ,[TERMINAL_TYPE]
           ,[POLLING_MODE]
           ,[DEFAULT_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_PERIOD]
           ,[TENANT_ID]
           ,[UA_VERSION]
           ,[CREATED_DATE]
           ,[UPDATED_DATE]
           ,[ATM_VERSION])
Select 
   [NAME]
           ,[IP_ADDRESS]
           ,[ENTITY_REF_ID]
           ,[MAC_ADDRESS]
           ,[WORKSTATION_NAME]
           ,[UUID]
           ,[ENTITY_PAIRED]
           ,[CUSTOMER_CODE]
           ,[TERMINAL_TYPE]
           ,[POLLING_MODE]
           ,[DEFAULT_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_INTERVAL]
           ,[ACTIVE_POLLING_PERIOD]
           ,@ID
           ,[UA_VERSION]
           ,[CREATED_DATE]
           ,[UPDATED_DATE]
           ,[ATM_VERSION]
from  #TERMINAL1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #TERMINAL1 


GO

-- Select * from [VISION].[TERMINAL]

-- DBCC CHECKIDENT('vision.TERMINAL_Test')

-- DBCC CHECKIDENT('vision.TERMINAL_Test',reseed,76)



--      Select 596 * 5540
--      FINAL Total: 3301840


--  DELETE from Vision.TERMINAL_test

--  Select count(*) from [VISION].[TERMINAL_Test]

--Select * from [VISION].[TERMINAL_Test]
--where TENANT_ID =1 