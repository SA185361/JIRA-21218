


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_ROLE_TENANT1
DROP Table if exists vision.##SECURITY_ROLE_TENANT2


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
--and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
--Declare @LINK int;
--Select @LINK = max(link) + 1 from  vision.SECURITY_ROLE_TENANT 
--print @LINK

SET @sql = '
CREATE TABLE vision.##SECURITY_ROLE_TENANT2(
	
   [role_id] [numeric](19, 0) NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)

	';

EXEC (@sql);

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##SECURITY_ROLE_TENANT2
(
[role_id]
 ,[tenant_id])
Select 
 [role_id]
,@ID
from  #SECURITY_ROLE_TENANT1

SET @RowCount = @RowCount + 1
END


Select * from vision.##SECURITY_ROLE_TENANT2

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