

DROP Table IF Exists #SecurityT
DROP Table IF Exists #ZONE1
DROP Table if exists vision.##ZONE2


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

Create Table #ZONE1 
(
   	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #ZONE1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
DELETED ,
[VERSION] 
from vision.ZONE 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.ZONE
print @LINK

SET @sql = '
CREATE TABLE vision.##ZONE2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    	[DESCRIPTION] [nvarchar](100) NULL,
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


Insert into vision.##ZONE2
(
   DESCRIPTION
 , PRCNT
 , TENANT_ID
 , DELETED
 , VERSION 
 )
Select 
[DESCRIPTION],
PRCNT,
@id,
DELETED ,
[VERSION] 
from  #ZONE1

SET @RowCount = @RowCount + 1
END


Select * from vision.##ZONE2

DROP TABLE #SecurityT
Drop Table #ZONE1 
DROP Table if exists vision.##ZONE2


GO

-- Select * from [VISION].[ZONE]

-- DBCC CHECKIDENT('vision.ZONE_Test')

-- DBCC CHECKIDENT('vision.ZONE_Test',reseed,365)


--      Select 596 * 16
--      FINAL Total: 9536


--  DELETE from Vision.ZONE_test

--  Select count(*) from [VISION].[ZONE_Test]

--Select * from [VISION].[ZONE_Test]
--where TENANT_ID =1 

use [PUT_UR_DB_NAME_HERE]

DECLARE @REPLICATION_SQL_SERVER_DATABASE_NAME VARCHAR(1000)
DECLARE @REPLICATION_SQL_SERVER_SCHEMA_NAME VARCHAR(500)
DECLARE @REPLICATION_SQL_SERVER_TABLE_NAME VARCHAR(500)

SET @REPLICATION_SQL_SERVER_DATABASE_NAME = 'PUT_UR_DB_NAME_HERE' --<$(varCOMMONDB)> -- USE SQL SERVER DATABSE NAME HERE
SET @REPLICATION_SQL_SERVER_SCHEMA_NAME = 'Vision' -- USE SQL SERVER DB SCHEMA NAME HERE
SET @REPLICATION_SQL_SERVER_TABLE_NAME = 'PUT_UR_FINAL_SOURCE_TABLE_NAME_HERE'


/* **************************************************************************************** */
/* ******************* SCRIPT RUN FOR TABLE ZONE ********************* */
/* **************************************************************************************** */

BEGIN TRY
	BEGIN TRANSACTION INSERT_ZONE
	ALTER TABLE VISION.ZONE NOCHECK CONSTRAINT ALL /* DISABLE ALL TABLE CONSTRAINTS */
	BEGIN /* INSERTING RECORD */
		DECLARE @SQL_INSERT_ZONE VARCHAR(MAX)
		SET @SQL_INSERT_ZONE = '
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
						INSERT INTO '+ @REPLICATION_SQL_SERVER_DATABASE_NAME + '.' + @REPLICATION_SQL_SERVER_SCHEMA_NAME + '.ZONE ( LINK ,DESCRIPTION,PRCNT,TENANT_ID,DELETED,VERSION )
						SELECT @LINK ,@DESCRIPTION,@PRCNT,@TENANT_ID,@DELETED,@VERSION
					END
				FETCH NEXT FROM insert_cursor into @LINK,@DESCRIPTION,@PRCNT,@TENANT_ID,@DELETED,@VERSION
			END
			CLOSE insert_cursoR
			Deallocate insert_cursor
		END'
EXEC (@SQL_INSERT_ZONE)
--select @SQL_INSERT_ZONE

ALTER TABLE VISION.ZONE CHECK CONSTRAINT ALL /* Enable all table constraints */
END

COMMIT TRANSACTION INSERT_ZONE
SELECT 'TRANSACTION HAS BEEN RUN SUCCESSFULLY FOR INSERT_ZONE' AS TRANSACTION_STATUS
END TRY
BEGIN CATCH
-- Transaction uncommittable
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION INSERT_ZONE
SELECT 'TRANSACTION HAS BEEN FAIL FOR INSERT_ZONE' AS TRANSACTION_STATUS , ERROR_MESSAGE() 'ERROR_MESSAGE'
END CATCH






