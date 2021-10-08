USE [GLOBAL]
GO

/****** Object:  Table [VISION].[EMAIL_TEMPLATE]    Script Date: 8/19/2021 10:09:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE VISION.EMAIL_TEMPLATE_Test(
	[DESCRIPTION] [varchar](50) NULL,
	[SUBJECT] [varchar](250) NOT NULL,
	[TEMPLATE] [varbinary](max) NOT NULL,
	[CREATED_DATE] [datetime] NULL,
	[CREATED_BY] [varchar](50) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[MODIFIED_BY] [varchar](50) NULL,
	[TENANT_ID] [numeric](19, 0) NULL,
	[VERSION] [int] NOT NULL,
	[TEMPLATE_ID] [numeric](18, 0) IDENTITY(2,1) NOT NULL,
 CONSTRAINT [PK_TEMPLATE_Test_ID] PRIMARY KEY CLUSTERED 
(
	[TEMPLATE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [VISION].[EMAIL_TEMPLATE_Test] ADD  DEFAULT ((1)) FOR [VERSION]
GO

ALTER TABLE [VISION].[EMAIL_TEMPLATE_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_TEMPLATE_TENANT_ID] FOREIGN KEY([TENANT_ID])
REFERENCES [VISION].[SECURITY_TENANT] ([id])
GO

ALTER TABLE [VISION].[EMAIL_TEMPLATE_Test] CHECK CONSTRAINT [FK_TEMPLATE_TENANT_ID]
GO






----------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #EMAIL_TEMPLATE1

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

Create Table #EMAIL_TEMPLATE1 
(
   	
	[DESCRIPTION] [varchar](50) NULL,
	[SUBJECT] [varchar](250) NOT NULL,
	[TEMPLATE] [varbinary](max) NOT NULL,
	[CREATED_DATE] [datetime] NULL,
	[CREATED_BY] [varchar](50) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[MODIFIED_BY] [varchar](50) NULL,
	[TENANT_ID] [numeric](19, 0) NULL,
	[VERSION] [int] NOT NULL,)


Insert into #EMAIL_TEMPLATE1 
([DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[TENANT_ID]
           ,[VERSION] )
Select 

         [DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[TENANT_ID]
           ,[VERSION]
from vision.EMAIL_TEMPLATE 
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.EMAIL_TEMPLATE_test
(
 
         [DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,[TENANT_ID]
           ,[VERSION])
Select 
  
          [DESCRIPTION]
           ,[SUBJECT]
           ,[TEMPLATE]
           ,[CREATED_DATE]
           ,[CREATED_BY]
           ,[MODIFIED_DATE]
           ,[MODIFIED_BY]
           ,@ID
           ,[VERSION]
from  #EMAIL_TEMPLATE1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #EMAIL_TEMPLATE1 


GO

-- Select * from [VISION].[EMAIL_TEMPLATE]

-- DBCC CHECKIDENT('vision.EMAIL_TEMPLATE_Test')

-- DBCC CHECKIDENT('vision.EMAIL_TEMPLATE_Test',reseed,365)



--      Select 596 * 1
--      FINAL Total: 596


--  DELETE from Vision.EMAIL_TEMPLATE_test

--  Select count(*) from [VISION].[EMAIL_TEMPLATE_Test]

Select * from [VISION].[EMAIL_TEMPLATE_Test]
where TENANT_ID =1 