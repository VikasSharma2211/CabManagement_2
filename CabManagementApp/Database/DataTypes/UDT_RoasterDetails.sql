USE [CabTransport]
GO

/****** Object:  UserDefinedTableType [dbo].[UDT_RoasterDetails]    Script Date: 2/16/2015 9:39:21 PM ******/
CREATE TYPE [dbo].[UDT_RoasterDetails] AS TABLE(
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
	[PickupDropTime] [datetime] NULL,
	[Workingdays] [varchar](50) NULL,
	[Typeofpickup] [varchar](50) NULL,
	[TypeofDrop] [varchar](50) NULL,
	[ShiftTimings] [datetime] NULL,
	[CabNo] [varchar](20) NULL,
	[CabType] [varchar](50) NULL,
	[Vendor] [varchar](50) NULL,
	[EndUser] [varchar](50) NULL,
	[Guard] [varchar](50) NULL
)
GO


