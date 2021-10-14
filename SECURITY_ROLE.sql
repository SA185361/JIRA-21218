


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_ROLE1
DROP Table if exists vision.##SECURITY_ROLE2


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
	[system_role] [bit] NULL)


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
-- and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.SECURITY_ROLE 
print @LINK

SET @sql = '
CREATE TABLE vision.##SECURITY_ROLE2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [name] [nvarchar](64) NULL,
	[description] [nvarchar](255) NULL,
	[admin_status] [bit] NULL,
	[home_page_id] [bigint] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
	[system_role] [bit] NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##SECURITY_ROLE2
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

Select * from vision.##SECURITY_ROLE2
-- Select * from [VISION].[SECURITY_ROLE]

-- DBCC CHECKIDENT('vision.SECURITY_ROLE_Test')

-- DBCC CHECKIDENT('vision.SECURITY_ROLE_Test',reseed,76)



--      Select 596 * 3
--      FINAL Total: 1788


--  DELETE from Vision.SECURITY_ROLE_test

--  Select count(*) from [VISION].[SECURITY_ROLE_Test]

--Select * from [VISION].[SECURITY_ROLE_Test]
--where TENANT_ID =1 