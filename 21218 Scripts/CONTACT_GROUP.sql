--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[CONTACT_GROUP]    Script Date: 8/19/2021 10:05:53 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[CONTACT_GROUP_Test](
--	[DESCRIPTION] [nvarchar](30) NOT NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	[VERSION] [int] NOT NULL,
--	[LINK] [int] IDENTITY(6536,1) NOT NULL,
--	[CODE] [nvarchar](30) NOT NULL,
-- CONSTRAINT [pk_CONTACT_GROUP_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
-- CONSTRAINT [UNQ_CONTACTGROUP_CODE] UNIQUE NONCLUSTERED 
--(
--	[CODE] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
-- CONSTRAINT [UNQ_CONTACTGROUP_DESC] UNIQUE NONCLUSTERED 
--(
--	[DESCRIPTION] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[CONTACT_GROUP_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[CONTACT_GROUP_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[CONTACT_GROUP_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[CONTACT_GROUP_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CONTACT_GROUP_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[CONTACT_GROUP_Test] CHECK CONSTRAINT [FK_CONTACT_GROUP_Test_TENANT_ID]
--GO




------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CONTACT_GROUP1

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

Create Table #CONTACT_GROUP1 
(
   	
	[DESCRIPTION] [nvarchar](30) NOT NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL,
	[CODE] [nvarchar](30) NOT NULL)


Insert into #CONTACT_GROUP1 
([DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[CODE] )
Select 

          [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[CODE]
from vision.CONTACT_GROUP 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CONTACT_GROUP
(
 
         [DESCRIPTION]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
           ,[CODE])
Select 
  
           [DESCRIPTION]
           ,@ID
           ,[DELETED]
           ,[VERSION]
           ,[CODE]
from  #CONTACT_GROUP1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #CONTACT_GROUP1 


GO

-- Select * from [VISION].[CONTACT_GROUP]

-- DBCC CHECKIDENT('vision.CONTACT_GROUP_Test')

-- DBCC CHECKIDENT('vision.CONTACT_GROUP_Test',reseed,365)



--      Select 596 * 136
--      FINAL Total: 81056


--  DELETE from Vision.CONTACT_GROUP_test

--  Select count(*) from [VISION].[CONTACT_GROUP_Test]

Select * from [VISION].[CONTACT_GROUP_Test]
where TENANT_ID =1 