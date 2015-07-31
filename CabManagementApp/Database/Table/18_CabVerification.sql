USE [CabTransport]
GO

/****** Object:  Table [dbo].[CabVerification]    Script Date: 3/30/2015 1:17:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CabVerification]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[CabVerification](
	[CabVerificationId] [int] IDENTITY(1,1) NOT NULL,
	[CabId] [int] NULL,
	[PropertyId] [int] NULL,
	[ExpiryDate] [date] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [char](20) NULL,
 CONSTRAINT [PK_CabVerification] PRIMARY KEY CLUSTERED 
(
	[CabVerificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
