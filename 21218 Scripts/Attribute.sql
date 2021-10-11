--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[Attribute]    Script Date: 8/19/2021 8:28:47 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[Attribute_Test](
--	[id] [int] IDENTITY(42,1) NOT NULL,
--	[attribute_name] [nvarchar](100) NOT NULL,
--	[description] [nvarchar](200) NULL,
--	[attribute_config] [nvarchar](100) NULL,
--	[attribute_value_type] [nvarchar](10) NULL,
--	[attribute_display_type] [nvarchar](10) NULL,
--	[ref_entity_type_id] [int] NULL,
--	[isIndexed] [bit] NOT NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
--	[row_ver] [timestamp] NOT NULL,
--	[sync_ver]  AS (CONVERT([bigint],[ROW_VER])) PERSISTED,
-- CONSTRAINT [PK_Attribute_Test] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[Attribute_Test] ADD  CONSTRAINT [DF_Attribute_Test_isIndexed]  DEFAULT ((0)) FOR [isIndexed]
--GO

--ALTER TABLE [VISION].[Attribute_Test] ADD  DEFAULT ((0)) FOR [tenant_id]
--GO

--ALTER TABLE [VISION].[Attribute_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_ATR_TYPE] FOREIGN KEY([Attribute_Test_value_type])
--REFERENCES [VISION].[Attribute_Test_TYPE] ([TYPE])
--GO

--ALTER TABLE [VISION].[Attribute_Test] CHECK CONSTRAINT [FK_ATR_TYPE]
--GO

--ALTER TABLE [VISION].[Attribute_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_Attribute_Test_Tenant_Id] FOREIGN KEY([tenant_id])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[Attribute_Test] CHECK CONSTRAINT [FK_Attribute_Test_Tenant_Id]
--GO


-------------------------------------------------------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #Attribute1

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

Create Table #Attribute1 
(
   	

	[attribute_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[attribute_config] [nvarchar](100) NULL,
	[attribute_value_type] [nvarchar](10) NULL,
	[attribute_display_type] [nvarchar](10) NULL,
	[ref_entity_type_id] [int] NULL,
	[isIndexed] [bit] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver]  AS (CONVERT([bigint],[ROW_VER])) PERSISTED)


Insert into #Attribute1 
([attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,[tenant_id] )
Select 

          [attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,[tenant_id]
from vision.Attribute 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.Attribute
(
 [attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,[tenant_id])
Select 
  [attribute_name]
           ,[description]
           ,[attribute_config]
           ,[attribute_value_type]
           ,[attribute_display_type]
           ,[ref_entity_type_id]
           ,[isIndexed]
           ,@ID
from  #Attribute1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Attribute1 


GO

-- Select * from [VISION].[Attribute]

-- DBCC CHECKIDENT('vision.Attribute_Test_Test')

-- DBCC CHECKIDENT('vision.Attribute_Test_Test',reseed,76)



--      Select 596 * 41
--      FINAL Total: 24436


--  DELETE from Vision.Attribute_Test

--  Select count(*) from [VISION].[Attribute_Test]

--Select * from [VISION].[Attribute_Test]
--where TENANT_ID =1 