
DROP Table IF Exists #SecurityT
DROP Table IF Exists #TERMINAL_CATG_VALUES1
DROP Table if exists vision.##TERMINAL_CATG_VALUES2

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

Create Table #TERMINAL_CATG_VALUES1 
(
   	
	[LINK] [bigint] NOT NULL,
	[DESCRIPTION] [nvarchar](200) NOT NULL,
	[PRCNT] [smallint] NULL,
	[TERM_CATG_LINK] [int] NOT NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #TERMINAL_CATG_VALUES1 
(           [LINK]
           ,[DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION] )
Select 

            [LINK]
           ,[DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
from vision.TERMINAL_CATG_VALUES 
where Tenant_id = 0
and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation



DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(link) + 1 from  vision.TERMINAL_CATG_VALUES 
print @LINK

SET @sql = '
CREATE TABLE vision.##TERMINAL_CATG_VALUES2(
	[LINK] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
    [DESCRIPTION] [nvarchar](200) NOT NULL,
	[PRCNT] [smallint] NULL,
	[TERM_CATG_LINK] [int] NOT NULL,
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


Insert into Vision.##TERMINAL_CATG_VALUES2
(

           [DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION])
Select 

           [DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,@ID
           ,[DELETED]
           ,[VERSION]
from  #TERMINAL_CATG_VALUES1

SET @RowCount = @RowCount + 1
END

select * from Vision.##TERMINAL_CATG_VALUES2

DROP TABLE #SecurityT
Drop Table #TERMINAL_CATG_VALUES1 


GO

-- Select * from [VISION].[TERMINAL_CATG_VALUES]

-- DBCC CHECKIDENT('vision.TERMINAL_CATG_VALUES_Test')

-- DBCC CHECKIDENT('vision.TERMINAL_CATG_VALUES_Test',reseed,76)



--      Select 596 * 5
--      FINAL Total: 2980


--  DELETE from Vision.TERMINAL_CATG_VALUES_test

--  Select count(*) from [VISION].[TERMINAL_CATG_VALUES_Test]

--Select * from [VISION].[TERMINAL_CATG_VALUES_Test]
--where TENANT_ID =1 