USE [CabTransport]
GO

/****** Object:  Table [dbo].[PickupDropRoster]    Script Date: 3/30/2015 1:14:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PickupDropRoster]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[PickupDropRoster](
	[Client] [varchar](50) NULL,
	[ProjectCode] [varchar](50) NULL,
	[PickupDropDate] [date] NULL,
	[EmployeeNumber] [varchar](50) NULL,
	[EmployeeName] [varchar](50) NULL,
	[Gender] [varchar](20) NULL,
	[Address] [varchar](50) NULL,
	[Area] [varchar](50) NULL,
	[Route] [varchar](50) NULL,
	[LandmarkName] [varchar](50) NULL,
	[Contact] [varchar](50) NULL,
	[PickupDropOrder] [varchar](50) NULL,
	[PickupDropTime] [datetime] NULL,
	[WorkingDays] [varchar](50) NULL,
	[TypeOfPickup] [varchar](50) NULL,
	[TypeOfDrop] [varchar](50) NULL,
	[ShiftTimings] [datetime] NULL,
	[CabType] [varchar](50) NULL,
	[Vendor] [varchar](50) NULL,
	[EndUser] [varchar](50) NULL,
	[Guard] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
