--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[SECURITY_ROLE]    Script Date: 8/30/2021 8:39:57 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[SECURITY_ROLE_Test](
--	[id] [numeric](19, 0) IDENTITY(3,1) NOT NULL,
--	[name] [nvarchar](64) NULL,
--	[description] [nvarchar](255) NULL,
--	[admin_status] [bit] NULL,
--	[home_page_id] [bigint] NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
--	[system_role] [bit] NULL,
-- CONSTRAINT [PK__SECURITY_ROLE__7DCDAAA2_test] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test] ADD  CONSTRAINT [DF_SECURITY_ROLE_Test_ADMIN_STATUS]  DEFAULT ((0)) FOR [admin_status]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test] ADD  DEFAULT ((0)) FOR [tenant_id]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test] ADD  CONSTRAINT [DF_SECURITY_ROLE_Test_SYSTEM_ROLE]  DEFAULT ((0)) FOR [system_role]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_SECURITY_ROLE_Test_Tenant_Id] FOREIGN KEY([tenant_id])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test] CHECK CONSTRAINT [FK_SECURITY_ROLE_Test_Tenant_Id]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test]  WITH NOCHECK ADD  CONSTRAINT [CHK_SECURITY_ROLE_Test_SYS_ROLE] CHECK  (([SYSTEM_ROLE]=(1) OR [SYSTEM_ROLE]=(0)))
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_Test] CHECK CONSTRAINT [CHK_SECURITY_ROLE_Test_SYS_ROLE]
--GO






------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_ROLE1

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

Create Table #SECURITY_ROLE1 
(
   	
	[name] [nvarchar](64) NULL,
	[description] [nvarchar](255) NULL,
	[admin_status] [bit] NULL,
	[home_page_id] [bigint] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
	[system_role] [bit] NULL,)


Insert into #SECURITY_ROLE1 
(           [name]
           ,[description]
           ,[admin_status]
           ,[home_page_id]
           ,[tenant_id]
           ,[system_role] )
Select 

           [name]
           ,[description]
           ,[admin_status]
           ,[home_page_id]
           ,[tenant_id]
           ,[system_role]
from vision.SECURITY_ROLE 
Where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.SECURITY_ROLE
(
            [name]
           ,[description]
           ,[admin_status]
           ,[home_page_id]
           ,[tenant_id]
           ,[system_role])
Select 
  [name]
           ,[description]
           ,[admin_status]
           ,[home_page_id]
           ,@ID
           ,[system_role]
from  #SECURITY_ROLE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #SECURITY_ROLE1 


GO

-- Select * from [VISION].[SECURITY_ROLE]

-- DBCC CHECKIDENT('vision.SECURITY_ROLE_Test')

-- DBCC CHECKIDENT('vision.SECURITY_ROLE_Test',reseed,76)



--      Select 596 * 3
--      FINAL Total: 1788


--  DELETE from Vision.SECURITY_ROLE_test

--  Select count(*) from [VISION].[SECURITY_ROLE_Test]

--Select * from [VISION].[SECURITY_ROLE_Test]
--where TENANT_ID =1 