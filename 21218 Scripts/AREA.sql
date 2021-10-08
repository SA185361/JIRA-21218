
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

Create Table #Area1 
(
   	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #Area1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
DELETED ,
[VERSION] 
from vision.area 
where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


--- Select * from #Area1

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.AREA_Test2 ( DESCRIPTION, PRCNT, TENANT_ID, DELETED, VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
DELETED ,
[VERSION] 
from  #Area1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Area1 



DBCC CHECKIDENT('vision.AREA_Test2')

DBCC CHECKIDENT('vision.AREA_Test2',reseed,3027)





