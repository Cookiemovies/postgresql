/****** Object:  Table [dbo].[cities]    Script Date: 07.12.2020 18:15:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[cities](
	[geonameid] [bigint] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[asciiname] [nvarchar](200) NOT NULL,
	[alternatenames] [text] NULL,
	[latitude] [nvarchar](20) NOT NULL,
	[longitude] [nvarchar](20) NOT NULL,
	[feature_class] [nvarchar](1) NOT NULL,
	[feature_code] [nvarchar](10) NOT NULL,
	[country_code] [nvarchar](2) NOT NULL,
	[cc2] [nvarchar](200) NULL,
	[admin1_code] [nvarchar](20) NULL,
	[admin2_code] [nvarchar](80) NULL,
	[admin3_code] [nvarchar](20) NULL,
	[admin4_code] [nvarchar](20) NULL,
	[population] [bigint] NOT NULL,
	[elevation] [bigint] NULL,
	[dem] [nvarchar](40) NOT NULL,
	[timezone] [nvarchar](40) NOT NULL,
	[modification_date] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_cities] PRIMARY KEY CLUSTERED 
(
	[geonameid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO