--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[Entity_Type]    Script Date: 8/30/2021 7:46:01 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[Entity_Type_Test](
--	[id] [int] IDENTITY(2,1) NOT NULL,
--	[entity_type_name] [nvarchar](50) NOT NULL,
--	[description] [nvarchar](100) NOT NULL,
--	[icon_class] [varchar](25) NULL,
--	[MONITOR_LOGIC] [nvarchar](50) NULL,
--	[MONITOR_INTERVAL_MS] [int] NULL,
--	[MONITORING] [int] NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
-- CONSTRAINT [PK_Entity_Type_Test] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO





------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #Entity_Type_Test1

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

Create Table #Entity_Type_Test1
(
   	[entity_type_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[icon_class] [varchar](25) NULL,
	[MONITOR_LOGIC] [nvarchar](50) NULL,
	[MONITOR_INTERVAL_MS] [int] NULL,
	[MONITORING] [int] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Entity_Type_Test1 
(          [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,[tenant_id] )
Select 

            [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,[tenant_id]
from vision.Entity_Type 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.Entity_Type
(
 		    [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,[tenant_id] )
          
          
Select 
  
            [entity_type_name]
           ,[description]
           ,[icon_class]
           ,[MONITOR_LOGIC]
           ,[MONITOR_INTERVAL_MS]
           ,[MONITORING]
           ,@ID
from  #Entity_Type_Test1 

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Entity_Type_Test1 


GO

-- Select * from [VISION].[Entity_TYPE]

-- DBCC CHECKIDENT('vision.Entity_TYPE_Test')

-- DBCC CHECKIDENT('vision.Entity_TYPE_Test',reseed,365)



--      Select 596 * 5419
--      FINAL Total: 3229724


--  DELETE from Vision.Entity_test

----  Select count(*) from [VISION].[Entity_TYPE_Test]

--Select * from [VISION].[Entity_TYPE_Test]
--where TENANT_ID =1 