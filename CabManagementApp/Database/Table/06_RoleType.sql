USE [CabTransport]
GO

/****** Object:  Table [dbo].[RoleType]    Script Date: 3/30/2015 1:06:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleType]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RoleType](
	[RoleTypeId] [int] NOT NULL,
	[RoleType] [varchar](50) NULL,
	[RoleDescription] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
