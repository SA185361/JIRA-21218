


DROP Table IF Exists #SecurityT
DROP Table IF Exists #EMAIL_TEMPLATE1
DROP Table if exists vision.##EMAIL_TEMPLATE2

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

Create Table #EMAIL_TEMPLATE1 
(
   	
	[DESCRIPTION] [varchar](50) NULL,
	[SUBJECT] [varchar](250) NOT NULL,
	[TEMPLATE] [varbinary](max) NOT NULL,
	[CREATED_DATE] [datetime] NULL,
	[CREATED_BY] [varchar](50) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[MODIFIED_BY] [varchar](50) NULL,
	[TENANT_ID] [numeric](19, 0) NULL,
	[VERSION] [int] NOT NULL)


Insert into #EMAIL_TEMPLATE1 
([DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[TENANT_ID]
           ,[VERSION] )
Select 

         [DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[TENANT_ID]
           ,[VERSION]
from vision.EMAIL_TEMPLATE 
where Tenant_id = 0
-- and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(TEMPLATE_ID) + 1 from  vision.EMAIL_TEMPLATE 
print @LINK

SET @sql = '
CREATE TABLE vision.##EMAIL_TEMPLATE2(
	[TEMPLATE_ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [DESCRIPTION] [varchar](50) NULL,
	[SUBJECT] [varchar](250) NOT NULL,
	[TEMPLATE] [varbinary](max) NOT NULL,
	[CREATED_DATE] [datetime] NULL,
	[CREATED_BY] [varchar](50) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[MODIFIED_BY] [varchar](50) NULL,
	[TENANT_ID] [numeric](19, 0) NULL,
	[VERSION] [int] NOT NULL,)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##EMAIL_TEMPLATE2
(
 
         [DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[TENANT_ID]
           ,[VERSION])
Select 
  
          [DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,@ID
           ,[VERSION]
from  #EMAIL_TEMPLATE1

SET @RowCount = @RowCount + 1
END


Select * from vision.##EMAIL_TEMPLATE2

DROP TABLE #SecurityT
Drop Table #EMAIL_TEMPLATE1 


GO

-- Select * from [VISION].[EMAIL_TEMPLATE]

