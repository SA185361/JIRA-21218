--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[INSTITUTION]    Script Date: 8/18/2021 7:40:55 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[INSTITUTION_Test](
--	[LINK] [int] NOT NULL Identity(17,1),
--	[DESCRIPTION] [nvarchar](100) NULL,
--	[PRCNT] [smallint] NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[DELETED] [char](1) NOT NULL,
--	--PREV Int Not Null,
--	[VERSION] [int] NOT NULL,
-- CONSTRAINT [pk_INSTITUTION_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[INSTITUTION_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[INSTITUTION_Test] ADD  DEFAULT ('N') FOR [DELETED]
--GO

--ALTER TABLE [VISION].[INSTITUTION_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[INSTITUTION_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_INSTITUTION_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[INSTITUTION_Test] NOCHECK CONSTRAINT [FK_INSTITUTION_Test_TENANT_ID]
--GO


------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #INSTITUTION1

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

Create Table #INSTITUTION1 
(
   	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	--PREV int not null,
	[VERSION] [int] NOT NULL)


Insert into #INSTITUTION1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
DELETED ,
--PREV,
[VERSION] 
from vision.INSTITUTION 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation
where Tenant_id = 0


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.INSTITUTION
(
 DESCRIPTION
 , PRCNT
 , TENANT_ID
 , DELETED
 --,PREV
 , VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
DELETED ,
--PREV,
[VERSION] 
from  #INSTITUTION1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #INSTITUTION1 


GO

-- Select * from [VISION].[INSTITUTION]

-- DBCC CHECKIDENT('vision.INSTITUTION_Test')

-- DBCC CHECKIDENT('vision.INSTITUTION_Test',reseed,17)



--      Select 596 * 16
--      FINAL Total: 9536


--  DELETE from Vision.INSTITUTION_test

--  Select count(*) from [VISION].[INSTITUTION_Test]

--Select * from [VISION].[INSTITUTION_Test]
--where TENANT_ID =1 