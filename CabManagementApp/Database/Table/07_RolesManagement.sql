USE [CabTransport]
GO

/****** Object:  Table [dbo].[RolesManagement]    Script Date: 3/30/2015 1:07:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolesManagement]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RolesManagement](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [char](20) NULL,
	[RoleAccess] [char](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [char](20) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
