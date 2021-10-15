

DROP Table IF Exists #SecurityT
DROP Table IF Exists #Entity_Type_Attribute_Test1
DROP Table if exists vision.##Entity_Type_Attribute2



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

Create Table #Entity_Type_Attribute_Test1
(
   	[entity_type_id] [int] NOT NULL,
	[attribute_id] [int] NOT NULL,
	[string_default_value] [nvarchar](256) NULL,
	[integer_default_value] [int] NULL,
	[date_default_value] [datetime] NULL,
	[binary_default_value] [varbinary](max) NULL,
	[boolean_default_value] [bit] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Entity_Type_Attribute_Test1 
(           [entity_type_id]
           ,[attribute_id]
           ,[string_default_value]
           ,[integer_default_value]
           ,[date_default_value]
           ,[binary_default_value]
           ,[boolean_default_value]
           ,[tenant_id] )
Select 

           [entity_type_id]
           ,[attribute_id]
           ,[string_default_value]
           ,[integer_default_value]
           ,[date_default_value]
           ,[binary_default_value]
           ,[boolean_default_value]
           ,[tenant_id]
from vision.Entity_Type_Attribute 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.Entity_Type_Attribute  
print @LINK

SET @sql = '
CREATE TABLE vision.##Entity_Type_Attribute2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [entity_type_id] [int] NOT NULL,
	[attribute_id] [int] NOT NULL,
	[string_default_value] [nvarchar](256) NULL,
	[integer_default_value] [int] NULL,
	[date_default_value] [datetime] NULL,
	[binary_default_value] [varbinary](max) NULL,
	[boolean_default_value] [bit] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##Entity_Type_Attribute2
(
 		    [entity_type_id]
           ,[attribute_id]
           ,[string_default_value]
           ,[integer_default_value]
           ,[date_default_value]
           ,[binary_default_value]
           ,[boolean_default_value]
           ,[tenant_id] )
          
          
Select 
  
           [entity_type_id]
           ,[attribute_id]
           ,[string_default_value]
           ,[integer_default_value]
           ,[date_default_value]
           ,[binary_default_value]
           ,[boolean_default_value]
           ,@ID
from  #Entity_Type_Attribute_Test1 

SET @RowCount = @RowCount + 1
END


Select * from vision.##Entity_Type_Attribute2

DROP TABLE #SecurityT
Drop Table #Entity_Type_Attribute_Test1 


GO

-- Select * from [VISION].[Entity_Type_Attribute]

-- DBCC CHECKIDENT('vision.Entity_Type_Attribute')

-- DBCC CHECKIDENT('vision.Entity_Type_Attribute',reseed,365)



--      Select 596 * 41
--      FINAL Total: 24436


--  DELETE from Vision.Entity_test

--  Select count(*) from [VISION].[Entity_Type_Attribute_Test]

--Select * from [VISION].[Entity_Type_Attribute_Test]
--where tenant_id = 204