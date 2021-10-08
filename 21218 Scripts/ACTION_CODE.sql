USE [GLOBAL]
GO

/****** Object:  Table [VISION].[ACTION_CODE]    Script Date: 8/19/2021 8:08:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [VISION].[ACTION_CODE_Test](
	[LINK] [int] NOT NULL identity(76,1),
	[DESCRIPTION] [nvarchar](30) NULL,
	[RGB_COLOR] [int] NULL,
	[REOPEN_LIMIT] [smallint] NULL,
	[ACTION_COLUMN] [smallint] NULL,
	[FILTER] [int] NULL,
	[COLOR] [smallint] NULL,
	[ARRIVAL_TO_CLEAR] [int] NULL,
	[PERFORMANCE_COL] [smallint] NULL,
	[PERFORMANCE_132COL] [smallint] NULL,
	[AUTODIALER] [smallint] NULL,
	[DOWNHOURS1] [int] NULL,
	[DOWNCOLOR1] [int] NULL,
	[DOWNHOURS2] [int] NULL,
	[DOWNCOLOR2] [int] NULL,
	[DOWNHOURS3] [int] NULL,
	[DOWNCOLOR3] [int] NULL,
	[VERSION] [int] NOT NULL,
	[MAINTENANCE_MODE_EXCEPTION] [char](1) NULL,
 CONSTRAINT [pk_ACTION_CODE_Test] PRIMARY KEY CLUSTERED 
(
	[LINK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [VISION].[ACTION_CODE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
GO





----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #ACTION_CODE1

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

Create Table #ACTION_CODE1 
(
   	
	[DESCRIPTION] [nvarchar](30) NULL,
	[RGB_COLOR] [int] NULL,
	[REOPEN_LIMIT] [smallint] NULL,
	[ACTION_COLUMN] [smallint] NULL,
	[FILTER] [int] NULL,
	[COLOR] [smallint] NULL,
	[ARRIVAL_TO_CLEAR] [int] NULL,
	[PERFORMANCE_COL] [smallint] NULL,
	[PERFORMANCE_132COL] [smallint] NULL,
	[AUTODIALER] [smallint] NULL,
	[DOWNHOURS1] [int] NULL,
	[DOWNCOLOR1] [int] NULL,
	[DOWNHOURS2] [int] NULL,
	[DOWNCOLOR2] [int] NULL,
	[DOWNHOURS3] [int] NULL,
	[DOWNCOLOR3] [int] NULL,
	[VERSION] [int] NOT NULL,
	[MAINTENANCE_MODE_EXCEPTION] [char](1) NULL)


Insert into #ACTION_CODE1 
([DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION] )
Select 

          [DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION]
from vision.ACTION_CODE 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.ACTION_CODE_test
(
 [DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION])
Select 
  [DESCRIPTION]
           ,[RGB_COLOR]
           ,[REOPEN_LIMIT]
           ,[ACTION_COLUMN]
           ,[FILTER]
           ,[COLOR]
           ,[ARRIVAL_TO_CLEAR]
           ,[PERFORMANCE_COL]
           ,[PERFORMANCE_132COL]
           ,[AUTODIALER]
           ,[DOWNHOURS1]
           ,[DOWNCOLOR1]
           ,[DOWNHOURS2]
           ,[DOWNCOLOR2]
           ,[DOWNHOURS3]
           ,[DOWNCOLOR3]
           ,[VERSION]
           ,[MAINTENANCE_MODE_EXCEPTION]
from  #ACTION_CODE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #ACTION_CODE1 


GO

-- Select * from [VISION].[ACTION_CODE]

-- DBCC CHECKIDENT('vision.ACTION_CODE_Test')

-- DBCC CHECKIDENT('vision.ACTION_CODE_Test',reseed,76)



--      Select 596 * 75
--      FINAL Total: 44700


--  DELETE from Vision.ACTION_CODE_test

--  Select count(*) from [VISION].[ACTION_CODE_Test]

Select * from [VISION].[ACTION_CODE_Test]
where TENANT_ID =1 