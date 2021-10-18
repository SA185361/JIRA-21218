


DROP Table IF Exists #SecurityT
DROP Table IF Exists #COMPONENT1
DROP Table if exists vision.##COMPONENT2

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

Create Table #COMPONENT1 
(
   	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	PREV int not null,
	[VERSION] [int] NOT NULL)


Insert into #COMPONENT1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
DELETED ,
PREV,
[VERSION] 
from vision.COMPONENT 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation

DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.COMPONENT 
print @LINK

SET @sql = '
CREATE TABLE vision.##COMPONENT2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
     	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	PREV int not null,
	[VERSION] [int] NOT NULL)

	';

EXEC (@sql);



WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##COMPONENT2
( DESCRIPTION, PRCNT, TENANT_ID, DELETED,PREV, VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
DELETED ,
PREV,
[VERSION] 
from  #COMPONENT1

SET @RowCount = @RowCount + 1
END

Select * from vision.##COMPONENT2

DROP TABLE #SecurityT
Drop Table #COMPONENT1 


GO

--Select * from [VISION].[COMPONENT]
