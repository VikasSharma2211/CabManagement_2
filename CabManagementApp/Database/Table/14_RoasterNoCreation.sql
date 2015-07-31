USE [CabTransport]
GO

/****** Object:  Table [dbo].[RoasterNoCreation]    Script Date: 3/30/2015 1:14:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoasterNoCreation]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[RoasterNoCreation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PreFix] [varchar](50) NOT NULL,
	[RosterNo]  AS ([PreFix]+right(CONVERT([int],[Id]),(12))) PERSISTED
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
