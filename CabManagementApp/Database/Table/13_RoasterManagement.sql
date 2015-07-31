USE [CabTransport]
GO

/****** Object:  Table [dbo].[RoasterManagement]    Script Date: 3/30/2015 1:13:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoasterManagement]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RoasterManagement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RosterNo] [varchar](50) NULL,
	[Client] [varchar](50) NULL,
	[ProjectCode] [varchar](50) NULL,
	[PickupDropDate] [date] NULL,
	[EmployeeNumber] [varchar](50) NULL,
	[EmployeeName] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[Area] [varchar](50) NULL,
	[RouteNO] [varchar](50) NULL,
	[LandmarkName] [varchar](50) NULL,
	[Contact] [varchar](50) NULL,
	[Pickupdroporder] [varchar](50) NULL,
	[PickupDropTime] [time](7) NULL,
	[Workingdays] [varchar](50) NULL,
	[Typeofpickup] [varchar](50) NULL,
	[TypeofDrop] [varchar](50) NULL,
	[ShiftTimings] [time](7) NULL,
	[CabNo] [varchar](20) NULL,
	[CabType] [varchar](50) NULL,
	[Vendor] [varchar](50) NULL,
	[EndUser] [varchar](50) NULL,
	[Guard] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

