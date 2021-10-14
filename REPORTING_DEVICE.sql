


DROP Table IF Exists #SecurityT
DROP Table IF Exists #REPORTING_DEVICE1
DROP Table if exists vision.##REPORTING_DEVICE2

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

Create Table #REPORTING_DEVICE1 
(
   	[DESCRIPTION] [nvarchar](100) NULL,
	--[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	--[DELETED] [char](1) NOT NULL,
	--PREV int not null,
	[VERSION] [int] NOT NULL)


Insert into #REPORTING_DEVICE1 
Select 
[DESCRIPTION],
--PRCNT,
TENANT_ID,
-- DELETED ,
--PREV,
[VERSION] 
from vision.REPORTING_DEVICE 
where Tenant_id = 0
-- and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.REPORTING_DEVICE
print @LINK

SET @sql = '
CREATE TABLE vision.##REPORTING_DEVICE2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   	[DESCRIPTION] [nvarchar](100) NULL,
	--[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	--[DELETED] [char](1) NOT NULL,
	--PREV int not null,
	[VERSION] [int] NOT NULL)

	';

EXEC (@sql);

WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##REPORTING_DEVICE2
(
 DESCRIPTION
-- , PRCNT
 , TENANT_ID
 --, DELETED
 --,PREV
 , VERSION)
Select 
[DESCRIPTION],
--PRCNT,
@id,
--DELETED ,
--PREV,
[VERSION] 
from  #REPORTING_DEVICE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #REPORTING_DEVICE1 

GO


-- Select * from [VISION].[REPORTING_DEVICE]

-- DBCC CHECKIDENT('vision.REPORTING_DEVICE_Test')

-- DBCC CHECKIDENT('vision.REPORTING_DEVICE_Test',reseed,365)



--      Select 596 * 136
--      FINAL Total: 81056


--  DELETE from Vision.REPORTING_DEVICE_test

--  Select count(*) from [VISION].[REPORTING_DEVICE_Test]

--Select * from [VISION].[REPORTING_DEVICE_Test]
--where TENANT_ID =1 