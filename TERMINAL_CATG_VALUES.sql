--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[TERMINAL_CATG_VALUES]    Script Date: 8/30/2021 11:31:59 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[TERMINAL_CATG_VALUES_Test](
--	[LINK] [bigint] NOT NULL,
--	[DESCRIPTION] [nvarchar](200) NOT NULL,
--	[PRCNT] [smallint] NULL,
--	[TERM_CATG_LINK] [int] NOT NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	[VERSION] [int] NOT NULL,
-- CONSTRAINT [PK_TERM_CATG_VALUES_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_TERM_CATG_VALUES_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test] CHECK CONSTRAINT [FK_TERM_CATG_VALUES_TENANT_ID]
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_TERMINAL_CATG_VALUES_Test_TERM] FOREIGN KEY([TERM_CATG_LINK])
--REFERENCES [VISION].[TERMINAL_CATEGORY] ([LINK])
--ON DELETE CASCADE
--GO

--ALTER TABLE [VISION].[TERMINAL_CATG_VALUES_Test] CHECK CONSTRAINT [FK_TERMINAL_CATG_VALUES_Test_TERM]
--GO



------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #TERMINAL_CATG_VALUES1

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

Create Table #TERMINAL_CATG_VALUES1 
(
   	
	[LINK] [bigint] NOT NULL,
	[DESCRIPTION] [nvarchar](200) NOT NULL,
	[PRCNT] [smallint] NULL,
	[TERM_CATG_LINK] [int] NOT NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL)


Insert into #TERMINAL_CATG_VALUES1 
([LINK]
           ,[DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION] )
Select 

        [LINK]
           ,[DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION]
from vision.TERMINAL_CATG_VALUES 
where Tenant_id = 0
-- where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.TERMINAL_CATG_VALUES
(
 [LINK]
           ,[DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,[TENANT_ID]
           ,[DELETED]
           ,[VERSION])
Select 
[LINK]
           ,[DESCRIPTION]
           ,[PRCNT]
           ,[TERM_CATG_LINK]
           ,@ID
           ,[DELETED]
           ,[VERSION]
from  #TERMINAL_CATG_VALUES1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #TERMINAL_CATG_VALUES1 


GO

-- Select * from [VISION].[TERMINAL_CATG_VALUES]

-- DBCC CHECKIDENT('vision.TERMINAL_CATG_VALUES_Test')

-- DBCC CHECKIDENT('vision.TERMINAL_CATG_VALUES_Test',reseed,76)



--      Select 596 * 5
--      FINAL Total: 2980


--  DELETE from Vision.TERMINAL_CATG_VALUES_test

--  Select count(*) from [VISION].[TERMINAL_CATG_VALUES_Test]

--Select * from [VISION].[TERMINAL_CATG_VALUES_Test]
--where TENANT_ID =1 