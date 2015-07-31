USE [CabTransport]
GO

/****** Object:  Table [dbo].[CabManagement]    Script Date: 3/30/2015 1:10:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CabManagement]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[CabManagement](
	[CabId] [int] IDENTITY(1,1) NOT NULL,
	[CabNumberFirst] [char](10) NULL,
	[CabNumberLast] [char](10) NULL,
	[DocumentsVerified] [bit] NULL,
	[VendorID] [int] NULL,
	[CabType] [char](20) NULL,
	[CabCapacity] [smallint] NULL,
	[EmpanelDate] [datetime] NULL,
	[Comment] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[IsActiveComment] [varchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [char](20) NULL,
	[DriverId] [int] NULL,
 CONSTRAINT [PK__CabManag__66AC416DBE2C168E] PRIMARY KEY CLUSTERED 
(
	[CabId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

