--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[CONTACT]    Script Date: 8/19/2021 7:03:30 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[CONTACT_Test](
--	[NAME] [nvarchar](30) NULL,
--	[PHONE1] [varchar](20) NULL,
--	[PHONE2] [varchar](20) NULL,
--	[PHONE3] [varchar](20) NULL,
--	[PAGER_ID1] [char](12) NULL,
--	[PAGER_ID2] [char](12) NULL,
--	[PAGER_ID3] [char](12) NULL,
--	[PROTOCOL1] [smallint] NULL,
--	[PROTOCOL2] [smallint] NULL,
--	[PROTOCOL3] [smallint] NULL,
--	[CALL_ANALYSIS1] [smallint] NULL,
--	[CALL_ANALYSIS2] [smallint] NULL,
--	[CALL_ANALYSIS3] [smallint] NULL,
--	[DISPATCHER_MENU_OPTIONS] [varbinary](12) NULL,
--	[DISPATCHER_PASSWORD] [char](10) NULL,
--	[OBJECT_CATEGORY] [smallint] NULL,
--	[OBJECT_SELECTION] [char](70) NULL,
--	[HOURS_DAYS1] [smallint] NULL,
--	[HOURS_DAYS2] [smallint] NULL,
--	[HOURS_DAYS3] [smallint] NULL,
--	[HOURS_DAYS4] [smallint] NULL,
--	[HOURS_DAYS5] [smallint] NULL,
--	[HOURS_DAYS6] [smallint] NULL,
--	[HOURS_DAYS7] [smallint] NULL,
--	[HOURS_DAYS8] [smallint] NULL,
--	[HOURS_DAYS9] [smallint] NULL,
--	[HOURS_DAYS10] [smallint] NULL,
--	[HOURS_START1] [smallint] NULL,
--	[HOURS_START2] [smallint] NULL,
--	[HOURS_START3] [smallint] NULL,
--	[HOURS_START4] [smallint] NULL,
--	[HOURS_START5] [smallint] NULL,
--	[HOURS_START6] [smallint] NULL,
--	[HOURS_START7] [smallint] NULL,
--	[HOURS_START8] [smallint] NULL,
--	[HOURS_START9] [smallint] NULL,
--	[HOURS_START10] [smallint] NULL,
--	[HOURS_END1] [smallint] NULL,
--	[HOURS_END2] [smallint] NULL,
--	[HOURS_END3] [smallint] NULL,
--	[HOURS_END4] [smallint] NULL,
--	[HOURS_END5] [smallint] NULL,
--	[HOURS_END6] [smallint] NULL,
--	[HOURS_END7] [smallint] NULL,
--	[HOURS_END8] [smallint] NULL,
--	[HOURS_END9] [smallint] NULL,
--	[HOURS_END10] [smallint] NULL,
--	[IXO_PASSWORD1] [char](6) NULL,
--	[IXO_PASSWORD2] [char](6) NULL,
--	[IXO_PASSWORD3] [char](6) NULL,
--	[ALIAS_NUM] [smallint] NULL,
--	[TIME_OFFSET] [smallint] NULL,
--	[ACKNOWLEDGE_INTERVAL1] [smallint] NULL,
--	[ACKNOWLEDGE_INTERVAL2] [smallint] NULL,
--	[ACKNOWLEDGE_INTERVAL3] [smallint] NULL,
--	[NO_CONNECT_INTERVAL1] [smallint] NULL,
--	[NO_CONNECT_INTERVAL2] [smallint] NULL,
--	[NO_CONNECT_INTERVAL3] [smallint] NULL,
--	[ACKNOWLEDGE_ATTEMPTS1] [smallint] NULL,
--	[ACKNOWLEDGE_ATTEMPTS2] [smallint] NULL,
--	[ACKNOWLEDGE_ATTEMPTS3] [smallint] NULL,
--	[NO_CONNECT_ATTEMPTS1] [smallint] NULL,
--	[NO_CONNECT_ATTEMPTS2] [smallint] NULL,
--	[NO_CONNECT_ATTEMPTS3] [smallint] NULL,
--	[LANGUAGE_NUM] [smallint] NULL,
--	[FORWARD_CALLS] [char](1) NULL,
--	[FORWARD_CALLS_PHONE] [smallint] NULL,
--	[FORWARD_CONTACT_LINK] [int] NULL,
--	[ORGANIZATION_LINK] [smallint] NULL,
--	[CONTACT_TYPE_LINK] [smallint] NULL,
--	[NOTES] [varchar](400) NULL,
--	[AVAILABLE] [datetime] NULL,
--	[UNAVAILABLE] [datetime] NULL,
--	[INTERFACE_PASSWORD] [varbinary](20) NULL,
--	[INTERFACE_OBJECTID] [char](10) NULL,
--	[INTERFACE_USERID] [char](20) NULL,
--	[EMAIL_ADDRESS] [varchar](100) NULL,
--	[ID] [varchar](30) NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[VERSION] [int] NOT NULL,
--	[LINK] [int] IDENTITY(37769,1) NOT NULL,
--	[UNAVAILABLE_START_DATE_TIME] [datetime] NULL,
--	[UNAVAILABLE_END_DATE_TIME] [datetime] NULL,
-- CONSTRAINT [pk_CONTACT_Test] PRIMARY KEY CLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
-- CONSTRAINT [uni_CONTACT_Test_ID] UNIQUE NONCLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [VISION].[CONTACT_Test] ADD  DEFAULT ((0)) FOR [TENANT_ID]
--GO

--ALTER TABLE [VISION].[CONTACT_Test] ADD  DEFAULT ((1)) FOR [VERSION]
--GO

--ALTER TABLE [VISION].[CONTACT_Test]  WITH NOCHECK ADD  CONSTRAINT [FK_CONTACT_Test_TENANT_ID] FOREIGN KEY([TENANT_ID])
--REFERENCES [VISION].[SECURITY_TENANT] ([id])
--GO

--ALTER TABLE [VISION].[CONTACT_Test] CHECK CONSTRAINT [FK_CONTACT_Test_TENANT_ID]
--GO






------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #CONTACT1

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

Create Table #CONTACT1 
(
   [NAME] [nvarchar](30) NULL,
	[PHONE1] [varchar](20) NULL,
	[PHONE2] [varchar](20) NULL,
	[PHONE3] [varchar](20) NULL,
	[PAGER_ID1] [char](12) NULL,
	[PAGER_ID2] [char](12) NULL,
	[PAGER_ID3] [char](12) NULL,
	[PROTOCOL1] [smallint] NULL,
	[PROTOCOL2] [smallint] NULL,
	[PROTOCOL3] [smallint] NULL,
	[CALL_ANALYSIS1] [smallint] NULL,
	[CALL_ANALYSIS2] [smallint] NULL,
	[CALL_ANALYSIS3] [smallint] NULL,
	[DISPATCHER_MENU_OPTIONS] [varbinary](12) NULL,
	[DISPATCHER_PASSWORD] [char](10) NULL,
	[OBJECT_CATEGORY] [smallint] NULL,
	[OBJECT_SELECTION] [char](70) NULL,
	[HOURS_DAYS1] [smallint] NULL,
	[HOURS_DAYS2] [smallint] NULL,
	[HOURS_DAYS3] [smallint] NULL,
	[HOURS_DAYS4] [smallint] NULL,
	[HOURS_DAYS5] [smallint] NULL,
	[HOURS_DAYS6] [smallint] NULL,
	[HOURS_DAYS7] [smallint] NULL,
	[HOURS_DAYS8] [smallint] NULL,
	[HOURS_DAYS9] [smallint] NULL,
	[HOURS_DAYS10] [smallint] NULL,
	[HOURS_START1] [smallint] NULL,
	[HOURS_START2] [smallint] NULL,
	[HOURS_START3] [smallint] NULL,
	[HOURS_START4] [smallint] NULL,
	[HOURS_START5] [smallint] NULL,
	[HOURS_START6] [smallint] NULL,
	[HOURS_START7] [smallint] NULL,
	[HOURS_START8] [smallint] NULL,
	[HOURS_START9] [smallint] NULL,
	[HOURS_START10] [smallint] NULL,
	[HOURS_END1] [smallint] NULL,
	[HOURS_END2] [smallint] NULL,
	[HOURS_END3] [smallint] NULL,
	[HOURS_END4] [smallint] NULL,
	[HOURS_END5] [smallint] NULL,
	[HOURS_END6] [smallint] NULL,
	[HOURS_END7] [smallint] NULL,
	[HOURS_END8] [smallint] NULL,
	[HOURS_END9] [smallint] NULL,
	[HOURS_END10] [smallint] NULL,
	[IXO_PASSWORD1] [char](6) NULL,
	[IXO_PASSWORD2] [char](6) NULL,
	[IXO_PASSWORD3] [char](6) NULL,
	[ALIAS_NUM] [smallint] NULL,
	[TIME_OFFSET] [smallint] NULL,
	[ACKNOWLEDGE_INTERVAL1] [smallint] NULL,
	[ACKNOWLEDGE_INTERVAL2] [smallint] NULL,
	[ACKNOWLEDGE_INTERVAL3] [smallint] NULL,
	[NO_CONNECT_INTERVAL1] [smallint] NULL,
	[NO_CONNECT_INTERVAL2] [smallint] NULL,
	[NO_CONNECT_INTERVAL3] [smallint] NULL,
	[ACKNOWLEDGE_ATTEMPTS1] [smallint] NULL,
	[ACKNOWLEDGE_ATTEMPTS2] [smallint] NULL,
	[ACKNOWLEDGE_ATTEMPTS3] [smallint] NULL,
	[NO_CONNECT_ATTEMPTS1] [smallint] NULL,
	[NO_CONNECT_ATTEMPTS2] [smallint] NULL,
	[NO_CONNECT_ATTEMPTS3] [smallint] NULL,
	[LANGUAGE_NUM] [smallint] NULL,
	[FORWARD_CALLS] [char](1) NULL,
	[FORWARD_CALLS_PHONE] [smallint] NULL,
	[FORWARD_CONTACT_LINK] [int] NULL,
	[ORGANIZATION_LINK] [smallint] NULL,
	[CONTACT_TYPE_LINK] [smallint] NULL,
	[NOTES] [varchar](400) NULL,
	[AVAILABLE] [datetime] NULL,
	[UNAVAILABLE] [datetime] NULL,
	[INTERFACE_PASSWORD] [varbinary](20) NULL,
	[INTERFACE_OBJECTID] [char](10) NULL,
	[INTERFACE_USERID] [char](20) NULL,
	[EMAIL_ADDRESS] [varchar](100) NULL,
	[ID] [varchar](30) NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[VERSION] [int] NOT NULL,
	[UNAVAILABLE_START_DATE_TIME] [datetime] NULL,
	[UNAVAILABLE_END_DATE_TIME] [datetime] NULL)


Insert into #CONTACT1 
Select 
 [NAME]
           ,[PHONE1]
           ,[PHONE2]
           ,[PHONE3]
           ,[PAGER_ID1]
           ,[PAGER_ID2]
           ,[PAGER_ID3]
           ,[PROTOCOL1]
           ,[PROTOCOL2]
           ,[PROTOCOL3]
           ,[CALL_ANALYSIS1]
           ,[CALL_ANALYSIS2]
           ,[CALL_ANALYSIS3]
           ,[DISPATCHER_MENU_OPTIONS]
           ,[DISPATCHER_PASSWORD]
           ,[OBJECT_CATEGORY]
           ,[OBJECT_SELECTION]
           ,[HOURS_DAYS1]
           ,[HOURS_DAYS2]
           ,[HOURS_DAYS3]
           ,[HOURS_DAYS4]
           ,[HOURS_DAYS5]
           ,[HOURS_DAYS6]
           ,[HOURS_DAYS7]
           ,[HOURS_DAYS8]
           ,[HOURS_DAYS9]
           ,[HOURS_DAYS10]
           ,[HOURS_START1]
           ,[HOURS_START2]
           ,[HOURS_START3]
           ,[HOURS_START4]
           ,[HOURS_START5]
           ,[HOURS_START6]
           ,[HOURS_START7]
           ,[HOURS_START8]
           ,[HOURS_START9]
           ,[HOURS_START10]
           ,[HOURS_END1]
           ,[HOURS_END2]
           ,[HOURS_END3]
           ,[HOURS_END4]
           ,[HOURS_END5]
           ,[HOURS_END6]
           ,[HOURS_END7]
           ,[HOURS_END8]
           ,[HOURS_END9]
           ,[HOURS_END10]
           ,[IXO_PASSWORD1]
           ,[IXO_PASSWORD2]
           ,[IXO_PASSWORD3]
           ,[ALIAS_NUM]
           ,[TIME_OFFSET]
           ,[ACKNOWLEDGE_INTERVAL1]
           ,[ACKNOWLEDGE_INTERVAL2]
           ,[ACKNOWLEDGE_INTERVAL3]
           ,[NO_CONNECT_INTERVAL1]
           ,[NO_CONNECT_INTERVAL2]
           ,[NO_CONNECT_INTERVAL3]
           ,[ACKNOWLEDGE_ATTEMPTS1]
           ,[ACKNOWLEDGE_ATTEMPTS2]
           ,[ACKNOWLEDGE_ATTEMPTS3]
           ,[NO_CONNECT_ATTEMPTS1]
           ,[NO_CONNECT_ATTEMPTS2]
           ,[NO_CONNECT_ATTEMPTS3]
           ,[LANGUAGE_NUM]
           ,[FORWARD_CALLS]
           ,[FORWARD_CALLS_PHONE]
           ,[FORWARD_CONTACT_LINK]
           ,[ORGANIZATION_LINK]
           ,[CONTACT_TYPE_LINK]
           ,[NOTES]
           ,[AVAILABLE]
           ,[UNAVAILABLE]
           ,[INTERFACE_PASSWORD]
           ,[INTERFACE_OBJECTID]
           ,[INTERFACE_USERID]
           ,[EMAIL_ADDRESS]
           ,[ID]
           ,[TENANT_ID]
           ,[VERSION]
           ,[UNAVAILABLE_START_DATE_TIME]
           ,[UNAVAILABLE_END_DATE_TIME]
from vision.CONTACT 
where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.CONTACT
(
  [NAME]
           ,[PHONE1]
           ,[PHONE2]
           ,[PHONE3]
           ,[PAGER_ID1]
           ,[PAGER_ID2]
           ,[PAGER_ID3]
           ,[PROTOCOL1]
           ,[PROTOCOL2]
           ,[PROTOCOL3]
           ,[CALL_ANALYSIS1]
           ,[CALL_ANALYSIS2]
           ,[CALL_ANALYSIS3]
           ,[DISPATCHER_MENU_OPTIONS]
           ,[DISPATCHER_PASSWORD]
           ,[OBJECT_CATEGORY]
           ,[OBJECT_SELECTION]
           ,[HOURS_DAYS1]
           ,[HOURS_DAYS2]
           ,[HOURS_DAYS3]
           ,[HOURS_DAYS4]
           ,[HOURS_DAYS5]
           ,[HOURS_DAYS6]
           ,[HOURS_DAYS7]
           ,[HOURS_DAYS8]
           ,[HOURS_DAYS9]
           ,[HOURS_DAYS10]
           ,[HOURS_START1]
           ,[HOURS_START2]
           ,[HOURS_START3]
           ,[HOURS_START4]
           ,[HOURS_START5]
           ,[HOURS_START6]
           ,[HOURS_START7]
           ,[HOURS_START8]
           ,[HOURS_START9]
           ,[HOURS_START10]
           ,[HOURS_END1]
           ,[HOURS_END2]
           ,[HOURS_END3]
           ,[HOURS_END4]
           ,[HOURS_END5]
           ,[HOURS_END6]
           ,[HOURS_END7]
           ,[HOURS_END8]
           ,[HOURS_END9]
           ,[HOURS_END10]
           ,[IXO_PASSWORD1]
           ,[IXO_PASSWORD2]
           ,[IXO_PASSWORD3]
           ,[ALIAS_NUM]
           ,[TIME_OFFSET]
           ,[ACKNOWLEDGE_INTERVAL1]
           ,[ACKNOWLEDGE_INTERVAL2]
           ,[ACKNOWLEDGE_INTERVAL3]
           ,[NO_CONNECT_INTERVAL1]
           ,[NO_CONNECT_INTERVAL2]
           ,[NO_CONNECT_INTERVAL3]
           ,[ACKNOWLEDGE_ATTEMPTS1]
           ,[ACKNOWLEDGE_ATTEMPTS2]
           ,[ACKNOWLEDGE_ATTEMPTS3]
           ,[NO_CONNECT_ATTEMPTS1]
           ,[NO_CONNECT_ATTEMPTS2]
           ,[NO_CONNECT_ATTEMPTS3]
           ,[LANGUAGE_NUM]
           ,[FORWARD_CALLS]
           ,[FORWARD_CALLS_PHONE]
           ,[FORWARD_CONTACT_LINK]
           ,[ORGANIZATION_LINK]
           ,[CONTACT_TYPE_LINK]
           ,[NOTES]
           ,[AVAILABLE]
           ,[UNAVAILABLE]
           ,[INTERFACE_PASSWORD]
           ,[INTERFACE_OBJECTID]
           ,[INTERFACE_USERID]
           ,[EMAIL_ADDRESS]
           ,[ID]
           ,[TENANT_ID]
           ,[VERSION]
           ,[UNAVAILABLE_START_DATE_TIME]
           ,[UNAVAILABLE_END_DATE_TIME])
Select 
 [NAME]
           ,[PHONE1]
           ,[PHONE2]
           ,[PHONE3]
           ,[PAGER_ID1]
           ,[PAGER_ID2]
           ,[PAGER_ID3]
           ,[PROTOCOL1]
           ,[PROTOCOL2]
           ,[PROTOCOL3]
           ,[CALL_ANALYSIS1]
           ,[CALL_ANALYSIS2]
           ,[CALL_ANALYSIS3]
           ,[DISPATCHER_MENU_OPTIONS]
           ,[DISPATCHER_PASSWORD]
           ,[OBJECT_CATEGORY]
           ,[OBJECT_SELECTION]
           ,[HOURS_DAYS1]
           ,[HOURS_DAYS2]
           ,[HOURS_DAYS3]
           ,[HOURS_DAYS4]
           ,[HOURS_DAYS5]
           ,[HOURS_DAYS6]
           ,[HOURS_DAYS7]
           ,[HOURS_DAYS8]
           ,[HOURS_DAYS9]
           ,[HOURS_DAYS10]
           ,[HOURS_START1]
           ,[HOURS_START2]
           ,[HOURS_START3]
           ,[HOURS_START4]
           ,[HOURS_START5]
           ,[HOURS_START6]
           ,[HOURS_START7]
           ,[HOURS_START8]
           ,[HOURS_START9]
           ,[HOURS_START10]
           ,[HOURS_END1]
           ,[HOURS_END2]
           ,[HOURS_END3]
           ,[HOURS_END4]
           ,[HOURS_END5]
           ,[HOURS_END6]
           ,[HOURS_END7]
           ,[HOURS_END8]
           ,[HOURS_END9]
           ,[HOURS_END10]
           ,[IXO_PASSWORD1]
           ,[IXO_PASSWORD2]
           ,[IXO_PASSWORD3]
           ,[ALIAS_NUM]
           ,[TIME_OFFSET]
           ,[ACKNOWLEDGE_INTERVAL1]
           ,[ACKNOWLEDGE_INTERVAL2]
           ,[ACKNOWLEDGE_INTERVAL3]
           ,[NO_CONNECT_INTERVAL1]
           ,[NO_CONNECT_INTERVAL2]
           ,[NO_CONNECT_INTERVAL3]
           ,[ACKNOWLEDGE_ATTEMPTS1]
           ,[ACKNOWLEDGE_ATTEMPTS2]
           ,[ACKNOWLEDGE_ATTEMPTS3]
           ,[NO_CONNECT_ATTEMPTS1]
           ,[NO_CONNECT_ATTEMPTS2]
           ,[NO_CONNECT_ATTEMPTS3]
           ,[LANGUAGE_NUM]
           ,[FORWARD_CALLS]
           ,[FORWARD_CALLS_PHONE]
           ,[FORWARD_CONTACT_LINK]
           ,[ORGANIZATION_LINK]
           ,[CONTACT_TYPE_LINK]
           ,[NOTES]
           ,[AVAILABLE]
           ,[UNAVAILABLE]
           ,[INTERFACE_PASSWORD]
           ,[INTERFACE_OBJECTID]
           ,[INTERFACE_USERID]
           ,[EMAIL_ADDRESS]
           ,[ID]
           ,[TENANT_ID]
           ,[VERSION]
           ,[UNAVAILABLE_START_DATE_TIME]
           ,[UNAVAILABLE_END_DATE_TIME]
from  #CONTACT1

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #CONTACT1 


GO

-- Select * from [VISION].[CONTACT]

-- DBCC CHECKIDENT('vision.CONTACT_Test')

-- DBCC CHECKIDENT('vision.CONTACT_Test',reseed,365)



--      Select 596 * 6661
--      FINAL Total: 3969956


--  DELETE from Vision.CONTACT_test

--  Select count(*) from [VISION].[CONTACT_Test]

--Select * from [VISION].[CONTACT_Test]
--where TENANT_ID =1 