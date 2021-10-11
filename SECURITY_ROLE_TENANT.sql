--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[SECURITY_ROLE_TENANT]    Script Date: 8/30/2021 8:45:59 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[SECURITY_ROLE_TENANT_Test](
--	[role_id] [numeric](19, 0) NOT NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
-- CONSTRAINT [PK_SECURITY_ROLE_TENANT_Test] PRIMARY KEY CLUSTERED 
--(
--	[role_id] ASC,
--	[tenant_id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_TENANT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_SEC_ROLE_TENANT_SEC_ROLE] FOREIGN KEY([role_id])
--REFERENCES [VISION].[SECURITY_ROLE] ([id])
--ON DELETE CASCADE
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_TENANT_Test] CHECK CONSTRAINT [FK_SEC_ROLE_TENANT_SEC_ROLE]
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_TENANT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_SECURITY_ROLE_TENANT_Test_T_Id] FOREIGN KEY([tenant_id])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[SECURITY_ROLE_TENANT_Test] CHECK CONSTRAINT [FK_SECURITY_ROLE_TENANT_Test_T_Id]
--GO




------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_ROLE_TENANT1

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

Create Table #SECURITY_ROLE_TENANT1 
(
   	
	[role_id] [numeric](19, 0) NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #SECURITY_ROLE_TENANT1 
([role_id]
           ,[tenant_id] )
Select 

        [role_id]
           ,[tenant_id]
from vision.SECURITY_ROLE_TENANT 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.SECURITY_ROLE_TENANT
(
[role_id]
 ,[tenant_id])
Select 
 [role_id]
,@ID
from  #SECURITY_ROLE_TENANT1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #SECURITY_ROLE_TENANT1 


GO

-- Select * from [VISION].[SECURITY_ROLE_TENANT]

-- DBCC CHECKIDENT('vision.SECURITY_ROLE_TENANT_Test')

-- DBCC CHECKIDENT('vision.SECURITY_ROLE_TENANT_Test',reseed,76)



--      Select 596 * 3
--      FINAL Total: 1788


--  DELETE from Vision.SECURITY_ROLE_TENANT_test

--  Select count(*) from [VISION].[SECURITY_ROLE_TENANT_Test]

Select * from [VISION].[SECURITY_ROLE_TENANT_Test]
where TENANT_ID =1 