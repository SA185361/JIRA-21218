


DROP Table IF Exists #SecurityT
DROP Table IF Exists #REGION1
DROP Table if exists vision.##Region2

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

Create Table #REGION1 
(
   	
	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #REGION1 
([DESCRIPTION]
           ,[PRCNT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION] )
Select 

           [DESCRIPTION]
           ,[PRCNT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
from vision.REGION 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.REGION 
print @LINK

SET @sql = '
CREATE TABLE vision.##REGION2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [smallint] NULL,
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


Insert into vision.##REGION2
(
 
           [DESCRIPTION]
           ,[PRCNT]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION])
Select 
  
           [DESCRIPTION]
           ,[PRCNT]
           ,@ID
           ,[DELETED]
           ,[VERSION]
from  #REGION1

SET @RowCount = @RowCount + 1
END


Select * from vision.##REGION2

DROP TABLE #SecurityT
Drop Table #REGION1 


GO

-- Select * from [VISION].[REGION]

-- DBCC CHECKIDENT('vision.REGION_Test')

-- DBCC CHECKIDENT('vision.REGION_Test',reseed,365)



--      Select 596 * 136
--      FINAL Total: 81056


--  DELETE from Vision.REGION_test

--  Select count(*) from [VISION].[REGION_Test]

--Select * from [VISION].[REGION_Test]
--where TENANT_ID =1 

use [PUT_UR_DB_NAME_HERE]

DECLARE @REPLICATION_SQL_SERVER_DATABASE_NAME VARCHAR(1000)
DECLARE @REPLICATION_SQL_SERVER_SCHEMA_NAME VARCHAR(500)
DECLARE @REPLICATION_SQL_SERVER_TABLE_NAME VARCHAR(500)

SET @REPLICATION_SQL_SERVER_DATABASE_NAME = 'PUT_UR_DB_NAME_HERE' --<$(varCOMMONDB)> -- USE SQL SERVER DATABSE NAME HERE
SET @REPLICATION_SQL_SERVER_SCHEMA_NAME = 'Vision' -- USE SQL SERVER DB SCHEMA NAME HERE
SET @REPLICATION_SQL_SERVER_TABLE_NAME = 'PUT_UR_FINAL_SOURCE_TABLE_NAME_HERE'


/* **************************************************************************************** */
/* ******************* SCRIPT RUN FOR TABLE REGION ********************* */
/* **************************************************************************************** */

BEGIN TRY
	BEGIN TRANSACTION INSERT_REGION
	ALTER TABLE VISION.REGION NOCHECK CONSTRAINT ALL /* DISABLE ALL TABLE CONSTRAINTS */
	BEGIN /* INSERTING RECORD */
		DECLARE @SQL_INSERT_REGION VARCHAR(MAX)
		SET @SQL_INSERT_REGION = '
		BEGIN
		DECLARE
			@LINK int ,
			@DESCRIPTION varchar(30) ,
			@PRCNT smallint ,
			@TENANT_ID INT,
			@DELETED char(1) ,
			@VERSION int

			DECLARE insert_cursor CURSOR FOR
			SELECT LINK,DESCRIPTION,PRCNT,TENANT_ID,DELETED,VERSION
			FROM '+ @REPLICATION_SQL_SERVER_DATABASE_NAME + '.' + @REPLICATION_SQL_SERVER_SCHEMA_NAME + '.' + @REPLICATION_SQL_SERVER_TABLE_NAME + '
			OPEN insert_cursor
			FETCH NEXT FROM insert_cursor into @LINK,@DESCRIPTION,@PRCNT,@TENANT_ID,@DELETED,@VERSION

			WHILE @@FETCH_STATUS=0
			BEGIN
					BEGIN
						INSERT INTO '+ @REPLICATION_SQL_SERVER_DATABASE_NAME + '.' + @REPLICATION_SQL_SERVER_SCHEMA_NAME + '.REGION ( LINK ,DESCRIPTION,PRCNT,TENANT_ID,DELETED,VERSION )
						SELECT @LINK ,@DESCRIPTION,@PRCNT,@TENANT_ID,@DELETED,@VERSION
					END
				FETCH NEXT FROM insert_cursor into @LINK,@DESCRIPTION,@PRCNT,@TENANT_ID,@DELETED,@VERSION
			END
			CLOSE insert_cursoR
			Deallocate insert_cursor
		END'
EXEC (@SQL_INSERT_REGION)
--select @SQL_INSERT_REGION

ALTER TABLE VISION.REGION CHECK CONSTRAINT ALL /* Enable all table constraints */
END

COMMIT TRANSACTION INSERT_REGION
SELECT 'TRANSACTION HAS BEEN RUN SUCCESSFULLY FOR INSERT_REGION' AS TRANSACTION_STATUS
END TRY
BEGIN CATCH
-- Transaction uncommittable
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION INSERT_REGION
SELECT 'TRANSACTION HAS BEEN FAIL FOR INSERT_REGION' AS TRANSACTION_STATUS , ERROR_MESSAGE() 'ERROR_MESSAGE'
END CATCH






