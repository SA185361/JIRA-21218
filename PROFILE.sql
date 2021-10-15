


DROP Table IF Exists #SecurityT
DROP Table IF Exists #PROFILE1
DROP Table if exists vision.##PROFILE2

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

Create Table #PROFILE1 
(
   	
	[NAME] [varchar](100) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[USER_ID] [varchar](100) NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[INC_UNDEFINED] [int] NOT NULL,
	[TERMINAL_CRITERIA] [varbinary](max) NULL)


Insert into #PROFILE1 
(  [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,[TENANT_ID]
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA] )
Select 

           [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,[TENANT_ID]
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA]
from vision.PROFILE 
where Tenant_id = 0
--and deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


DECLARE @sql varchar(8000);
Declare @LINK int;
Select @LINK = max(ID) + 1 from  vision.PROFILE 
print @LINK

SET @sql = '
CREATE TABLE vision.##PROFILE2(
	[ID] [int] Identity (' + CAST(@link AS varchar(15)) + ',1) NOT NULL,
   [NAME] [varchar](100) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[USER_ID] [varchar](100) NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[INC_UNDEFINED] [int] NOT NULL,
	[TERMINAL_CRITERIA] [varbinary](max) NULL)

	';

EXEC (@sql);


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into vision.##PROFILE2
(
   [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,[TENANT_ID]
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA])
Select 
   [NAME]
           ,[DESCRIPTION]
           ,[USER_ID]
           ,@ID
           ,[INC_UNDEFINED]
           ,[TERMINAL_CRITERIA]
from  #PROFILE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #PROFILE1 


GO

select * from vision.##PROFILE2

-- Select * from [VISION].[PROFILE]

-- DBCC CHECKIDENT('vision.PROFILE_Test')

-- DBCC CHECKIDENT('vision.PROFILE_Test',reseed,76)



--      Select 596 * 0
--      FINAL Total: 44700


--  DELETE from Vision.PROFILE_test

--  Select count(*) from [VISION].[PROFILE_Test]

--Select * from [VISION].[PROFILE_Test]
--where TENANT_ID =1 