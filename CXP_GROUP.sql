--USE [GLOBAL]
--GO

--/****** Object:  Table [CXP].[CXP_GROUP]    Script Date: 8/30/2021 12:00:23 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [CXP].[CXP_GROUP_TEST](
--	[ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
--	[NAME] [nvarchar](100) NOT NULL,
--	[DESCRIPTION] [nvarchar](512) NULL,
--	[ORGANIZATION_NAME] [varchar](512) NOT NULL,
-- CONSTRAINT [PK_CXP_GROUP_test] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
-- CONSTRAINT [UNQ_CXP_LDAP_NAME_ORG_TEST] UNIQUE NONCLUSTERED 
--(
--	[NAME] ASC,
--	[ORGANIZATION_NAME] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO






------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CXP_GROUP1

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

Create Table #CXP_GROUP1 
(
   	
	[NAME] [nvarchar](100) NOT NULL,
	[DESCRIPTION] [nvarchar](512) NULL,
	[ORGANIZATION_NAME] [varchar](512) NOT NULL)


Insert into #CXP_GROUP1 
([NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME] )
Select 

         [NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME]
from CXP.CXP_GROUP 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into CXP.CXP_GROUP
(
 [NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME])
Select 
  [NAME]
           ,[DESCRIPTION]
           ,[ORGANIZATION_NAME]
from  #CXP_GROUP1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #CXP_GROUP1 


GO

-- Select * from [CXP].[CXP_GROUP]

-- DBCC CHECKIDENT('CXP.CXP_GROUP_Test')

-- DBCC CHECKIDENT('CXP.CXP_GROUP_Test',reseed,76)



--      Select 596 * 4
--      FINAL Total: 2384


--  DELETE from CXP.CXP_GROUP_test

--  Select count(*) from [CXP].[CXP_GROUP_Test]

--Select * from [CXP].[CXP_GROUP_Test]
--where TENANT_ID =1 