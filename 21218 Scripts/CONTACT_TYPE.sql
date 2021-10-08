USE [GLOBAL]
GO

/****** Object:  Table [VISION].[CONTACT_TYPE]    Script Date: 8/18/2021 7:40:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [VISION].[CONTACT_TYPE_Test](
	[LINK] [int] NOT NULL Identity(365,1),
	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	--[DELETED] [char](1) NOT NULL,
	--PREV Int Not Null,
	[VERSION] [int] NOT NULL,
 CONSTRAINT [pk_CONTACT_TYPE_Test] PRIMARY KEY CLUSTERED 
(
	[LINK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [VISION].[CONTACT_TYPE_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
GO

ALTER TABLE [VISION].[CONTACT_TYPE_Test] ADD  DEFAULT ('N') FOR [DELETED]
GO

ALTER TABLE [VISION].[CONTACT_TYPE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
GO

ALTER TABLE [VISION].[CONTACT_TYPE_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CONTACT_TYPE_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
REFERENCES [VISION].[SECURITY_TENANT] ([id])
GO

ALTER TABLE [VISION].[CONTACT_TYPE_Test] NOCHECK CONSTRAINT [FK_CONTACT_TYPE_Test_TENANT_ID]
GO


----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CONTACT_TYPE1

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

Create Table #CONTACT_TYPE1 
(
   	[DESCRIPTION] [nvarchar](100) NULL,
	[PRCNT] [int] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	--[DELETED] [char](1) NOT NULL,
--	PREV int not null,
	[VERSION] [int] NOT NULL)


Insert into #CONTACT_TYPE1 
Select 
[DESCRIPTION],
PRCNT,
TENANT_ID,
--DELETED ,
--PREV,
[VERSION] 
from vision.CONTACT_TYPE 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CONTACT_TYPE_test
( DESCRIPTION, PRCNT, TENANT_ID
--, DELETED
-- ,PREV
, VERSION)
Select 
[DESCRIPTION],
PRCNT,
@id,
--DELETED ,
--PREV,
[VERSION] 
from  #CONTACT_TYPE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #CONTACT_TYPE1 


GO

--  Select * from [VISION].[CONTACT_TYPE]

-- DBCC CHECKIDENT('vision.CONTACT_TYPE_Test')

-- DBCC CHECKIDENT('vision.CONTACT_TYPE_Test',reseed,365)



--      Select 596 * 5
--      FINAL Total: 2980


--  DELETE from Vision.CONTACT_TYPE_test

--  Select count(*) from [VISION].[CONTACT_TYPE_Test]

-- Select * from [VISION].[CONTACT_TYPE_Test]
-- where TENANT_ID =1 