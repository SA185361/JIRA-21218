--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[RESOLUTION_CODE]    Script Date: 8/19/2021 7:55:16 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[RESOLUTION_CODE_Test](
--	[LINK] [smallint] NOT NULL IDENTITY (67,1),
--	[DESCRIPTION] [nvarchar](60) NULL,
--	[NAME] [varchar](30) NOT NULL,
--	[VERSION] [int] NOT NULL,
-- CONSTRAINT [pk_RESOLUTION_CODE_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
-- CONSTRAINT [UK_RESOLUTION_NAME] UNIQUE NONCLUSTERED 
--(
--	[NAME] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[RESOLUTION_CODE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO



------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #RESOLUTION_CODE1

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

Create Table #RESOLUTION_CODE1 
(
   	[DESCRIPTION] [nvarchar](60) NULL,
	[NAME] [varchar](30) NOT NULL,
	[VERSION] [int] NOT NULL,)


Insert into #RESOLUTION_CODE1 
Select 
[DESCRIPTION]
           ,[NAME]
           ,[VERSION]
from vision.RESOLUTION_CODE 
Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.RESOLUTION_CODE
(
[DESCRIPTION]
           ,[NAME]
           ,[VERSION])
Select 
[DESCRIPTION]
           ,[NAME]
           ,[VERSION] 
from  #RESOLUTION_CODE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #RESOLUTION_CODE1 


GO

-- Select * from [VISION].[RESOLUTION_CODE]

-- DBCC CHECKIDENT('vision.RESOLUTION_CODE_Test')

-- DBCC CHECKIDENT('vision.RESOLUTION_CODE_Test',reseed,365)



--      Select 596 * 67
--      FINAL Total: 39932


--  DELETE from Vision.RESOLUTION_CODE_test

--  Select count(*) from [VISION].[RESOLUTION_CODE_Test]

--Select * from [VISION].[RESOLUTION_CODE_Test]
--where TENANT_ID =1 