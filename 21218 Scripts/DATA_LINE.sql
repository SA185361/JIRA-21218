USE [GLOBAL]
GO

/****** Object:  Table [VISION].[DATA_LINE_Test]    Script Date: 8/18/2021 9:47:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [VISION].[DATA_LINE_Test](
	[LINK] [int] NOT NULL IDENTITY (15,1),
	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [smallint] NULL,
	[TOTAL] [int] NULL,
	[THRESHOLD] [int] NULL,
	[DOWN] [int] NULL,
	[OBJECT_LINK] [int] NULL,
	[THRESHOLD_PERCENT] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL,
 CONSTRAINT [pk_DATA_LINE_Test] PRIMARY KEY CLUSTERED 
(
	[LINK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [VISION].[DATA_LINE_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
GO

ALTER TABLE [VISION].[DATA_LINE_Test] ADD  DEFAULT ('N') FOR [DELETED]
GO

ALTER TABLE [VISION].[DATA_LINE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
GO

ALTER TABLE [VISION].[DATA_LINE_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_DATA_LINE_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
REFERENCES [VISION].[SECURITY_TENANT] ([id])
GO

ALTER TABLE [VISION].[DATA_LINE_Test] CHECK CONSTRAINT [FK_DATA_LINE_Test_TENANT_ID]
GO




----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #DATA_LINE

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

Create Table #DATA_LINE 
(
   
	[DESCRIPTION] [nvarchar](30) NULL,
	[PRCNT] [smallint] NULL,
	[TOTAL] [int] NULL,
	[THRESHOLD] [int] NULL,
	[DOWN] [int] NULL,
	[OBJECT_LINK] [int] NULL,
	[THRESHOLD_PERCENT] [smallint] NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[DELETED] [char](1) NOT NULL,
	[VERSION] [int] NOT NULL
	)


Insert into #DATA_LINE 
([DESCRIPTION]
,[PRCNT]
,[TOTAL]
,[THRESHOLD]
,[DOWN]
,[OBJECT_LINK]
,[THRESHOLD_PERCENT]
,[TENANT_ID]
,[DELETED]
,[VERSION])
Select 
 [DESCRIPTION]
,[PRCNT]
,[TOTAL]
,[THRESHOLD]
,[DOWN]
,[OBJECT_LINK]
,[THRESHOLD_PERCENT]
,[TENANT_ID]
,[DELETED]
,[VERSION]
from vision.DATA_LINE 
where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.DATA_LINE_test
( 
DESCRIPTION
,PRCNT
,TOTAL
,THRESHOLD
,DOWN
,OBJECT_LINK
,THRESHOLD_PERCENT
,TENANT_ID
,DELETED
,VERSION
)
Select 
DESCRIPTION
,PRCNT
,TOTAL
,THRESHOLD
,DOWN
,OBJECT_LINK
,THRESHOLD_PERCENT
,@ID
,DELETED
,VERSION
from  #DATA_LINE

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #DATA_LINE 


GO

--  Select * from [VISION].[DATA_LINE]

-- DBCC CHECKIDENT('vision.DATA_LINE_Test')

-- DBCC CHECKIDENT('vision.DATA_LINE_Test',reseed,15)



--      Select 596 * 14
--      FINAL Total: 8344


--  DELETE from Vision.DATA_LINE_test

--  Select count(*) from [VISION].[DATA_LINE_Test]

Select * from [VISION].[DATA_LINE_Test]
where TENANT_ID =1 