USE [CabTransport]
GO

/****** Object:  Table [dbo].[DriverDetails]    Script Date: 3/30/2015 1:09:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DriverDetails]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[DriverDetails](
	[DriverId] [int] IDENTITY(1001,1) NOT NULL,
	[DriverName] [varchar](50) NULL,
	[DriverCode] [varchar](50) NULL,
	[EmpanelDate] [date] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifyBy] [varchar](50) NULL,
	[ModifyDate] [date] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

