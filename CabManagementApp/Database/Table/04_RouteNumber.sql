USE [CabTransport]
GO

/****** Object:  Table [dbo].[RouteNumber]    Script Date: 3/30/2015 1:02:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RouteNumber]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RouteNumber](
	[RouteID] [int] IDENTITY(1,1) NOT NULL,
	[RouteName] [varchar](50) NULL,
	[DCID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RouteNumber] ADD  CONSTRAINT [DF_RouteNumber_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[RouteNumber]  WITH CHECK ADD FOREIGN KEY([DCID])
REFERENCES [dbo].[DC] ([DCID])
GO

ALTER TABLE [dbo].[RouteNumber]  WITH CHECK ADD FOREIGN KEY([DCID])
REFERENCES [dbo].[DC] ([DCID])
GO
