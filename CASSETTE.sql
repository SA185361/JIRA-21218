--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[CASSETTE]    Script Date: 8/19/2021 8:40:02 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[CASSETTE_Test](
--	[DESCRIPTION] [varchar](255) NULL,
--	[VERSION] [int] NOT NULL,
--	[TENANT_ID] [int] NOT NULL,
--	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
--	[CASSETTE_TYPE] [varchar](15) NOT NULL,
-- CONSTRAINT [PK__CASSETTE_Test__3214EC273047D355] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[CASSETTE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[CASSETTE_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[CASSETTE_Test] ADD  DEFAULT ('LEGACY') FOR [CASSETTE_Test_TYPE]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CASSETTE1

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


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CASSETTE
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

DROP TABLE #SecurityT
Drop Table #CASSETTE1 


GO

-- Select * from [VISION].[CASSETTE]

-- DBCC CHECKIDENT('vision.CASSETTE_Test')

-- DBCC CHECKIDENT('vision.CASSETTE_Test',reseed,365)



--      Select 596 * 136
--      FINAL Total: 81056


--  DELETE from Vision.CASSETTE_test

--  Select count(*) from [VISION].[CASSETTE_Test]

--Select * from [VISION].[CASSETTE_Test]
--where TENANT_ID =1 