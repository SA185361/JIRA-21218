USE [GLOBAL]
GO

/****** Object:  Table [CXP].[CXP_USER]    Script Date: 8/30/2021 12:10:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CXP].[CXP_USER_TEST](
	[ID] [bigint] IDENTITY(1512,1) NOT FOR REPLICATION NOT NULL,
	[ORGANIZATION_NAME] [varchar](512) NOT NULL,
	[USERNAME] [nvarchar](512) NULL,
	[PASSWORD] [nvarchar](512) NULL,
	[FAMILY_NAME] [nvarchar](512) NULL,
	[GIVEN_NAME] [nvarchar](512) NULL,
	[FULL_NAME] [nvarchar](2048) NULL,
	[STATUS] [nvarchar](16) NOT NULL,
	[EMAIL_ADDRESS] [nvarchar](254) NULL,
	[TELEPHONE_NUMBER] [nvarchar](32) NULL,
	[CITY] [nvarchar](128) NULL,
	[COUNTRY] [nvarchar](128) NULL,
	[POSTAL_CODE] [nvarchar](64) NULL,
	[STATE] [nvarchar](128) NULL,
	[STREET] [nvarchar](128) NULL,
	[PASSWORD_LAST_SET] [datetime2](7) NOT NULL,
	[ACCOUNT_LAST_ENABLED] [datetime2](7) NOT NULL,
	[INVALID_LOGIN_ATTEMPTS] [int] NULL,
	[TECHNICAL] [char](1) NOT NULL,
	[LAST_LOGIN_SUCCESSFUL] [datetime2](7) NOT NULL,
	[ACCOUNT_EXPIRY_DATE] [datetime2](7) NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver] [bigint] NULL,
	[TENANT_ID] [numeric](19, 0) NULL,
 CONSTRAINT [PK_CXP_USER_TEST] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CXP].[CXP_USER_TEST] ADD  DEFAULT ((0)) FOR [INVALID_LOGIN_ATTEMPTS]
GO

ALTER TABLE [CXP].[CXP_USER_TEST] ADD  DEFAULT ('F') FOR [TECHNICAL]
GO






----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CXP_USER1

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

Create Table #CXP_USER1 
(
   	
	[ORGANIZATION_NAME] [varchar](512) NOT NULL,
	[USERNAME] [nvarchar](512) NULL,
	[PASSWORD] [nvarchar](512) NULL,
	[FAMILY_NAME] [nvarchar](512) NULL,
	[GIVEN_NAME] [nvarchar](512) NULL,
	[FULL_NAME] [nvarchar](2048) NULL,
	[STATUS] [nvarchar](16) NOT NULL,
	[EMAIL_ADDRESS] [nvarchar](254) NULL,
	[TELEPHONE_NUMBER] [nvarchar](32) NULL,
	[CITY] [nvarchar](128) NULL,
	[COUNTRY] [nvarchar](128) NULL,
	[POSTAL_CODE] [nvarchar](64) NULL,
	[STATE] [nvarchar](128) NULL,
	[STREET] [nvarchar](128) NULL,
	[PASSWORD_LAST_SET] [datetime2](7) NOT NULL,
	[ACCOUNT_LAST_ENABLED] [datetime2](7) NOT NULL,
	[INVALID_LOGIN_ATTEMPTS] [int] NULL,
	[TECHNICAL] [char](1) NOT NULL,
	[LAST_LOGIN_SUCCESSFUL] [datetime2](7) NOT NULL,
	[ACCOUNT_EXPIRY_DATE] [datetime2](7) NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver] [bigint] NULL,
	[TENANT_ID] [numeric](19, 0) NULL)


Insert into #CXP_USER1 
([ORGANIZATION_NAME]
           ,[USERNAME]
           ,[PASSWORD]
           ,[FAMILY_NAME]
           ,[GIVEN_NAME]
           ,[FULL_NAME]
           ,[STATUS]
           ,[EMAIL_ADDRESS]
           ,[TELEPHONE_NUMBER]
           ,[CITY]
           ,[COUNTRY]
           ,[POSTAL_CODE]
           ,[STATE]
           ,[STREET]
           ,[PASSWORD_LAST_SET]
           ,[ACCOUNT_LAST_ENABLED]
           ,[INVALID_LOGIN_ATTEMPTS]
           ,[TECHNICAL]
           ,[LAST_LOGIN_SUCCESSFUL]
           ,[ACCOUNT_EXPIRY_DATE]
           ,[sync_ver]
           ,[TENANT_ID])
Select 

         [ORGANIZATION_NAME]
           ,[USERNAME]
           ,[PASSWORD]
           ,[FAMILY_NAME]
           ,[GIVEN_NAME]
           ,[FULL_NAME]
           ,[STATUS]
           ,[EMAIL_ADDRESS]
           ,[TELEPHONE_NUMBER]
           ,[CITY]
           ,[COUNTRY]
           ,[POSTAL_CODE]
           ,[STATE]
           ,[STREET]
           ,[PASSWORD_LAST_SET]
           ,[ACCOUNT_LAST_ENABLED]
           ,[INVALID_LOGIN_ATTEMPTS]
           ,[TECHNICAL]
           ,[LAST_LOGIN_SUCCESSFUL]
           ,[ACCOUNT_EXPIRY_DATE]
           ,[sync_ver]
           ,[TENANT_ID]
from CXP.CXP_USER 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into CXP.CXP_USER_test
(
 [ORGANIZATION_NAME]
           ,[USERNAME]
           ,[PASSWORD]
           ,[FAMILY_NAME]
           ,[GIVEN_NAME]
           ,[FULL_NAME]
           ,[STATUS]
           ,[EMAIL_ADDRESS]
           ,[TELEPHONE_NUMBER]
           ,[CITY]
           ,[COUNTRY]
           ,[POSTAL_CODE]
           ,[STATE]
           ,[STREET]
           ,[PASSWORD_LAST_SET]
           ,[ACCOUNT_LAST_ENABLED]
           ,[INVALID_LOGIN_ATTEMPTS]
           ,[TECHNICAL]
           ,[LAST_LOGIN_SUCCESSFUL]
           ,[ACCOUNT_EXPIRY_DATE]
           ,[sync_ver]
           ,[TENANT_ID])
Select 
 [ORGANIZATION_NAME]
           ,[USERNAME]
           ,[PASSWORD]
           ,[FAMILY_NAME]
           ,[GIVEN_NAME]
           ,[FULL_NAME]
           ,[STATUS]
           ,[EMAIL_ADDRESS]
           ,[TELEPHONE_NUMBER]
           ,[CITY]
           ,[COUNTRY]
           ,[POSTAL_CODE]
           ,[STATE]
           ,[STREET]
           ,[PASSWORD_LAST_SET]
           ,[ACCOUNT_LAST_ENABLED]
           ,[INVALID_LOGIN_ATTEMPTS]
           ,[TECHNICAL]
           ,[LAST_LOGIN_SUCCESSFUL]
           ,[ACCOUNT_EXPIRY_DATE]
           ,[sync_ver]
           ,@ID
from  #CXP_USER1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #CXP_USER1 


GO

-- Select * from [CXP].[CXP_USER]

-- DBCC CHECKIDENT('CXP.CXP_USER_Test')

-- DBCC CHECKIDENT('CXP.CXP_USER_Test',reseed,76)



--      Select 596 * 1422
--      FINAL Total: 847512


--  DELETE from CXP.CXP_USER_test

--  Select count(*) from [CXP].[CXP_USER_Test]

Select * from [CXP].[CXP_USER_Test]
where TENANT_ID =1 