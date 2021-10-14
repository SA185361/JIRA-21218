


DROP Table IF Exists #SecurityT
DROP Table IF Exists #SECURITY_TENANT1
DROP Table if exists vision.##SECURITY_TENANT2


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
--where Tenant_id = 0
--and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(id) + 1 from  vision.SECURITY_TENANT 
print @LINK

SET @sql = '
CREATE TABLE vision.##SECURITY_TENANT2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [name] [nvarchar](32) NOT NULL,
	[description] [nvarchar](100) NULL,
	[status] [varchar](10) NOT NULL,
	[shared] [bit] NOT NULL,
	[create_date] [datetime] NULL,
	[modified_date] [datetime] NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##SECURITY_TENANT2
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


Select * from vision.##SECURITY_TENANT2
order by id asc

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