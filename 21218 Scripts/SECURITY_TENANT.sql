--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[SECURITY_TENANT]    Script Date: 8/30/2021 8:50:50 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[SECURITY_TENANT_Test](
--	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
--	[name] [nvarchar](32) NOT NULL,
--	[description] [nvarchar](100) NULL,
--	[status] [varchar](10) NOT NULL,
--	[shared] [bit] NOT NULL,
--	[create_date] [datetime] NULL,
--	[modified_date] [datetime] NULL,
-- CONSTRAINT [PK__SECURITY_TENANT] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_TENANT1

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

Create Table #SECURITY_TENANT1 
(
   	
	[name] [nvarchar](32) NOT NULL,
	[description] [nvarchar](100) NULL,
	[status] [varchar](10) NOT NULL,
	[shared] [bit] NOT NULL,
	[create_date] [datetime] NULL,
	[modified_date] [datetime] NULL)


Insert into #SECURITY_TENANT1 
(
[name]
           ,[description]
           ,[status]
           ,[shared]
           ,[create_date]
           ,[modified_date] )
Select 

         [name]
           ,[description]
           ,[status]
           ,[shared]
           ,[create_date]
           ,[modified_date]
from vision.SECURITY_TENANT 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.SECURITY_TENANT
(
 [name]
           ,[description]
           ,[status]
           ,[shared]
           ,[create_date]
           ,[modified_date])
Select 
  [name]
           ,[description]
           ,[status]
           ,[shared]
           ,[create_date]
           ,[modified_date]
from  #SECURITY_TENANT1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #SECURITY_TENANT1 


GO

-- Select * from [VISION].[SECURITY_TENANT]

-- DBCC CHECKIDENT('vision.SECURITY_TENANT_Test')

-- DBCC CHECKIDENT('vision.SECURITY_TENANT_Test',reseed,76)



--      Select 596 * 75
--      FINAL Total: 44700


--  DELETE from Vision.SECURITY_TENANT_test

--  Select count(*) from [VISION].[SECURITY_TENANT_Test]

--Select * from [VISION].[SECURITY_TENANT_Test]
--where TENANT_ID =1 