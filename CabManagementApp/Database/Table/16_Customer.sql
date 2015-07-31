USE [CabTransport]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 3/30/2015 1:15:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[Customer](
	[Id] [int] NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[Age] [int] NULL,
 CONSTRAINT [defaultconstraint] UNIQUE NONCLUSTERED 
(
	[FirstName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [defaultconstraints]  DEFAULT ('TEST') FOR [LastName]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [myCheckConstraint] CHECK  (([AGE]>=(18)))
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [myCheckConstraint]
GO
