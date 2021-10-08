USE [GLOBAL]
GO

/****** Object:  Table [VISION].[Entity]    Script Date: 8/19/2021 10:23:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [VISION].[Entity_Test](
	[id] [int] IDENTITY(5420,1) NOT NULL,
	[entity_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[external_id] [nvarchar](50) NULL,
	[version] [int] NULL,
	[logical_delete] [bit] NOT NULL,
	[entity_info] [varchar](100) NULL,
	[entity_type_id] [int] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL,
 CONSTRAINT [PK_Entity_Test] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [VISION].[Entity_Test] ADD  DEFAULT ((0)) FOR [logical_delete]
GO

ALTER TABLE [VISION].[Entity_Test] ADD  DEFAULT ((0)) FOR [tenant_id]
GO

ALTER TABLE [VISION].[Entity_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_Entity_Test_Entity_Type] FOREIGN KEY([Entity_Test_type_id])
REFERENCES [VISION].[Entity_Test_Type] ([id])
GO

ALTER TABLE [VISION].[Entity_Test] CHECK CONSTRAINT [FK_Entity_Test_Entity_Type]
GO

ALTER TABLE [VISION].[Entity_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_Entity_Test_Tenant_Id] FOREIGN KEY([tenant_id])
REFERENCES [VISION].[SECURITY_TENANT] ([id])
GO

ALTER TABLE [VISION].[Entity_Test] CHECK CONSTRAINT [FK_Entity_Tenant_Id]
GO






----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #Entity1

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

Create Table #Entity1 
(
   	
	[entity_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NULL,
	[external_id] [nvarchar](50) NULL,
	[version] [int] NULL,
	[logical_delete] [bit] NOT NULL,
	[entity_info] [varchar](100) NULL,
	[entity_type_id] [int] NOT NULL,
	[tenant_id] [numeric](19, 0) NOT NULL)


Insert into #Entity1 
(           [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,[tenant_id] )
Select 

        [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,[tenant_id]
from vision.Entity 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.Entity_test
(
 
        [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,[tenant_id])
Select 
  
         [entity_name]
           ,[description]
           ,[external_id]
           ,[version]
           ,[logical_delete]
           ,[entity_info]
           ,[entity_type_id]
           ,@ID
from  #Entity1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #Entity1 


GO

-- Select * from [VISION].[Entity]

-- DBCC CHECKIDENT('vision.Entity_Test')

-- DBCC CHECKIDENT('vision.Entity_Test',reseed,365)



--      Select 596 * 5419
--      FINAL Total: 3229724


--  DELETE from Vision.Entity_test

--  Select count(*) from [VISION].[Entity_Test]

Select * from [VISION].[Entity_Test]
where TENANT_ID =1 