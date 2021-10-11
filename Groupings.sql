--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[Groupings]    Script Date: 8/30/2021 8:26:08 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[Groupings_Test](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[groupings_name] [nvarchar](100) NOT NULL,
--	[description] [nvarchar](200) NULL,
--	[entity_type_id] [int] NULL,
--	[attribute_last_updated_on] [datetime] NULL,
--	[scope] [int] NOT NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
-- CONSTRAINT [PK_Groupings_Test] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #Groupings1

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

Create Table #Groupings1 
(
   	
	[groupings_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[entity_type_id] [int] NULL,
	[attribute_last_updated_on] [datetime] NULL,
	[scope] [int] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Groupings1 
([groupings_name]
           ,[description]
           ,[entity_type_id]
           ,[attribute_last_updated_on]
           ,[scope]
           ,[tenant_id] )
Select 

         [groupings_name]
           ,[description]
           ,[entity_type_id]
           ,[attribute_last_updated_on]
           ,[scope]
           ,[tenant_id]
from vision.Groupings 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.Groupings
(
 [groupings_name]
           ,[description]
           ,[entity_type_id]
           ,[attribute_last_updated_on]
           ,[scope]
           ,[tenant_id])
Select 
 [groupings_name]
           ,[description]
           ,[entity_type_id]
           ,[attribute_last_updated_on]
           ,[scope]
           ,@ID
from  #Groupings1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Groupings1 


GO

-- Select * from [VISION].[Groupings]

-- DBCC CHECKIDENT('vision.Groupings_Test')

-- DBCC CHECKIDENT('vision.Groupings_Test',reseed,1)



--      Select 596 * 1
--      FINAL Total: 596


--  DELETE from Vision.Groupings_test

--  Select count(*) from [VISION].[Groupings_Test]

--Select * from [VISION].[Groupings_Test]
--where TENANT_ID =1 