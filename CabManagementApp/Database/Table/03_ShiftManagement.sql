USE [CabTransport]
GO


/****** Object:  Table [dbo].[ShiftManagement]    Script Date: 3/30/2015 1:01:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShiftManagement]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[ShiftManagement](
	[ShiftId] [int] IDENTITY(1,1) NOT NULL,
	[ShiftType] [char](8) NULL,
	[ShiftTime] [time](7) NULL,
	[ShiftCategory] [varchar](50) NULL,
	[DCID] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [char](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [char](20) NULL,
 CONSTRAINT [PK__ShiftMan__C0A8388109AB16EA] PRIMARY KEY CLUSTERED 
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ShiftManagement] ADD  CONSTRAINT [DF_ShiftManagement_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of shift “log in” or “log out”' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShiftManagement', @level2type=N'COLUMN',@level2name=N'ShiftType'
GO
