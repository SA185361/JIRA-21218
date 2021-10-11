




DROP Table IF Exists #SecurityT
DROP Table IF Exists #Branch1

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

Create Table #Branch1 
(
   	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #Branch1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
DELETED ,
[VERSION] 
from vision.Branch 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.Branch( DESCRIPTION, PRCNT, TENANT_ID, DELETED, VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
DELETED ,
[VERSION] 
from  #Branch1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Branch1 


GO


--DBCC CHECKIDENT('vision.Branch_Test')

--DBCC CHECKIDENT('vision.Branch_Test',reseed,1285)




---- FINAL Total: 332568


--DELETE from Vision.Branch_test

--Select count(*) from [VISION].[BRANCH_Test]