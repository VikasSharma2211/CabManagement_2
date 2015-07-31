USE [CabTransport]
GO

/****** Object:  Table [dbo].[CabType]    Script Date: 3/30/2015 1:08:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CabType]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[CabType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CabName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsActiveComment] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CabType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
