--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[Groupings_Attribute]    Script Date: 8/30/2021 8:31:47 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[Groupings_Attribute_Test](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[groupings_id] [int] NOT NULL,
--	[attribute_id] [int] NULL,
--	[groupings_order] [int] NOT NULL,
--	[filters] [varchar](4000) NULL,
--	[parent_attribute_id] [int] NULL,
--	[tenant_id] [numeric](19, 0) NOT NULL,
-- CONSTRAINT [PK_Groupings_Attribute_Test] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test] ADD  DEFAULT ((0)) FOR [tenant_id]
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_Groupings_Attrib_Tenant_Id] FOREIGN KEY([tenant_id])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test] CHECK CONSTRAINT [FK_Groupings_Attrib_Tenant_Id]
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_Groupings_Attribute_Test_Attribute] FOREIGN KEY([attribute_id])
--REFERENCES [VISION].[Attribute] ([id])
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test] CHECK CONSTRAINT [FK_Groupings_Attribute_Test_Attribute]
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_Groupings_Attribute_Test_Groupings] FOREIGN KEY([groupings_id])
--REFERENCES [VISION].[Groupings] ([id])
--GO

--ALTER TABLE [VISION].[Groupings_Attribute_Test] CHECK CONSTRAINT [FK_Groupings_Attribute_Test_Groupings]
--GO







------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #Groupings_Attribute1

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

Create Table #Groupings_Attribute1 
(
   	
	[groupings_id] [int] NOT NULL,
	[attribute_id] [int] NULL,
	[groupings_order] [int] NOT NULL,
	[filters] [varchar](4000) NULL,
	[parent_attribute_id] [int] NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Groupings_Attribute1 
( [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,[tenant_id] )
Select 

          [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,[tenant_id]
from vision.Groupings_Attribute 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.Groupings_Attribute
(
  [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,[tenant_id])
Select 
   [groupings_id]
           ,[attribute_id]
           ,[groupings_order]
           ,[filters]
           ,[parent_attribute_id]
           ,@ID
from  #Groupings_Attribute1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Groupings_Attribute1 


GO

-- Select * from [VISION].[Groupings_Attribute]

-- DBCC CHECKIDENT('vision.Groupings_Attribute_Test')

-- DBCC CHECKIDENT('vision.Groupings_Attribute_Test',reseed,76)



--      Select 596 * 1
--      FINAL Total: 596


--  DELETE from Vision.Groupings_Attribute_test

--  Select count(*) from [VISION].[Groupings_Attribute_Test]

--Select * from [VISION].[Groupings_Attribute_Test]
--where TENANT_ID =1 