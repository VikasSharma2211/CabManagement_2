USE [CabTransport]
GO



/****** Object:  Table [dbo].[VendorManagement]    Script Date: 3/30/2015 12:59:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VendorManagement]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[VendorManagement](
	[VendorID] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [char](50) NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[EmpanelDate] [datetime] NULL,
	[DCID] [int] NULL,
	[Comment] [varchar](300) NULL,
	[IsActive] [bit] NULL,
	[IsActiveComment] [varchar](300) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [char](20) NULL,
 CONSTRAINT [PK__VendorMa__FC8618D35963954C] PRIMARY KEY CLUSTERED 
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[VendorManagement] ADD  CONSTRAINT [DF_VendorManagement_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[VendorManagement] ADD  CONSTRAINT [DF_VendorManagement_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

