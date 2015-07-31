USE [CabTransport]
GO

/****** Object:  Table [dbo].[CabCapacity]    Script Date: 3/30/2015 1:09:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CabCapacity]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[CabCapacity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CabCapacity] [int] NULL,
 CONSTRAINT [PK_CabCapacity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

