




DROP Table IF Exists #SecurityT
DROP Table IF Exists #Branch1
DROP Table if exists vision.##Branch2




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
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from vision.Branch 
print @LINK

SET @sql = '
CREATE TABLE vision.##Branch2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##Branch2( DESCRIPTION, PRCNT, TENANT_ID, DELETED, VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
DELETED ,
[VERSION] 
from  #Branch1

SET @RowCount = @RowCount + 1
END

Select * from vision.##Branch2

DROP TABLE #SecurityT
Drop Table #Branch1 


GO


-- Select * from [VISION].[BRANCH]