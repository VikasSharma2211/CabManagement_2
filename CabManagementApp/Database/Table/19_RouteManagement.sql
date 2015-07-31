USE [CabTransport]
GO

/****** Object:  Table [dbo].[RouteManagement]    Script Date: 3/30/2015 1:18:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RouteManagement]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RouteManagement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[EmployeeID] [int] NULL,
	[EmployeeName] [char](50) NULL,
	[Address] [char](100) NULL,
	[Route] [int] NULL,
	[ShiftID] [int] NULL,
	[CabID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [char](20) NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RouteManagement] ADD  CONSTRAINT [DF_RouteManagement_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

