USE [CabTransport]
GO

/****** Object:  Table [dbo].[RouteMaster]    Script Date: 3/30/2015 1:04:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RouteMaster]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RouteMaster](
	[DPID] [int] IDENTITY(1,1) NOT NULL,
	[RouteID] [int] NOT NULL,
	[RouteName] [varchar](50) NULL,
	[DCID] [int] NOT NULL,
	[DropPoint] [varchar](50) NOT NULL,
	[SortOrder] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RouteMaster] ADD  CONSTRAINT [DF_RouteMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[RouteMaster]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[RouteNumber] ([RouteID])
GO

ALTER TABLE [dbo].[RouteMaster]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[RouteNumber] ([RouteID])
GO

ALTER TABLE [dbo].[RouteMaster]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[RouteNumber] ([RouteID])
GO

ALTER TABLE [dbo].[RouteMaster]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[RouteNumber] ([RouteID])
GO
