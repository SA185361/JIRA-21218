

DROP Table IF Exists #SecurityT
DROP Table IF Exists #Entity_Type_Test1
DROP Table if exists vision.##Entity_Type2



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

Create Table #Entity_Type_Test1
(
   	[entity_type_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[icon_class] [varchar](25) NULL,
	[MONITOR_LOGIC] [nvarchar](50) NULL,
	[MONITOR_INTERVAL_MS] [int] NULL,
	[MONITORING] [int] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Entity_Type_Test1 
(          [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,[tenant_id] )
Select 

            [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,[tenant_id]
from vision.Entity_Type 
where Tenant_id = 0
--and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.Entity_Type  
print @LINK

SET @sql = '
CREATE TABLE vision.##Entity_Type2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   	[entity_type_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[icon_class] [varchar](25) NULL,
	[MONITOR_LOGIC] [nvarchar](50) NULL,
	[MONITOR_INTERVAL_MS] [int] NULL,
	[MONITORING] [int] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##Entity_Type2
(
 		    [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,[tenant_id] )
          
          
Select 
  
            [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,@ID
from  #Entity_Type_Test1 

SET @RowCount = @RowCount + 1
END

Select * from vision.##Entity_Type2

DROP TABLE #SecurityT
Drop Table #Entity_Type_Test1 


GO

-- Select * from [VISION].[Entity_TYPE]

-- DBCC CHECKIDENT('vision.Entity_TYPE_Test')

-- DBCC CHECKIDENT('vision.Entity_TYPE_Test',reseed,365)



--      Select 596 * 5419
--      FINAL Total: 3229724


--  DELETE from Vision.Entity_test

----  Select count(*) from [VISION].[Entity_TYPE_Test]

--Select * from [VISION].[Entity_TYPE_Test]
--where TENANT_ID =1 