--USE [GLOBAL]
--GO

--/****** Object:  Table [VISION].[GASPER_OBJECT]    Script Date: 8/30/2021 8:13:13 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [VISION].[GASPER_OBJECT_Test](
--	[OBJECT_KEY] [int] IDENTITY(64208,1) NOT NULL,
--	[LINK] [int] NOT NULL,
--	[ID] [varchar](30) NULL,
--	[ALIAS2] [nchar](10) NULL,
--	[ALIAS3] [nvarchar](30) NULL,
--	[ALIAS4] [nchar](10) NULL,
--	[SITE_ID] [char](12) NULL,
--	[SERIAL_NUM] [char](20) NULL,
--	[LOAD_IMAGE] [char](10) NULL,
--	[ADDRESS] [nchar](50) NULL,
--	[ADDRESS2] [nchar](50) NULL,
--	[CITY] [char](20) NULL,
--	[STATE] [char](20) NULL,
--	[ZIP] [char](10) NULL,
--	[FLAG] [smallint] NULL,
--	[PHONE] [char](20) NULL,
--	[STATUS_TABLE_LINK] [numeric](10, 0) NULL,
--	[AREA_LINK] [smallint] NOT NULL,
--	[CLASS_LINK] [smallint] NOT NULL,
--	[DISTRICT_LINK] [smallint] NOT NULL,
--	[DATA_LINE_LINK] [smallint] NOT NULL,
--	[REGION_LINK] [smallint] NOT NULL,
--	[BRANCH_LINK] [smallint] NOT NULL,
--	[INSTITUTION_LINK] [smallint] NOT NULL,
--	[OBJECT_TYPE_LINK] [smallint] NOT NULL,
--	[ZONE_LINK] [smallint] NOT NULL,
--	[IN_SERVICE] [datetime] NULL,
--	[OUT_OF_SERVICE] [datetime] NULL,
--	[EDITOR_NOTE] [char](70) NULL,
--	[TIME_OFFSET] [smallint] NULL,
--	[DOWN_TOO_LONG] [int] NULL,
--	[SCRIPT_LINK] [smallint] NULL,
--	[COMMAND_SCRIPT_LINK] [smallint] NULL,
--	[PRIORITY] [smallint] NULL,
--	[OPERATION_HOUR_DAYS1] [smallint] NULL,
--	[OPERATION_HOUR_DAYS2] [smallint] NULL,
--	[OPERATION_HOUR_DAYS3] [smallint] NULL,
--	[OPERATION_HOUR_DAYS4] [smallint] NULL,
--	[OPERATION_HOUR_DAYS5] [smallint] NULL,
--	[OPERATION_HOUR_DAYS6] [smallint] NULL,
--	[OPERATION_HOUR_DAYS7] [smallint] NULL,
--	[OPERATION_HOUR_DAYS8] [smallint] NULL,
--	[OPERATION_HOUR_DAYS9] [smallint] NULL,
--	[OPERATION_HOUR_DAYS10] [smallint] NULL,
--	[OPERATION_HOUR_START1] [smallint] NULL,
--	[OPERATION_HOUR_START2] [smallint] NULL,
--	[OPERATION_HOUR_START3] [smallint] NULL,
--	[OPERATION_HOUR_START4] [smallint] NULL,
--	[OPERATION_HOUR_START5] [smallint] NULL,
--	[OPERATION_HOUR_START6] [smallint] NULL,
--	[OPERATION_HOUR_START7] [smallint] NULL,
--	[OPERATION_HOUR_START8] [smallint] NULL,
--	[OPERATION_HOUR_START9] [smallint] NULL,
--	[OPERATION_HOUR_START10] [smallint] NULL,
--	[OPERATION_HOUR_END1] [smallint] NULL,
--	[OPERATION_HOUR_END2] [smallint] NULL,
--	[OPERATION_HOUR_END3] [smallint] NULL,
--	[OPERATION_HOUR_END4] [smallint] NULL,
--	[OPERATION_HOUR_END5] [smallint] NULL,
--	[OPERATION_HOUR_END6] [smallint] NULL,
--	[OPERATION_HOUR_END7] [smallint] NULL,
--	[OPERATION_HOUR_END8] [smallint] NULL,
--	[OPERATION_HOUR_END9] [smallint] NULL,
--	[OPERATION_HOUR_END10] [smallint] NULL,
--	[BRANCH_HOUR_DAYS1] [smallint] NULL,
--	[BRANCH_HOUR_DAYS2] [smallint] NULL,
--	[BRANCH_HOUR_DAYS3] [smallint] NULL,
--	[BRANCH_HOUR_DAYS4] [smallint] NULL,
--	[BRANCH_HOUR_DAYS5] [smallint] NULL,
--	[BRANCH_HOUR_DAYS6] [smallint] NULL,
--	[BRANCH_HOUR_DAYS7] [smallint] NULL,
--	[BRANCH_HOUR_DAYS8] [smallint] NULL,
--	[BRANCH_HOUR_DAYS9] [smallint] NULL,
--	[BRANCH_HOUR_DAYS10] [smallint] NULL,
--	[BRANCH_HOUR_START1] [smallint] NULL,
--	[BRANCH_HOUR_START2] [smallint] NULL,
--	[BRANCH_HOUR_START3] [smallint] NULL,
--	[BRANCH_HOUR_START4] [smallint] NULL,
--	[BRANCH_HOUR_START5] [smallint] NULL,
--	[BRANCH_HOUR_START6] [smallint] NULL,
--	[BRANCH_HOUR_START7] [smallint] NULL,
--	[BRANCH_HOUR_START8] [smallint] NULL,
--	[BRANCH_HOUR_START9] [smallint] NULL,
--	[BRANCH_HOUR_START10] [smallint] NULL,
--	[BRANCH_HOUR_END1] [smallint] NULL,
--	[BRANCH_HOUR_END2] [smallint] NULL,
--	[BRANCH_HOUR_END3] [smallint] NULL,
--	[BRANCH_HOUR_END4] [smallint] NULL,
--	[BRANCH_HOUR_END5] [smallint] NULL,
--	[BRANCH_HOUR_END6] [smallint] NULL,
--	[BRANCH_HOUR_END7] [smallint] NULL,
--	[BRANCH_HOUR_END8] [smallint] NULL,
--	[BRANCH_HOUR_END9] [smallint] NULL,
--	[BRANCH_HOUR_END10] [smallint] NULL,
--	[AFTER_HOUR_DAYS1] [smallint] NULL,
--	[AFTER_HOUR_DAYS2] [smallint] NULL,
--	[AFTER_HOUR_DAYS3] [smallint] NULL,
--	[AFTER_HOUR_DAYS4] [smallint] NULL,
--	[AFTER_HOUR_DAYS5] [smallint] NULL,
--	[AFTER_HOUR_DAYS6] [smallint] NULL,
--	[AFTER_HOUR_DAYS7] [smallint] NULL,
--	[AFTER_HOUR_DAYS8] [smallint] NULL,
--	[AFTER_HOUR_DAYS9] [smallint] NULL,
--	[AFTER_HOUR_DAYS10] [smallint] NULL,
--	[OTHER_HOUR_DAYS1] [smallint] NULL,
--	[OTHER_HOUR_DAYS2] [smallint] NULL,
--	[OTHER_HOUR_DAYS3] [smallint] NULL,
--	[OTHER_HOUR_DAYS4] [smallint] NULL,
--	[OTHER_HOUR_DAYS5] [smallint] NULL,
--	[OTHER_HOUR_DAYS6] [smallint] NULL,
--	[OTHER_HOUR_DAYS7] [smallint] NULL,
--	[OTHER_HOUR_DAYS8] [smallint] NULL,
--	[OTHER_HOUR_DAYS9] [smallint] NULL,
--	[OTHER_HOUR_DAYS10] [smallint] NULL,
--	[AFTER_HOUR_START1] [smallint] NULL,
--	[AFTER_HOUR_START2] [smallint] NULL,
--	[AFTER_HOUR_START3] [smallint] NULL,
--	[AFTER_HOUR_START4] [smallint] NULL,
--	[AFTER_HOUR_START5] [smallint] NULL,
--	[AFTER_HOUR_START6] [smallint] NULL,
--	[AFTER_HOUR_START7] [smallint] NULL,
--	[AFTER_HOUR_START8] [smallint] NULL,
--	[AFTER_HOUR_START9] [smallint] NULL,
--	[AFTER_HOUR_START10] [smallint] NULL,
--	[OTHER_HOUR_START1] [smallint] NULL,
--	[OTHER_HOUR_START2] [smallint] NULL,
--	[OTHER_HOUR_START3] [smallint] NULL,
--	[OTHER_HOUR_START4] [smallint] NULL,
--	[OTHER_HOUR_START5] [smallint] NULL,
--	[OTHER_HOUR_START6] [smallint] NULL,
--	[OTHER_HOUR_START7] [smallint] NULL,
--	[OTHER_HOUR_START8] [smallint] NULL,
--	[OTHER_HOUR_START9] [smallint] NULL,
--	[OTHER_HOUR_START10] [smallint] NULL,
--	[AFTER_HOUR_END1] [smallint] NULL,
--	[AFTER_HOUR_END2] [smallint] NULL,
--	[AFTER_HOUR_END3] [smallint] NULL,
--	[AFTER_HOUR_END4] [smallint] NULL,
--	[AFTER_HOUR_END5] [smallint] NULL,
--	[AFTER_HOUR_END6] [smallint] NULL,
--	[AFTER_HOUR_END7] [smallint] NULL,
--	[AFTER_HOUR_END8] [smallint] NULL,
--	[AFTER_HOUR_END9] [smallint] NULL,
--	[AFTER_HOUR_END10] [smallint] NULL,
--	[OTHER_HOUR_END1] [smallint] NULL,
--	[OTHER_HOUR_END2] [smallint] NULL,
--	[OTHER_HOUR_END3] [smallint] NULL,
--	[OTHER_HOUR_END4] [smallint] NULL,
--	[OTHER_HOUR_END5] [smallint] NULL,
--	[OTHER_HOUR_END6] [smallint] NULL,
--	[OTHER_HOUR_END7] [smallint] NULL,
--	[OTHER_HOUR_END8] [smallint] NULL,
--	[OTHER_HOUR_END9] [smallint] NULL,
--	[OTHER_HOUR_END10] [smallint] NULL,
--	[NOTES] [varchar](4000) NULL,
--	[OBJECT_CLASS] [smallint] NULL,
--	[TRAN_THRESHOLD_LINK] [smallint] NULL,
--	[PEAK_HOUR_DAYS1] [smallint] NULL,
--	[PEAK_HOUR_DAYS2] [smallint] NULL,
--	[PEAK_HOUR_DAYS3] [smallint] NULL,
--	[PEAK_HOUR_DAYS4] [smallint] NULL,
--	[PEAK_HOUR_DAYS5] [smallint] NULL,
--	[PEAK_HOUR_DAYS6] [smallint] NULL,
--	[PEAK_HOUR_DAYS7] [smallint] NULL,
--	[PEAK_HOUR_DAYS8] [smallint] NULL,
--	[PEAK_HOUR_DAYS9] [smallint] NULL,
--	[PEAK_HOUR_DAYS10] [smallint] NULL,
--	[PEAK_HOUR_START1] [smallint] NULL,
--	[PEAK_HOUR_START2] [smallint] NULL,
--	[PEAK_HOUR_START3] [smallint] NULL,
--	[PEAK_HOUR_START4] [smallint] NULL,
--	[PEAK_HOUR_START5] [smallint] NULL,
--	[PEAK_HOUR_START6] [smallint] NULL,
--	[PEAK_HOUR_START7] [smallint] NULL,
--	[PEAK_HOUR_START8] [smallint] NULL,
--	[PEAK_HOUR_START9] [smallint] NULL,
--	[PEAK_HOUR_START10] [smallint] NULL,
--	[PEAK_HOUR_END1] [smallint] NULL,
--	[PEAK_HOUR_END2] [smallint] NULL,
--	[PEAK_HOUR_END3] [smallint] NULL,
--	[PEAK_HOUR_END4] [smallint] NULL,
--	[PEAK_HOUR_END5] [smallint] NULL,
--	[PEAK_HOUR_END6] [smallint] NULL,
--	[PEAK_HOUR_END7] [smallint] NULL,
--	[PEAK_HOUR_END8] [smallint] NULL,
--	[PEAK_HOUR_END9] [smallint] NULL,
--	[PEAK_HOUR_END10] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS1] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS2] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS3] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS4] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS5] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS6] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS7] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS8] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS9] [smallint] NULL,
--	[OFFPEAK_HOUR_DAYS10] [smallint] NULL,
--	[OFFPEAK_HOUR_START1] [smallint] NULL,
--	[OFFPEAK_HOUR_START2] [smallint] NULL,
--	[OFFPEAK_HOUR_START3] [smallint] NULL,
--	[OFFPEAK_HOUR_START4] [smallint] NULL,
--	[OFFPEAK_HOUR_START5] [smallint] NULL,
--	[OFFPEAK_HOUR_START6] [smallint] NULL,
--	[OFFPEAK_HOUR_START7] [smallint] NULL,
--	[OFFPEAK_HOUR_START8] [smallint] NULL,
--	[OFFPEAK_HOUR_START9] [smallint] NULL,
--	[OFFPEAK_HOUR_START10] [smallint] NULL,
--	[OFFPEAK_HOUR_END1] [smallint] NULL,
--	[OFFPEAK_HOUR_END2] [smallint] NULL,
--	[OFFPEAK_HOUR_END3] [smallint] NULL,
--	[OFFPEAK_HOUR_END4] [smallint] NULL,
--	[OFFPEAK_HOUR_END5] [smallint] NULL,
--	[OFFPEAK_HOUR_END6] [smallint] NULL,
--	[OFFPEAK_HOUR_END7] [smallint] NULL,
--	[OFFPEAK_HOUR_END8] [smallint] NULL,
--	[OFFPEAK_HOUR_END9] [smallint] NULL,
--	[OFFPEAK_HOUR_END10] [smallint] NULL,
--	[DELDATE] [datetime] NULL,
--	[DELUSER] [varchar](20) NULL,
--	[AGENT_ID] [char](30) NULL,
--	[TRAN_THRESH_HOST_LINK] [smallint] NULL,
--	[IP_ADDRESS] [varchar](16) NULL,
--	[SNMP_VERSION] [smallint] NULL,
--	[COMMUNITY_STRING_LINK] [smallint] NULL,
--	[ENTERPRISE_OID_LINK] [smallint] NULL,
--	[ENCRYPTION_CERT] [smallint] NULL,
--	[FILE_PREFIX] [char](2) NULL,
--	[FILE_PATH] [char](30) NULL,
--	[WEIGHTED_HOURS_LINK] [smallint] NULL,
--	[EXTERNAL_ID] [bigint] NOT NULL,
--	[TENANT_ID] [numeric](19, 0) NOT NULL,
--	[LATITUDE] [float] NULL,
--	[LONGITUDE] [float] NULL,
--	[DNS_NAME] [nvarchar](255) NULL,
--	[CACHE_ADDRESS] [nvarchar](16) NULL,
--	[CASH_THRESHOLD_LINK] [int] NULL,
--	[CASSETTE_ID] [numeric](18, 0) NULL,
--	[UPPERID]  AS (upper(rtrim(ltrim([ID])))),
--	[CASH_CASSETTE_LINK] [smallint] NULL,
--	[VERSION] [int] NOT NULL,
--	[WORKFLOW_ID] [numeric](5, 0) NULL,
--	[row_ver] [timestamp] NOT NULL,
--	[sync_ver] [bigint] NULL,
-- CONSTRAINT [pk_GASPER_OBJECT_test] PRIMARY KEY CLUSTERED 
--(
--	[OBJECT_KEY] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
-- CONSTRAINT [idx_GASPER_OBJECT_LINK_Test] UNIQUE NONCLUSTERED 
--(
--	[LINK] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO


------------------------------------------------------------


DROP Table IF Exists #SecurityT
DROP Table IF Exists #GASPER_OBJECT_Test1

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

Create Table #GASPER_OBJECT_Test1
(
  	[LINK] [int] NOT NULL,
	[ID] [varchar](30) NULL,
	[ALIAS2] [nchar](10) NULL,
	[ALIAS3] [nvarchar](30) NULL,
	[ALIAS4] [nchar](10) NULL,
	[SITE_ID] [char](12) NULL,
	[SERIAL_NUM] [char](20) NULL,
	[LOAD_IMAGE] [char](10) NULL,
	[ADDRESS] [nchar](50) NULL,
	[ADDRESS2] [nchar](50) NULL,
	[CITY] [char](20) NULL,
	[STATE] [char](20) NULL,
	[ZIP] [char](10) NULL,
	[FLAG] [smallint] NULL,
	[PHONE] [char](20) NULL,
	[STATUS_TABLE_LINK] [numeric](10, 0) NULL,
	[AREA_LINK] [smallint] NOT NULL,
	[CLASS_LINK] [smallint] NOT NULL,
	[DISTRICT_LINK] [smallint] NOT NULL,
	[DATA_LINE_LINK] [smallint] NOT NULL,
	[REGION_LINK] [smallint] NOT NULL,
	[BRANCH_LINK] [smallint] NOT NULL,
	[INSTITUTION_LINK] [smallint] NOT NULL,
	[OBJECT_TYPE_LINK] [smallint] NOT NULL,
	[ZONE_LINK] [smallint] NOT NULL,
	[IN_SERVICE] [datetime] NULL,
	[OUT_OF_SERVICE] [datetime] NULL,
	[EDITOR_NOTE] [char](70) NULL,
	[TIME_OFFSET] [smallint] NULL,
	[DOWN_TOO_LONG] [int] NULL,
	[SCRIPT_LINK] [smallint] NULL,
	[COMMAND_SCRIPT_LINK] [smallint] NULL,
	[PRIORITY] [smallint] NULL,
	[OPERATION_HOUR_DAYS1] [smallint] NULL,
	[OPERATION_HOUR_DAYS2] [smallint] NULL,
	[OPERATION_HOUR_DAYS3] [smallint] NULL,
	[OPERATION_HOUR_DAYS4] [smallint] NULL,
	[OPERATION_HOUR_DAYS5] [smallint] NULL,
	[OPERATION_HOUR_DAYS6] [smallint] NULL,
	[OPERATION_HOUR_DAYS7] [smallint] NULL,
	[OPERATION_HOUR_DAYS8] [smallint] NULL,
	[OPERATION_HOUR_DAYS9] [smallint] NULL,
	[OPERATION_HOUR_DAYS10] [smallint] NULL,
	[OPERATION_HOUR_START1] [smallint] NULL,
	[OPERATION_HOUR_START2] [smallint] NULL,
	[OPERATION_HOUR_START3] [smallint] NULL,
	[OPERATION_HOUR_START4] [smallint] NULL,
	[OPERATION_HOUR_START5] [smallint] NULL,
	[OPERATION_HOUR_START6] [smallint] NULL,
	[OPERATION_HOUR_START7] [smallint] NULL,
	[OPERATION_HOUR_START8] [smallint] NULL,
	[OPERATION_HOUR_START9] [smallint] NULL,
	[OPERATION_HOUR_START10] [smallint] NULL,
	[OPERATION_HOUR_END1] [smallint] NULL,
	[OPERATION_HOUR_END2] [smallint] NULL,
	[OPERATION_HOUR_END3] [smallint] NULL,
	[OPERATION_HOUR_END4] [smallint] NULL,
	[OPERATION_HOUR_END5] [smallint] NULL,
	[OPERATION_HOUR_END6] [smallint] NULL,
	[OPERATION_HOUR_END7] [smallint] NULL,
	[OPERATION_HOUR_END8] [smallint] NULL,
	[OPERATION_HOUR_END9] [smallint] NULL,
	[OPERATION_HOUR_END10] [smallint] NULL,
	[BRANCH_HOUR_DAYS1] [smallint] NULL,
	[BRANCH_HOUR_DAYS2] [smallint] NULL,
	[BRANCH_HOUR_DAYS3] [smallint] NULL,
	[BRANCH_HOUR_DAYS4] [smallint] NULL,
	[BRANCH_HOUR_DAYS5] [smallint] NULL,
	[BRANCH_HOUR_DAYS6] [smallint] NULL,
	[BRANCH_HOUR_DAYS7] [smallint] NULL,
	[BRANCH_HOUR_DAYS8] [smallint] NULL,
	[BRANCH_HOUR_DAYS9] [smallint] NULL,
	[BRANCH_HOUR_DAYS10] [smallint] NULL,
	[BRANCH_HOUR_START1] [smallint] NULL,
	[BRANCH_HOUR_START2] [smallint] NULL,
	[BRANCH_HOUR_START3] [smallint] NULL,
	[BRANCH_HOUR_START4] [smallint] NULL,
	[BRANCH_HOUR_START5] [smallint] NULL,
	[BRANCH_HOUR_START6] [smallint] NULL,
	[BRANCH_HOUR_START7] [smallint] NULL,
	[BRANCH_HOUR_START8] [smallint] NULL,
	[BRANCH_HOUR_START9] [smallint] NULL,
	[BRANCH_HOUR_START10] [smallint] NULL,
	[BRANCH_HOUR_END1] [smallint] NULL,
	[BRANCH_HOUR_END2] [smallint] NULL,
	[BRANCH_HOUR_END3] [smallint] NULL,
	[BRANCH_HOUR_END4] [smallint] NULL,
	[BRANCH_HOUR_END5] [smallint] NULL,
	[BRANCH_HOUR_END6] [smallint] NULL,
	[BRANCH_HOUR_END7] [smallint] NULL,
	[BRANCH_HOUR_END8] [smallint] NULL,
	[BRANCH_HOUR_END9] [smallint] NULL,
	[BRANCH_HOUR_END10] [smallint] NULL,
	[AFTER_HOUR_DAYS1] [smallint] NULL,
	[AFTER_HOUR_DAYS2] [smallint] NULL,
	[AFTER_HOUR_DAYS3] [smallint] NULL,
	[AFTER_HOUR_DAYS4] [smallint] NULL,
	[AFTER_HOUR_DAYS5] [smallint] NULL,
	[AFTER_HOUR_DAYS6] [smallint] NULL,
	[AFTER_HOUR_DAYS7] [smallint] NULL,
	[AFTER_HOUR_DAYS8] [smallint] NULL,
	[AFTER_HOUR_DAYS9] [smallint] NULL,
	[AFTER_HOUR_DAYS10] [smallint] NULL,
	[OTHER_HOUR_DAYS1] [smallint] NULL,
	[OTHER_HOUR_DAYS2] [smallint] NULL,
	[OTHER_HOUR_DAYS3] [smallint] NULL,
	[OTHER_HOUR_DAYS4] [smallint] NULL,
	[OTHER_HOUR_DAYS5] [smallint] NULL,
	[OTHER_HOUR_DAYS6] [smallint] NULL,
	[OTHER_HOUR_DAYS7] [smallint] NULL,
	[OTHER_HOUR_DAYS8] [smallint] NULL,
	[OTHER_HOUR_DAYS9] [smallint] NULL,
	[OTHER_HOUR_DAYS10] [smallint] NULL,
	[AFTER_HOUR_START1] [smallint] NULL,
	[AFTER_HOUR_START2] [smallint] NULL,
	[AFTER_HOUR_START3] [smallint] NULL,
	[AFTER_HOUR_START4] [smallint] NULL,
	[AFTER_HOUR_START5] [smallint] NULL,
	[AFTER_HOUR_START6] [smallint] NULL,
	[AFTER_HOUR_START7] [smallint] NULL,
	[AFTER_HOUR_START8] [smallint] NULL,
	[AFTER_HOUR_START9] [smallint] NULL,
	[AFTER_HOUR_START10] [smallint] NULL,
	[OTHER_HOUR_START1] [smallint] NULL,
	[OTHER_HOUR_START2] [smallint] NULL,
	[OTHER_HOUR_START3] [smallint] NULL,
	[OTHER_HOUR_START4] [smallint] NULL,
	[OTHER_HOUR_START5] [smallint] NULL,
	[OTHER_HOUR_START6] [smallint] NULL,
	[OTHER_HOUR_START7] [smallint] NULL,
	[OTHER_HOUR_START8] [smallint] NULL,
	[OTHER_HOUR_START9] [smallint] NULL,
	[OTHER_HOUR_START10] [smallint] NULL,
	[AFTER_HOUR_END1] [smallint] NULL,
	[AFTER_HOUR_END2] [smallint] NULL,
	[AFTER_HOUR_END3] [smallint] NULL,
	[AFTER_HOUR_END4] [smallint] NULL,
	[AFTER_HOUR_END5] [smallint] NULL,
	[AFTER_HOUR_END6] [smallint] NULL,
	[AFTER_HOUR_END7] [smallint] NULL,
	[AFTER_HOUR_END8] [smallint] NULL,
	[AFTER_HOUR_END9] [smallint] NULL,
	[AFTER_HOUR_END10] [smallint] NULL,
	[OTHER_HOUR_END1] [smallint] NULL,
	[OTHER_HOUR_END2] [smallint] NULL,
	[OTHER_HOUR_END3] [smallint] NULL,
	[OTHER_HOUR_END4] [smallint] NULL,
	[OTHER_HOUR_END5] [smallint] NULL,
	[OTHER_HOUR_END6] [smallint] NULL,
	[OTHER_HOUR_END7] [smallint] NULL,
	[OTHER_HOUR_END8] [smallint] NULL,
	[OTHER_HOUR_END9] [smallint] NULL,
	[OTHER_HOUR_END10] [smallint] NULL,
	[NOTES] [varchar](4000) NULL,
	[OBJECT_CLASS] [smallint] NULL,
	[TRAN_THRESHOLD_LINK] [smallint] NULL,
	[PEAK_HOUR_DAYS1] [smallint] NULL,
	[PEAK_HOUR_DAYS2] [smallint] NULL,
	[PEAK_HOUR_DAYS3] [smallint] NULL,
	[PEAK_HOUR_DAYS4] [smallint] NULL,
	[PEAK_HOUR_DAYS5] [smallint] NULL,
	[PEAK_HOUR_DAYS6] [smallint] NULL,
	[PEAK_HOUR_DAYS7] [smallint] NULL,
	[PEAK_HOUR_DAYS8] [smallint] NULL,
	[PEAK_HOUR_DAYS9] [smallint] NULL,
	[PEAK_HOUR_DAYS10] [smallint] NULL,
	[PEAK_HOUR_START1] [smallint] NULL,
	[PEAK_HOUR_START2] [smallint] NULL,
	[PEAK_HOUR_START3] [smallint] NULL,
	[PEAK_HOUR_START4] [smallint] NULL,
	[PEAK_HOUR_START5] [smallint] NULL,
	[PEAK_HOUR_START6] [smallint] NULL,
	[PEAK_HOUR_START7] [smallint] NULL,
	[PEAK_HOUR_START8] [smallint] NULL,
	[PEAK_HOUR_START9] [smallint] NULL,
	[PEAK_HOUR_START10] [smallint] NULL,
	[PEAK_HOUR_END1] [smallint] NULL,
	[PEAK_HOUR_END2] [smallint] NULL,
	[PEAK_HOUR_END3] [smallint] NULL,
	[PEAK_HOUR_END4] [smallint] NULL,
	[PEAK_HOUR_END5] [smallint] NULL,
	[PEAK_HOUR_END6] [smallint] NULL,
	[PEAK_HOUR_END7] [smallint] NULL,
	[PEAK_HOUR_END8] [smallint] NULL,
	[PEAK_HOUR_END9] [smallint] NULL,
	[PEAK_HOUR_END10] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS1] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS2] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS3] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS4] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS5] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS6] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS7] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS8] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS9] [smallint] NULL,
	[OFFPEAK_HOUR_DAYS10] [smallint] NULL,
	[OFFPEAK_HOUR_START1] [smallint] NULL,
	[OFFPEAK_HOUR_START2] [smallint] NULL,
	[OFFPEAK_HOUR_START3] [smallint] NULL,
	[OFFPEAK_HOUR_START4] [smallint] NULL,
	[OFFPEAK_HOUR_START5] [smallint] NULL,
	[OFFPEAK_HOUR_START6] [smallint] NULL,
	[OFFPEAK_HOUR_START7] [smallint] NULL,
	[OFFPEAK_HOUR_START8] [smallint] NULL,
	[OFFPEAK_HOUR_START9] [smallint] NULL,
	[OFFPEAK_HOUR_START10] [smallint] NULL,
	[OFFPEAK_HOUR_END1] [smallint] NULL,
	[OFFPEAK_HOUR_END2] [smallint] NULL,
	[OFFPEAK_HOUR_END3] [smallint] NULL,
	[OFFPEAK_HOUR_END4] [smallint] NULL,
	[OFFPEAK_HOUR_END5] [smallint] NULL,
	[OFFPEAK_HOUR_END6] [smallint] NULL,
	[OFFPEAK_HOUR_END7] [smallint] NULL,
	[OFFPEAK_HOUR_END8] [smallint] NULL,
	[OFFPEAK_HOUR_END9] [smallint] NULL,
	[OFFPEAK_HOUR_END10] [smallint] NULL,
	[DELDATE] [datetime] NULL,
	[DELUSER] [varchar](20) NULL,
	[AGENT_ID] [char](30) NULL,
	[TRAN_THRESH_HOST_LINK] [smallint] NULL,
	[IP_ADDRESS] [varchar](16) NULL,
	[SNMP_VERSION] [smallint] NULL,
	[COMMUNITY_STRING_LINK] [smallint] NULL,
	[ENTERPRISE_OID_LINK] [smallint] NULL,
	[ENCRYPTION_CERT] [smallint] NULL,
	[FILE_PREFIX] [char](2) NULL,
	[FILE_PATH] [char](30) NULL,
	[WEIGHTED_HOURS_LINK] [smallint] NULL,
	[EXTERNAL_ID] [bigint] NOT NULL,
	[TENANT_ID] [numeric](19, 0) NOT NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[DNS_NAME] [nvarchar](255) NULL,
	[CACHE_ADDRESS] [nvarchar](16) NULL,
	[CASH_THRESHOLD_LINK] [int] NULL,
	[CASSETTE_ID] [numeric](18, 0) NULL,
	[UPPERID]  AS (upper(rtrim(ltrim([ID])))),
	[CASH_CASSETTE_LINK] [smallint] NULL,
	[VERSION] [int] NOT NULL,
	[WORKFLOW_ID] [numeric](5, 0) NULL,
	[row_ver] [timestamp] NOT NULL,
	[sync_ver] [bigint] NULL 	
	
	
	
	
	)


Insert into #GASPER_OBJECT_Test1 
(           
		   [LINK]
           ,[ID]
           ,[ALIAS2]
           ,[ALIAS3]
           ,[ALIAS4]
           ,[SITE_ID]
           ,[SERIAL_NUM]
           ,[LOAD_IMAGE]
           ,[ADDRESS]
           ,[ADDRESS2]
           ,[CITY]
           ,[STATE]
           ,[ZIP]
           ,[FLAG]
           ,[PHONE]
           ,[STATUS_TABLE_LINK]
           ,[AREA_LINK]
           ,[CLASS_LINK]
           ,[DISTRICT_LINK]
           ,[DATA_LINE_LINK]
           ,[REGION_LINK]
           ,[BRANCH_LINK]
           ,[INSTITUTION_LINK]
           ,[OBJECT_TYPE_LINK]
           ,[ZONE_LINK]
           ,[IN_SERVICE]
           ,[OUT_OF_SERVICE]
           ,[EDITOR_NOTE]
           ,[TIME_OFFSET]
           ,[DOWN_TOO_LONG]
           ,[SCRIPT_LINK]
           ,[COMMAND_SCRIPT_LINK]
           ,[PRIORITY]
           ,[OPERATION_HOUR_DAYS1]
           ,[OPERATION_HOUR_DAYS2]
           ,[OPERATION_HOUR_DAYS3]
           ,[OPERATION_HOUR_DAYS4]
           ,[OPERATION_HOUR_DAYS5]
           ,[OPERATION_HOUR_DAYS6]
           ,[OPERATION_HOUR_DAYS7]
           ,[OPERATION_HOUR_DAYS8]
           ,[OPERATION_HOUR_DAYS9]
           ,[OPERATION_HOUR_DAYS10]
           ,[OPERATION_HOUR_START1]
           ,[OPERATION_HOUR_START2]
           ,[OPERATION_HOUR_START3]
           ,[OPERATION_HOUR_START4]
           ,[OPERATION_HOUR_START5]
           ,[OPERATION_HOUR_START6]
           ,[OPERATION_HOUR_START7]
           ,[OPERATION_HOUR_START8]
           ,[OPERATION_HOUR_START9]
           ,[OPERATION_HOUR_START10]
           ,[OPERATION_HOUR_END1]
           ,[OPERATION_HOUR_END2]
           ,[OPERATION_HOUR_END3]
           ,[OPERATION_HOUR_END4]
           ,[OPERATION_HOUR_END5]
           ,[OPERATION_HOUR_END6]
           ,[OPERATION_HOUR_END7]
           ,[OPERATION_HOUR_END8]
           ,[OPERATION_HOUR_END9]
           ,[OPERATION_HOUR_END10]
           ,[BRANCH_HOUR_DAYS1]
           ,[BRANCH_HOUR_DAYS2]
           ,[BRANCH_HOUR_DAYS3]
           ,[BRANCH_HOUR_DAYS4]
           ,[BRANCH_HOUR_DAYS5]
           ,[BRANCH_HOUR_DAYS6]
           ,[BRANCH_HOUR_DAYS7]
           ,[BRANCH_HOUR_DAYS8]
           ,[BRANCH_HOUR_DAYS9]
           ,[BRANCH_HOUR_DAYS10]
           ,[BRANCH_HOUR_START1]
           ,[BRANCH_HOUR_START2]
           ,[BRANCH_HOUR_START3]
           ,[BRANCH_HOUR_START4]
           ,[BRANCH_HOUR_START5]
           ,[BRANCH_HOUR_START6]
           ,[BRANCH_HOUR_START7]
           ,[BRANCH_HOUR_START8]
           ,[BRANCH_HOUR_START9]
           ,[BRANCH_HOUR_START10]
           ,[BRANCH_HOUR_END1]
           ,[BRANCH_HOUR_END2]
           ,[BRANCH_HOUR_END3]
           ,[BRANCH_HOUR_END4]
           ,[BRANCH_HOUR_END5]
           ,[BRANCH_HOUR_END6]
           ,[BRANCH_HOUR_END7]
           ,[BRANCH_HOUR_END8]
           ,[BRANCH_HOUR_END9]
           ,[BRANCH_HOUR_END10]
           ,[AFTER_HOUR_DAYS1]
           ,[AFTER_HOUR_DAYS2]
           ,[AFTER_HOUR_DAYS3]
           ,[AFTER_HOUR_DAYS4]
           ,[AFTER_HOUR_DAYS5]
           ,[AFTER_HOUR_DAYS6]
           ,[AFTER_HOUR_DAYS7]
           ,[AFTER_HOUR_DAYS8]
           ,[AFTER_HOUR_DAYS9]
           ,[AFTER_HOUR_DAYS10]
           ,[OTHER_HOUR_DAYS1]
           ,[OTHER_HOUR_DAYS2]
           ,[OTHER_HOUR_DAYS3]
           ,[OTHER_HOUR_DAYS4]
           ,[OTHER_HOUR_DAYS5]
           ,[OTHER_HOUR_DAYS6]
           ,[OTHER_HOUR_DAYS7]
           ,[OTHER_HOUR_DAYS8]
           ,[OTHER_HOUR_DAYS9]
           ,[OTHER_HOUR_DAYS10]
           ,[AFTER_HOUR_START1]
           ,[AFTER_HOUR_START2]
           ,[AFTER_HOUR_START3]
           ,[AFTER_HOUR_START4]
           ,[AFTER_HOUR_START5]
           ,[AFTER_HOUR_START6]
           ,[AFTER_HOUR_START7]
           ,[AFTER_HOUR_START8]
           ,[AFTER_HOUR_START9]
           ,[AFTER_HOUR_START10]
           ,[OTHER_HOUR_START1]
           ,[OTHER_HOUR_START2]
           ,[OTHER_HOUR_START3]
           ,[OTHER_HOUR_START4]
           ,[OTHER_HOUR_START5]
           ,[OTHER_HOUR_START6]
           ,[OTHER_HOUR_START7]
           ,[OTHER_HOUR_START8]
           ,[OTHER_HOUR_START9]
           ,[OTHER_HOUR_START10]
           ,[AFTER_HOUR_END1]
           ,[AFTER_HOUR_END2]
           ,[AFTER_HOUR_END3]
           ,[AFTER_HOUR_END4]
           ,[AFTER_HOUR_END5]
           ,[AFTER_HOUR_END6]
           ,[AFTER_HOUR_END7]
           ,[AFTER_HOUR_END8]
           ,[AFTER_HOUR_END9]
           ,[AFTER_HOUR_END10]
           ,[OTHER_HOUR_END1]
           ,[OTHER_HOUR_END2]
           ,[OTHER_HOUR_END3]
           ,[OTHER_HOUR_END4]
           ,[OTHER_HOUR_END5]
           ,[OTHER_HOUR_END6]
           ,[OTHER_HOUR_END7]
           ,[OTHER_HOUR_END8]
           ,[OTHER_HOUR_END9]
           ,[OTHER_HOUR_END10]
           ,[NOTES]
           ,[OBJECT_CLASS]
           ,[TRAN_THRESHOLD_LINK]
           ,[PEAK_HOUR_DAYS1]
           ,[PEAK_HOUR_DAYS2]
           ,[PEAK_HOUR_DAYS3]
           ,[PEAK_HOUR_DAYS4]
           ,[PEAK_HOUR_DAYS5]
           ,[PEAK_HOUR_DAYS6]
           ,[PEAK_HOUR_DAYS7]
           ,[PEAK_HOUR_DAYS8]
           ,[PEAK_HOUR_DAYS9]
           ,[PEAK_HOUR_DAYS10]
           ,[PEAK_HOUR_START1]
           ,[PEAK_HOUR_START2]
           ,[PEAK_HOUR_START3]
           ,[PEAK_HOUR_START4]
           ,[PEAK_HOUR_START5]
           ,[PEAK_HOUR_START6]
           ,[PEAK_HOUR_START7]
           ,[PEAK_HOUR_START8]
           ,[PEAK_HOUR_START9]
           ,[PEAK_HOUR_START10]
           ,[PEAK_HOUR_END1]
           ,[PEAK_HOUR_END2]
           ,[PEAK_HOUR_END3]
           ,[PEAK_HOUR_END4]
           ,[PEAK_HOUR_END5]
           ,[PEAK_HOUR_END6]
           ,[PEAK_HOUR_END7]
           ,[PEAK_HOUR_END8]
           ,[PEAK_HOUR_END9]
           ,[PEAK_HOUR_END10]
           ,[OFFPEAK_HOUR_DAYS1]
           ,[OFFPEAK_HOUR_DAYS2]
           ,[OFFPEAK_HOUR_DAYS3]
           ,[OFFPEAK_HOUR_DAYS4]
           ,[OFFPEAK_HOUR_DAYS5]
           ,[OFFPEAK_HOUR_DAYS6]
           ,[OFFPEAK_HOUR_DAYS7]
           ,[OFFPEAK_HOUR_DAYS8]
           ,[OFFPEAK_HOUR_DAYS9]
           ,[OFFPEAK_HOUR_DAYS10]
           ,[OFFPEAK_HOUR_START1]
           ,[OFFPEAK_HOUR_START2]
           ,[OFFPEAK_HOUR_START3]
           ,[OFFPEAK_HOUR_START4]
           ,[OFFPEAK_HOUR_START5]
           ,[OFFPEAK_HOUR_START6]
           ,[OFFPEAK_HOUR_START7]
           ,[OFFPEAK_HOUR_START8]
           ,[OFFPEAK_HOUR_START9]
           ,[OFFPEAK_HOUR_START10]
           ,[OFFPEAK_HOUR_END1]
           ,[OFFPEAK_HOUR_END2]
           ,[OFFPEAK_HOUR_END3]
           ,[OFFPEAK_HOUR_END4]
           ,[OFFPEAK_HOUR_END5]
           ,[OFFPEAK_HOUR_END6]
           ,[OFFPEAK_HOUR_END7]
           ,[OFFPEAK_HOUR_END8]
           ,[OFFPEAK_HOUR_END9]
           ,[OFFPEAK_HOUR_END10]
           ,[DELDATE]
           ,[DELUSER]
           ,[AGENT_ID]
           ,[TRAN_THRESH_HOST_LINK]
           ,[IP_ADDRESS]
           ,[SNMP_VERSION]
           ,[COMMUNITY_STRING_LINK]
           ,[ENTERPRISE_OID_LINK]
           ,[ENCRYPTION_CERT]
           ,[FILE_PREFIX]
           ,[FILE_PATH]
           ,[WEIGHTED_HOURS_LINK]
           ,[EXTERNAL_ID]
           ,[TENANT_ID]
           ,[LATITUDE]
           ,[LONGITUDE]
           ,[DNS_NAME]
           ,[CACHE_ADDRESS]
           ,[CASH_THRESHOLD_LINK]
           ,[CASSETTE_ID]
           ,[CASH_CASSETTE_LINK]
           ,[VERSION]
           ,[WORKFLOW_ID]
           ,[sync_ver]
		
		    )
Select 

          
		   [LINK]
           ,[ID]
           ,[ALIAS2]
           ,[ALIAS3]
           ,[ALIAS4]
           ,[SITE_ID]
           ,[SERIAL_NUM]
           ,[LOAD_IMAGE]
           ,[ADDRESS]
           ,[ADDRESS2]
           ,[CITY]
           ,[STATE]
           ,[ZIP]
           ,[FLAG]
           ,[PHONE]
           ,[STATUS_TABLE_LINK]
           ,[AREA_LINK]
           ,[CLASS_LINK]
           ,[DISTRICT_LINK]
           ,[DATA_LINE_LINK]
           ,[REGION_LINK]
           ,[BRANCH_LINK]
           ,[INSTITUTION_LINK]
           ,[OBJECT_TYPE_LINK]
           ,[ZONE_LINK]
           ,[IN_SERVICE]
           ,[OUT_OF_SERVICE]
           ,[EDITOR_NOTE]
           ,[TIME_OFFSET]
           ,[DOWN_TOO_LONG]
           ,[SCRIPT_LINK]
           ,[COMMAND_SCRIPT_LINK]
           ,[PRIORITY]
           ,[OPERATION_HOUR_DAYS1]
           ,[OPERATION_HOUR_DAYS2]
           ,[OPERATION_HOUR_DAYS3]
           ,[OPERATION_HOUR_DAYS4]
           ,[OPERATION_HOUR_DAYS5]
           ,[OPERATION_HOUR_DAYS6]
           ,[OPERATION_HOUR_DAYS7]
           ,[OPERATION_HOUR_DAYS8]
           ,[OPERATION_HOUR_DAYS9]
           ,[OPERATION_HOUR_DAYS10]
           ,[OPERATION_HOUR_START1]
           ,[OPERATION_HOUR_START2]
           ,[OPERATION_HOUR_START3]
           ,[OPERATION_HOUR_START4]
           ,[OPERATION_HOUR_START5]
           ,[OPERATION_HOUR_START6]
           ,[OPERATION_HOUR_START7]
           ,[OPERATION_HOUR_START8]
           ,[OPERATION_HOUR_START9]
           ,[OPERATION_HOUR_START10]
           ,[OPERATION_HOUR_END1]
           ,[OPERATION_HOUR_END2]
           ,[OPERATION_HOUR_END3]
           ,[OPERATION_HOUR_END4]
           ,[OPERATION_HOUR_END5]
           ,[OPERATION_HOUR_END6]
           ,[OPERATION_HOUR_END7]
           ,[OPERATION_HOUR_END8]
           ,[OPERATION_HOUR_END9]
           ,[OPERATION_HOUR_END10]
           ,[BRANCH_HOUR_DAYS1]
           ,[BRANCH_HOUR_DAYS2]
           ,[BRANCH_HOUR_DAYS3]
           ,[BRANCH_HOUR_DAYS4]
           ,[BRANCH_HOUR_DAYS5]
           ,[BRANCH_HOUR_DAYS6]
           ,[BRANCH_HOUR_DAYS7]
           ,[BRANCH_HOUR_DAYS8]
           ,[BRANCH_HOUR_DAYS9]
           ,[BRANCH_HOUR_DAYS10]
           ,[BRANCH_HOUR_START1]
           ,[BRANCH_HOUR_START2]
           ,[BRANCH_HOUR_START3]
           ,[BRANCH_HOUR_START4]
           ,[BRANCH_HOUR_START5]
           ,[BRANCH_HOUR_START6]
           ,[BRANCH_HOUR_START7]
           ,[BRANCH_HOUR_START8]
           ,[BRANCH_HOUR_START9]
           ,[BRANCH_HOUR_START10]
           ,[BRANCH_HOUR_END1]
           ,[BRANCH_HOUR_END2]
           ,[BRANCH_HOUR_END3]
           ,[BRANCH_HOUR_END4]
           ,[BRANCH_HOUR_END5]
           ,[BRANCH_HOUR_END6]
           ,[BRANCH_HOUR_END7]
           ,[BRANCH_HOUR_END8]
           ,[BRANCH_HOUR_END9]
           ,[BRANCH_HOUR_END10]
           ,[AFTER_HOUR_DAYS1]
           ,[AFTER_HOUR_DAYS2]
           ,[AFTER_HOUR_DAYS3]
           ,[AFTER_HOUR_DAYS4]
           ,[AFTER_HOUR_DAYS5]
           ,[AFTER_HOUR_DAYS6]
           ,[AFTER_HOUR_DAYS7]
           ,[AFTER_HOUR_DAYS8]
           ,[AFTER_HOUR_DAYS9]
           ,[AFTER_HOUR_DAYS10]
           ,[OTHER_HOUR_DAYS1]
           ,[OTHER_HOUR_DAYS2]
           ,[OTHER_HOUR_DAYS3]
           ,[OTHER_HOUR_DAYS4]
           ,[OTHER_HOUR_DAYS5]
           ,[OTHER_HOUR_DAYS6]
           ,[OTHER_HOUR_DAYS7]
           ,[OTHER_HOUR_DAYS8]
           ,[OTHER_HOUR_DAYS9]
           ,[OTHER_HOUR_DAYS10]
           ,[AFTER_HOUR_START1]
           ,[AFTER_HOUR_START2]
           ,[AFTER_HOUR_START3]
           ,[AFTER_HOUR_START4]
           ,[AFTER_HOUR_START5]
           ,[AFTER_HOUR_START6]
           ,[AFTER_HOUR_START7]
           ,[AFTER_HOUR_START8]
           ,[AFTER_HOUR_START9]
           ,[AFTER_HOUR_START10]
           ,[OTHER_HOUR_START1]
           ,[OTHER_HOUR_START2]
           ,[OTHER_HOUR_START3]
           ,[OTHER_HOUR_START4]
           ,[OTHER_HOUR_START5]
           ,[OTHER_HOUR_START6]
           ,[OTHER_HOUR_START7]
           ,[OTHER_HOUR_START8]
           ,[OTHER_HOUR_START9]
           ,[OTHER_HOUR_START10]
           ,[AFTER_HOUR_END1]
           ,[AFTER_HOUR_END2]
           ,[AFTER_HOUR_END3]
           ,[AFTER_HOUR_END4]
           ,[AFTER_HOUR_END5]
           ,[AFTER_HOUR_END6]
           ,[AFTER_HOUR_END7]
           ,[AFTER_HOUR_END8]
           ,[AFTER_HOUR_END9]
           ,[AFTER_HOUR_END10]
           ,[OTHER_HOUR_END1]
           ,[OTHER_HOUR_END2]
           ,[OTHER_HOUR_END3]
           ,[OTHER_HOUR_END4]
           ,[OTHER_HOUR_END5]
           ,[OTHER_HOUR_END6]
           ,[OTHER_HOUR_END7]
           ,[OTHER_HOUR_END8]
           ,[OTHER_HOUR_END9]
           ,[OTHER_HOUR_END10]
           ,[NOTES]
           ,[OBJECT_CLASS]
           ,[TRAN_THRESHOLD_LINK]
           ,[PEAK_HOUR_DAYS1]
           ,[PEAK_HOUR_DAYS2]
           ,[PEAK_HOUR_DAYS3]
           ,[PEAK_HOUR_DAYS4]
           ,[PEAK_HOUR_DAYS5]
           ,[PEAK_HOUR_DAYS6]
           ,[PEAK_HOUR_DAYS7]
           ,[PEAK_HOUR_DAYS8]
           ,[PEAK_HOUR_DAYS9]
           ,[PEAK_HOUR_DAYS10]
           ,[PEAK_HOUR_START1]
           ,[PEAK_HOUR_START2]
           ,[PEAK_HOUR_START3]
           ,[PEAK_HOUR_START4]
           ,[PEAK_HOUR_START5]
           ,[PEAK_HOUR_START6]
           ,[PEAK_HOUR_START7]
           ,[PEAK_HOUR_START8]
           ,[PEAK_HOUR_START9]
           ,[PEAK_HOUR_START10]
           ,[PEAK_HOUR_END1]
           ,[PEAK_HOUR_END2]
           ,[PEAK_HOUR_END3]
           ,[PEAK_HOUR_END4]
           ,[PEAK_HOUR_END5]
           ,[PEAK_HOUR_END6]
           ,[PEAK_HOUR_END7]
           ,[PEAK_HOUR_END8]
           ,[PEAK_HOUR_END9]
           ,[PEAK_HOUR_END10]
           ,[OFFPEAK_HOUR_DAYS1]
           ,[OFFPEAK_HOUR_DAYS2]
           ,[OFFPEAK_HOUR_DAYS3]
           ,[OFFPEAK_HOUR_DAYS4]
           ,[OFFPEAK_HOUR_DAYS5]
           ,[OFFPEAK_HOUR_DAYS6]
           ,[OFFPEAK_HOUR_DAYS7]
           ,[OFFPEAK_HOUR_DAYS8]
           ,[OFFPEAK_HOUR_DAYS9]
           ,[OFFPEAK_HOUR_DAYS10]
           ,[OFFPEAK_HOUR_START1]
           ,[OFFPEAK_HOUR_START2]
           ,[OFFPEAK_HOUR_START3]
           ,[OFFPEAK_HOUR_START4]
           ,[OFFPEAK_HOUR_START5]
           ,[OFFPEAK_HOUR_START6]
           ,[OFFPEAK_HOUR_START7]
           ,[OFFPEAK_HOUR_START8]
           ,[OFFPEAK_HOUR_START9]
           ,[OFFPEAK_HOUR_START10]
           ,[OFFPEAK_HOUR_END1]
           ,[OFFPEAK_HOUR_END2]
           ,[OFFPEAK_HOUR_END3]
           ,[OFFPEAK_HOUR_END4]
           ,[OFFPEAK_HOUR_END5]
           ,[OFFPEAK_HOUR_END6]
           ,[OFFPEAK_HOUR_END7]
           ,[OFFPEAK_HOUR_END8]
           ,[OFFPEAK_HOUR_END9]
           ,[OFFPEAK_HOUR_END10]
           ,[DELDATE]
           ,[DELUSER]
           ,[AGENT_ID]
           ,[TRAN_THRESH_HOST_LINK]
           ,[IP_ADDRESS]
           ,[SNMP_VERSION]
           ,[COMMUNITY_STRING_LINK]
           ,[ENTERPRISE_OID_LINK]
           ,[ENCRYPTION_CERT]
           ,[FILE_PREFIX]
           ,[FILE_PATH]
           ,[WEIGHTED_HOURS_LINK]
           ,[EXTERNAL_ID]
           ,[TENANT_ID]
           ,[LATITUDE]
           ,[LONGITUDE]
           ,[DNS_NAME]
           ,[CACHE_ADDRESS]
           ,[CASH_THRESHOLD_LINK]
           ,[CASSETTE_ID]
           ,[CASH_CASSETTE_LINK]
           ,[VERSION]
           ,[WORKFLOW_ID]
           ,[sync_ver]
		from vision.GASPER_OBJECT 
		where Tenant_id = 0
--where deleted = 'N';  --- EDIT this to Y or N based on Carissa Confirmation


WHILE @RowCount <= @NumberRecords

BEGIN
SELECT
@ID = ID
FROM #SecurityT
WHERE RowID = @RowCount


Insert into Vision.GASPER_OBJECT
(
 		 
		   [LINK]
           ,[ID]
           ,[ALIAS2]
           ,[ALIAS3]
           ,[ALIAS4]
           ,[SITE_ID]
           ,[SERIAL_NUM]
           ,[LOAD_IMAGE]
           ,[ADDRESS]
           ,[ADDRESS2]
           ,[CITY]
           ,[STATE]
           ,[ZIP]
           ,[FLAG]
           ,[PHONE]
           ,[STATUS_TABLE_LINK]
           ,[AREA_LINK]
           ,[CLASS_LINK]
           ,[DISTRICT_LINK]
           ,[DATA_LINE_LINK]
           ,[REGION_LINK]
           ,[BRANCH_LINK]
           ,[INSTITUTION_LINK]
           ,[OBJECT_TYPE_LINK]
           ,[ZONE_LINK]
           ,[IN_SERVICE]
           ,[OUT_OF_SERVICE]
           ,[EDITOR_NOTE]
           ,[TIME_OFFSET]
           ,[DOWN_TOO_LONG]
           ,[SCRIPT_LINK]
           ,[COMMAND_SCRIPT_LINK]
           ,[PRIORITY]
           ,[OPERATION_HOUR_DAYS1]
           ,[OPERATION_HOUR_DAYS2]
           ,[OPERATION_HOUR_DAYS3]
           ,[OPERATION_HOUR_DAYS4]
           ,[OPERATION_HOUR_DAYS5]
           ,[OPERATION_HOUR_DAYS6]
           ,[OPERATION_HOUR_DAYS7]
           ,[OPERATION_HOUR_DAYS8]
           ,[OPERATION_HOUR_DAYS9]
           ,[OPERATION_HOUR_DAYS10]
           ,[OPERATION_HOUR_START1]
           ,[OPERATION_HOUR_START2]
           ,[OPERATION_HOUR_START3]
           ,[OPERATION_HOUR_START4]
           ,[OPERATION_HOUR_START5]
           ,[OPERATION_HOUR_START6]
           ,[OPERATION_HOUR_START7]
           ,[OPERATION_HOUR_START8]
           ,[OPERATION_HOUR_START9]
           ,[OPERATION_HOUR_START10]
           ,[OPERATION_HOUR_END1]
           ,[OPERATION_HOUR_END2]
           ,[OPERATION_HOUR_END3]
           ,[OPERATION_HOUR_END4]
           ,[OPERATION_HOUR_END5]
           ,[OPERATION_HOUR_END6]
           ,[OPERATION_HOUR_END7]
           ,[OPERATION_HOUR_END8]
           ,[OPERATION_HOUR_END9]
           ,[OPERATION_HOUR_END10]
           ,[BRANCH_HOUR_DAYS1]
           ,[BRANCH_HOUR_DAYS2]
           ,[BRANCH_HOUR_DAYS3]
           ,[BRANCH_HOUR_DAYS4]
           ,[BRANCH_HOUR_DAYS5]
           ,[BRANCH_HOUR_DAYS6]
           ,[BRANCH_HOUR_DAYS7]
           ,[BRANCH_HOUR_DAYS8]
           ,[BRANCH_HOUR_DAYS9]
           ,[BRANCH_HOUR_DAYS10]
           ,[BRANCH_HOUR_START1]
           ,[BRANCH_HOUR_START2]
           ,[BRANCH_HOUR_START3]
           ,[BRANCH_HOUR_START4]
           ,[BRANCH_HOUR_START5]
           ,[BRANCH_HOUR_START6]
           ,[BRANCH_HOUR_START7]
           ,[BRANCH_HOUR_START8]
           ,[BRANCH_HOUR_START9]
           ,[BRANCH_HOUR_START10]
           ,[BRANCH_HOUR_END1]
           ,[BRANCH_HOUR_END2]
           ,[BRANCH_HOUR_END3]
           ,[BRANCH_HOUR_END4]
           ,[BRANCH_HOUR_END5]
           ,[BRANCH_HOUR_END6]
           ,[BRANCH_HOUR_END7]
           ,[BRANCH_HOUR_END8]
           ,[BRANCH_HOUR_END9]
           ,[BRANCH_HOUR_END10]
           ,[AFTER_HOUR_DAYS1]
           ,[AFTER_HOUR_DAYS2]
           ,[AFTER_HOUR_DAYS3]
           ,[AFTER_HOUR_DAYS4]
           ,[AFTER_HOUR_DAYS5]
           ,[AFTER_HOUR_DAYS6]
           ,[AFTER_HOUR_DAYS7]
           ,[AFTER_HOUR_DAYS8]
           ,[AFTER_HOUR_DAYS9]
           ,[AFTER_HOUR_DAYS10]
           ,[OTHER_HOUR_DAYS1]
           ,[OTHER_HOUR_DAYS2]
           ,[OTHER_HOUR_DAYS3]
           ,[OTHER_HOUR_DAYS4]
           ,[OTHER_HOUR_DAYS5]
           ,[OTHER_HOUR_DAYS6]
           ,[OTHER_HOUR_DAYS7]
           ,[OTHER_HOUR_DAYS8]
           ,[OTHER_HOUR_DAYS9]
           ,[OTHER_HOUR_DAYS10]
           ,[AFTER_HOUR_START1]
           ,[AFTER_HOUR_START2]
           ,[AFTER_HOUR_START3]
           ,[AFTER_HOUR_START4]
           ,[AFTER_HOUR_START5]
           ,[AFTER_HOUR_START6]
           ,[AFTER_HOUR_START7]
           ,[AFTER_HOUR_START8]
           ,[AFTER_HOUR_START9]
           ,[AFTER_HOUR_START10]
           ,[OTHER_HOUR_START1]
           ,[OTHER_HOUR_START2]
           ,[OTHER_HOUR_START3]
           ,[OTHER_HOUR_START4]
           ,[OTHER_HOUR_START5]
           ,[OTHER_HOUR_START6]
           ,[OTHER_HOUR_START7]
           ,[OTHER_HOUR_START8]
           ,[OTHER_HOUR_START9]
           ,[OTHER_HOUR_START10]
           ,[AFTER_HOUR_END1]
           ,[AFTER_HOUR_END2]
           ,[AFTER_HOUR_END3]
           ,[AFTER_HOUR_END4]
           ,[AFTER_HOUR_END5]
           ,[AFTER_HOUR_END6]
           ,[AFTER_HOUR_END7]
           ,[AFTER_HOUR_END8]
           ,[AFTER_HOUR_END9]
           ,[AFTER_HOUR_END10]
           ,[OTHER_HOUR_END1]
           ,[OTHER_HOUR_END2]
           ,[OTHER_HOUR_END3]
           ,[OTHER_HOUR_END4]
           ,[OTHER_HOUR_END5]
           ,[OTHER_HOUR_END6]
           ,[OTHER_HOUR_END7]
           ,[OTHER_HOUR_END8]
           ,[OTHER_HOUR_END9]
           ,[OTHER_HOUR_END10]
           ,[NOTES]
           ,[OBJECT_CLASS]
           ,[TRAN_THRESHOLD_LINK]
           ,[PEAK_HOUR_DAYS1]
           ,[PEAK_HOUR_DAYS2]
           ,[PEAK_HOUR_DAYS3]
           ,[PEAK_HOUR_DAYS4]
           ,[PEAK_HOUR_DAYS5]
           ,[PEAK_HOUR_DAYS6]
           ,[PEAK_HOUR_DAYS7]
           ,[PEAK_HOUR_DAYS8]
           ,[PEAK_HOUR_DAYS9]
           ,[PEAK_HOUR_DAYS10]
           ,[PEAK_HOUR_START1]
           ,[PEAK_HOUR_START2]
           ,[PEAK_HOUR_START3]
           ,[PEAK_HOUR_START4]
           ,[PEAK_HOUR_START5]
           ,[PEAK_HOUR_START6]
           ,[PEAK_HOUR_START7]
           ,[PEAK_HOUR_START8]
           ,[PEAK_HOUR_START9]
           ,[PEAK_HOUR_START10]
           ,[PEAK_HOUR_END1]
           ,[PEAK_HOUR_END2]
           ,[PEAK_HOUR_END3]
           ,[PEAK_HOUR_END4]
           ,[PEAK_HOUR_END5]
           ,[PEAK_HOUR_END6]
           ,[PEAK_HOUR_END7]
           ,[PEAK_HOUR_END8]
           ,[PEAK_HOUR_END9]
           ,[PEAK_HOUR_END10]
           ,[OFFPEAK_HOUR_DAYS1]
           ,[OFFPEAK_HOUR_DAYS2]
           ,[OFFPEAK_HOUR_DAYS3]
           ,[OFFPEAK_HOUR_DAYS4]
           ,[OFFPEAK_HOUR_DAYS5]
           ,[OFFPEAK_HOUR_DAYS6]
           ,[OFFPEAK_HOUR_DAYS7]
           ,[OFFPEAK_HOUR_DAYS8]
           ,[OFFPEAK_HOUR_DAYS9]
           ,[OFFPEAK_HOUR_DAYS10]
           ,[OFFPEAK_HOUR_START1]
           ,[OFFPEAK_HOUR_START2]
           ,[OFFPEAK_HOUR_START3]
           ,[OFFPEAK_HOUR_START4]
           ,[OFFPEAK_HOUR_START5]
           ,[OFFPEAK_HOUR_START6]
           ,[OFFPEAK_HOUR_START7]
           ,[OFFPEAK_HOUR_START8]
           ,[OFFPEAK_HOUR_START9]
           ,[OFFPEAK_HOUR_START10]
           ,[OFFPEAK_HOUR_END1]
           ,[OFFPEAK_HOUR_END2]
           ,[OFFPEAK_HOUR_END3]
           ,[OFFPEAK_HOUR_END4]
           ,[OFFPEAK_HOUR_END5]
           ,[OFFPEAK_HOUR_END6]
           ,[OFFPEAK_HOUR_END7]
           ,[OFFPEAK_HOUR_END8]
           ,[OFFPEAK_HOUR_END9]
           ,[OFFPEAK_HOUR_END10]
           ,[DELDATE]
           ,[DELUSER]
           ,[AGENT_ID]
           ,[TRAN_THRESH_HOST_LINK]
           ,[IP_ADDRESS]
           ,[SNMP_VERSION]
           ,[COMMUNITY_STRING_LINK]
           ,[ENTERPRISE_OID_LINK]
           ,[ENCRYPTION_CERT]
           ,[FILE_PREFIX]
           ,[FILE_PATH]
           ,[WEIGHTED_HOURS_LINK]
           ,[EXTERNAL_ID]
           ,[TENANT_ID]
           ,[LATITUDE]
           ,[LONGITUDE]
           ,[DNS_NAME]
           ,[CACHE_ADDRESS]
           ,[CASH_THRESHOLD_LINK]
           ,[CASSETTE_ID]
           ,[CASH_CASSETTE_LINK]
           ,[VERSION]
           ,[WORKFLOW_ID]
           ,[sync_ver]
		 )
          
          
Select 
  
           
		   [LINK]
           ,[ID]
           ,[ALIAS2]
           ,[ALIAS3]
           ,[ALIAS4]
           ,[SITE_ID]
           ,[SERIAL_NUM]
           ,[LOAD_IMAGE]
           ,[ADDRESS]
           ,[ADDRESS2]
           ,[CITY]
           ,[STATE]
           ,[ZIP]
           ,[FLAG]
           ,[PHONE]
           ,[STATUS_TABLE_LINK]
           ,[AREA_LINK]
           ,[CLASS_LINK]
           ,[DISTRICT_LINK]
           ,[DATA_LINE_LINK]
           ,[REGION_LINK]
           ,[BRANCH_LINK]
           ,[INSTITUTION_LINK]
           ,[OBJECT_TYPE_LINK]
           ,[ZONE_LINK]
           ,[IN_SERVICE]
           ,[OUT_OF_SERVICE]
           ,[EDITOR_NOTE]
           ,[TIME_OFFSET]
           ,[DOWN_TOO_LONG]
           ,[SCRIPT_LINK]
           ,[COMMAND_SCRIPT_LINK]
           ,[PRIORITY]
           ,[OPERATION_HOUR_DAYS1]
           ,[OPERATION_HOUR_DAYS2]
           ,[OPERATION_HOUR_DAYS3]
           ,[OPERATION_HOUR_DAYS4]
           ,[OPERATION_HOUR_DAYS5]
           ,[OPERATION_HOUR_DAYS6]
           ,[OPERATION_HOUR_DAYS7]
           ,[OPERATION_HOUR_DAYS8]
           ,[OPERATION_HOUR_DAYS9]
           ,[OPERATION_HOUR_DAYS10]
           ,[OPERATION_HOUR_START1]
           ,[OPERATION_HOUR_START2]
           ,[OPERATION_HOUR_START3]
           ,[OPERATION_HOUR_START4]
           ,[OPERATION_HOUR_START5]
           ,[OPERATION_HOUR_START6]
           ,[OPERATION_HOUR_START7]
           ,[OPERATION_HOUR_START8]
           ,[OPERATION_HOUR_START9]
           ,[OPERATION_HOUR_START10]
           ,[OPERATION_HOUR_END1]
           ,[OPERATION_HOUR_END2]
           ,[OPERATION_HOUR_END3]
           ,[OPERATION_HOUR_END4]
           ,[OPERATION_HOUR_END5]
           ,[OPERATION_HOUR_END6]
           ,[OPERATION_HOUR_END7]
           ,[OPERATION_HOUR_END8]
           ,[OPERATION_HOUR_END9]
           ,[OPERATION_HOUR_END10]
           ,[BRANCH_HOUR_DAYS1]
           ,[BRANCH_HOUR_DAYS2]
           ,[BRANCH_HOUR_DAYS3]
           ,[BRANCH_HOUR_DAYS4]
           ,[BRANCH_HOUR_DAYS5]
           ,[BRANCH_HOUR_DAYS6]
           ,[BRANCH_HOUR_DAYS7]
           ,[BRANCH_HOUR_DAYS8]
           ,[BRANCH_HOUR_DAYS9]
           ,[BRANCH_HOUR_DAYS10]
           ,[BRANCH_HOUR_START1]
           ,[BRANCH_HOUR_START2]
           ,[BRANCH_HOUR_START3]
           ,[BRANCH_HOUR_START4]
           ,[BRANCH_HOUR_START5]
           ,[BRANCH_HOUR_START6]
           ,[BRANCH_HOUR_START7]
           ,[BRANCH_HOUR_START8]
           ,[BRANCH_HOUR_START9]
           ,[BRANCH_HOUR_START10]
           ,[BRANCH_HOUR_END1]
           ,[BRANCH_HOUR_END2]
           ,[BRANCH_HOUR_END3]
           ,[BRANCH_HOUR_END4]
           ,[BRANCH_HOUR_END5]
           ,[BRANCH_HOUR_END6]
           ,[BRANCH_HOUR_END7]
           ,[BRANCH_HOUR_END8]
           ,[BRANCH_HOUR_END9]
           ,[BRANCH_HOUR_END10]
           ,[AFTER_HOUR_DAYS1]
           ,[AFTER_HOUR_DAYS2]
           ,[AFTER_HOUR_DAYS3]
           ,[AFTER_HOUR_DAYS4]
           ,[AFTER_HOUR_DAYS5]
           ,[AFTER_HOUR_DAYS6]
           ,[AFTER_HOUR_DAYS7]
           ,[AFTER_HOUR_DAYS8]
           ,[AFTER_HOUR_DAYS9]
           ,[AFTER_HOUR_DAYS10]
           ,[OTHER_HOUR_DAYS1]
           ,[OTHER_HOUR_DAYS2]
           ,[OTHER_HOUR_DAYS3]
           ,[OTHER_HOUR_DAYS4]
           ,[OTHER_HOUR_DAYS5]
           ,[OTHER_HOUR_DAYS6]
           ,[OTHER_HOUR_DAYS7]
           ,[OTHER_HOUR_DAYS8]
           ,[OTHER_HOUR_DAYS9]
           ,[OTHER_HOUR_DAYS10]
           ,[AFTER_HOUR_START1]
           ,[AFTER_HOUR_START2]
           ,[AFTER_HOUR_START3]
           ,[AFTER_HOUR_START4]
           ,[AFTER_HOUR_START5]
           ,[AFTER_HOUR_START6]
           ,[AFTER_HOUR_START7]
           ,[AFTER_HOUR_START8]
           ,[AFTER_HOUR_START9]
           ,[AFTER_HOUR_START10]
           ,[OTHER_HOUR_START1]
           ,[OTHER_HOUR_START2]
           ,[OTHER_HOUR_START3]
           ,[OTHER_HOUR_START4]
           ,[OTHER_HOUR_START5]
           ,[OTHER_HOUR_START6]
           ,[OTHER_HOUR_START7]
           ,[OTHER_HOUR_START8]
           ,[OTHER_HOUR_START9]
           ,[OTHER_HOUR_START10]
           ,[AFTER_HOUR_END1]
           ,[AFTER_HOUR_END2]
           ,[AFTER_HOUR_END3]
           ,[AFTER_HOUR_END4]
           ,[AFTER_HOUR_END5]
           ,[AFTER_HOUR_END6]
           ,[AFTER_HOUR_END7]
           ,[AFTER_HOUR_END8]
           ,[AFTER_HOUR_END9]
           ,[AFTER_HOUR_END10]
           ,[OTHER_HOUR_END1]
           ,[OTHER_HOUR_END2]
           ,[OTHER_HOUR_END3]
           ,[OTHER_HOUR_END4]
           ,[OTHER_HOUR_END5]
           ,[OTHER_HOUR_END6]
           ,[OTHER_HOUR_END7]
           ,[OTHER_HOUR_END8]
           ,[OTHER_HOUR_END9]
           ,[OTHER_HOUR_END10]
           ,[NOTES]
           ,[OBJECT_CLASS]
           ,[TRAN_THRESHOLD_LINK]
           ,[PEAK_HOUR_DAYS1]
           ,[PEAK_HOUR_DAYS2]
           ,[PEAK_HOUR_DAYS3]
           ,[PEAK_HOUR_DAYS4]
           ,[PEAK_HOUR_DAYS5]
           ,[PEAK_HOUR_DAYS6]
           ,[PEAK_HOUR_DAYS7]
           ,[PEAK_HOUR_DAYS8]
           ,[PEAK_HOUR_DAYS9]
           ,[PEAK_HOUR_DAYS10]
           ,[PEAK_HOUR_START1]
           ,[PEAK_HOUR_START2]
           ,[PEAK_HOUR_START3]
           ,[PEAK_HOUR_START4]
           ,[PEAK_HOUR_START5]
           ,[PEAK_HOUR_START6]
           ,[PEAK_HOUR_START7]
           ,[PEAK_HOUR_START8]
           ,[PEAK_HOUR_START9]
           ,[PEAK_HOUR_START10]
           ,[PEAK_HOUR_END1]
           ,[PEAK_HOUR_END2]
           ,[PEAK_HOUR_END3]
           ,[PEAK_HOUR_END4]
           ,[PEAK_HOUR_END5]
           ,[PEAK_HOUR_END6]
           ,[PEAK_HOUR_END7]
           ,[PEAK_HOUR_END8]
           ,[PEAK_HOUR_END9]
           ,[PEAK_HOUR_END10]
           ,[OFFPEAK_HOUR_DAYS1]
           ,[OFFPEAK_HOUR_DAYS2]
           ,[OFFPEAK_HOUR_DAYS3]
           ,[OFFPEAK_HOUR_DAYS4]
           ,[OFFPEAK_HOUR_DAYS5]
           ,[OFFPEAK_HOUR_DAYS6]
           ,[OFFPEAK_HOUR_DAYS7]
           ,[OFFPEAK_HOUR_DAYS8]
           ,[OFFPEAK_HOUR_DAYS9]
           ,[OFFPEAK_HOUR_DAYS10]
           ,[OFFPEAK_HOUR_START1]
           ,[OFFPEAK_HOUR_START2]
           ,[OFFPEAK_HOUR_START3]
           ,[OFFPEAK_HOUR_START4]
           ,[OFFPEAK_HOUR_START5]
           ,[OFFPEAK_HOUR_START6]
           ,[OFFPEAK_HOUR_START7]
           ,[OFFPEAK_HOUR_START8]
           ,[OFFPEAK_HOUR_START9]
           ,[OFFPEAK_HOUR_START10]
           ,[OFFPEAK_HOUR_END1]
           ,[OFFPEAK_HOUR_END2]
           ,[OFFPEAK_HOUR_END3]
           ,[OFFPEAK_HOUR_END4]
           ,[OFFPEAK_HOUR_END5]
           ,[OFFPEAK_HOUR_END6]
           ,[OFFPEAK_HOUR_END7]
           ,[OFFPEAK_HOUR_END8]
           ,[OFFPEAK_HOUR_END9]
           ,[OFFPEAK_HOUR_END10]
           ,[DELDATE]
           ,[DELUSER]
           ,[AGENT_ID]
           ,[TRAN_THRESH_HOST_LINK]
           ,[IP_ADDRESS]
           ,[SNMP_VERSION]
           ,[COMMUNITY_STRING_LINK]
           ,[ENTERPRISE_OID_LINK]
           ,[ENCRYPTION_CERT]
           ,[FILE_PREFIX]
           ,[FILE_PATH]
           ,[WEIGHTED_HOURS_LINK]
           ,[EXTERNAL_ID]
           ,@ID
           ,[LATITUDE]
           ,[LONGITUDE]
           ,[DNS_NAME]
           ,[CACHE_ADDRESS]
           ,[CASH_THRESHOLD_LINK]
           ,[CASSETTE_ID]
           ,[CASH_CASSETTE_LINK]
           ,[VERSION]
           ,[WORKFLOW_ID]
           ,[sync_ver]
		
from  #GASPER_OBJECT_Test1 

SET @RowCount = @RowCount + 1
END

DROP TABLE #SecurityT
Drop Table #GASPER_OBJECT_Test1 


GO

-- Select * from [VISION].[GASPER_OBJECT]

-- DBCC CHECKIDENT('vision.GASPER_OBJECT')

-- DBCC CHECKIDENT('vision.GASPER_OBJECT',reseed,365)



--      Select 596 * 5540
--      FINAL Total: 3301840


--  DELETE from Vision.Entity_test

--  Select count(*) from [VISION].[GASPER_OBJECT_Test]

--Select * from [VISION].[GASPER_OBJECT_Test]
--where tenant_id = 204