


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CASSETTE1
DROP Table if exists  vision.##CASSETTE2


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

Create Table #CASSETTE1 
(
   	
	[DESCRIPTION] [varchar](255) NULL,
	[VERSION] [int] NOT NULL,
	[TENANT_ID] [int] NOT NULL,
	[CASSETTE_TYPE] [varchar](15) NOT NULL,)


Insert into #CASSETTE1 
([DESCRIPTION]
           ,[VERSION]
           ,[TENANT_ID]
           ,[CASSETTE_TYPE])
Select 

           [DESCRIPTION]
           ,[VERSION]
           ,[TENANT_ID]
           ,[CASSETTE_TYPE]
from vision.CASSETTE 
where Tenant_id = 0
-- where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.CASSETTE
print @LINK

SET @sql = '
CREATE TABLE vision.##CASSETTE2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [DESCRIPTION] [varchar](255) NULL,
	[VERSION] [int] NOT NULL,
	[TENANT_ID] [int] NOT NULL,
	[CASSETTE_TYPE] [varchar](15) NOT NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##CASSETTE2
(
 
          [DESCRIPTION]
           ,[VERSION]
           ,[TENANT_ID]
           ,[CASSETTE_TYPE])
Select 
  
           [DESCRIPTION]
           ,[VERSION]
           ,@ID
           ,[CASSETTE_TYPE]
from  #CASSETTE1

SET @RowCount = @RowCount + 1
END

Select * from vision.##CASSETTE2

DROP TABLE #SecurityT
Drop Table #CASSETTE1 


GO

-- Select * from [VISION].[CASSETTE]

