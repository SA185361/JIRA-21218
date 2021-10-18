

DROP Table IF Exists #SecurityT
DROP Table IF Exists #CONTACT_TYPE1
DROP Table if exists vision.##CONTACT_TYPE2



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

Create Table #CONTACT_TYPE1 
(
   	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	--[DELETED] [char](1) NOT NULL,
--	PREV int not null,
	[VERSION] [int] NOT NULL)


Insert into #CONTACT_TYPE1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
--DELETED ,
--PREV,
[VERSION] 
from vision.CONTACT_TYPE 
where Tenant_id = 0
-- deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation




DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from vision.CONTACT_TYPE
print @LINK

SET @sql = '
CREATE TABLE vision.##CONTACT_TYPE2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	--[DELETED] [char](1) NOT NULL,
--	PREV int not null,
	[VERSION] [int] NOT NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##CONTACT_TYPE2
( DESCRIPTION, PRCNT, TENANT_ID
--, DELETED
-- ,PREV
, VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
--DELETED ,
--PREV,
[VERSION] 
from  #CONTACT_TYPE1

SET @RowCount = @RowCount + 1
END

Select * from vision.##CONTACT_TYPE2

DROP TABLE #SecurityT
Drop Table #CONTACT_TYPE1 


GO

--  Select * from [VISION].[CONTACT_TYPE]

