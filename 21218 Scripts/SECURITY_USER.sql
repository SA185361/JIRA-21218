--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[SECURITY_USER]    Script Date: 8/30/2021 11:12:03 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[SECURITY_USER_Test](
--	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
--	[uuid] [char](36) NULL,
--	[username] [nvarchar](50) NOT NULL,
--	[email] [nvarchar](255) NULL,
--	[password_hint] [nvarchar](255) NULL,
--	[first_name] [nvarchar](50) NOT NULL,
--	[last_name] [nvarchar](50) NOT NULL,
--	[phone_number] [nvarchar](255) NULL,
--	[account_expired] [tinyint] NOT NULL,
--	[account_locked] [tinyint] NOT NULL,
--	[credentials_expired] [tinyint] NOT NULL,
--	[city] [nvarchar](50) NULL,
--	[province] [nvarchar](100) NULL,
--	[postal_code] [nvarchar](15) NULL,
--	[address] [nvarchar](150) NULL,
--	[country] [nvarchar](100) NULL,
--	[account_enabled] [tinyint] NULL,
--	[version] [int] NULL,
--	[password] [nvarchar](255) NOT NULL,
--	[password_change_date] [datetime] NULL,
--	[bad_login_counter] [int] NULL,
--	[home_page_id] [bigint] NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
--	[default_tenant_id] [numeric](19, 0) NULL,
--	[row_ver] [timestamp] NOT NULL,
--	[sync_ver] [bigint] NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
--UNIQUE NONCLUSTERED 
--(
--	[username] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_USER1

CREATE TABLE #SecurityT (
 RowID int IDENTITY(1502, 1),
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

Create Table #SECURITY_USER1 
(
   	
		[uuid] [char](36) NULL,
	[username] [nvarchar](50) NOT NULL,
	[email] [nvarchar](255) NULL,
	[password_hint] [nvarchar](255) NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[phone_number] [nvarchar](255) NULL,
	[account_expired] [tinyint] NOT NULL,
	[account_locked] [tinyint] NOT NULL,
	[credentials_expired] [tinyint] NOT NULL,
	[city] [nvarchar](50) NULL,
	[province] [nvarchar](100) NULL,
	[postal_code] [nvarchar](15) NULL,
	[address] [nvarchar](150) NULL,
	[country] [nvarchar](100) NULL,
	[account_enabled] [tinyint] NULL,
	[version] [int] NULL,
	[password] [nvarchar](255) NOT NULL,
	[password_change_date] [datetime] NULL,
	[bad_login_counter] [int] NULL,
	[home_page_id] [bigint] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
	[default_tenant_id] [numeric](19, 0) NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver] [bigint] NULL)


Insert into #SECURITY_USER1 
(  [uuid]
           ,[username]
           ,[email]
           ,[password_hint]
           ,[first_name]
           ,[last_name]
           ,[phone_number]
           ,[account_expired]
           ,[account_locked]
           ,[credentials_expired]
           ,[city]
           ,[province]
           ,[postal_code]
           ,[address]
           ,[country]
           ,[account_enabled]
           ,[version]
           ,[password]
           ,[password_change_date]
           ,[bad_login_counter]
           ,[home_page_id]
           ,[tenant_id]
           ,[default_tenant_id]
           ,[sync_ver] )
Select 

           [uuid]
           ,[username]
           ,[email]
           ,[password_hint]
           ,[first_name]
           ,[last_name]
           ,[phone_number]
           ,[account_expired]
           ,[account_locked]
           ,[credentials_expired]
           ,[city]
           ,[province]
           ,[postal_code]
           ,[address]
           ,[country]
           ,[account_enabled]
           ,[version]
           ,[password]
           ,[password_change_date]
           ,[bad_login_counter]
           ,[home_page_id]
           ,[tenant_id]
           ,[default_tenant_id]
           ,[sync_ver]
from vision.SECURITY_USER 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.SECURITY_USER
(
            [uuid]
           ,[username]
           ,[email]
           ,[password_hint]
           ,[first_name]
           ,[last_name]
           ,[phone_number]
           ,[account_expired]
           ,[account_locked]
           ,[credentials_expired]
           ,[city]
           ,[province]
           ,[postal_code]
           ,[address]
           ,[country]
           ,[account_enabled]
           ,[version]
           ,[password]
           ,[password_change_date]
           ,[bad_login_counter]
           ,[home_page_id]
           ,[tenant_id]
           ,[default_tenant_id]
           ,[sync_ver])
Select 
   [uuid]
           ,[username]
           ,[email]
           ,[password_hint]
           ,[first_name]
           ,[last_name]
           ,[phone_number]
           ,[account_expired]
           ,[account_locked]
           ,[credentials_expired]
           ,[city]
           ,[province]
           ,[postal_code]
           ,[address]
           ,[country]
           ,[account_enabled]
           ,[version]
           ,[password]
           ,[password_change_date]
           ,[bad_login_counter]
           ,[home_page_id]
           ,@ID
           ,[default_tenant_id]
           ,[sync_ver]
from  #SECURITY_USER1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #SECURITY_USER1 


GO

-- 
Select * from [VISION].[SECURITY_USER]
where tenant_id is null

-- DBCC CHECKIDENT('vision.SECURITY_USER_Test')

-- DBCC CHECKIDENT('vision.SECURITY_USER_Test',reseed,76)



--      Select 596 * 1422
--      FINAL Total: 847512


--  DELETE from Vision.SECURITY_USER_test

--  Select count(*) from [VISION].[SECURITY_USER_Test]

--Select * from [VISION].[SECURITY_USER_Test]
--where TENANT_ID =1 