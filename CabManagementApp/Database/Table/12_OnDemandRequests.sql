USE [CabTransport]
GO

/****** Object:  Table [dbo].[OnDemandRequests]    Script Date: 3/30/2015 1:11:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OnDemandRequests]') AND TYPE IN (N'U'))
CREATE TABLE [dbo].[OnDemandRequests](
	[OndemandRequestId] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestType] [varchar](10) NULL,
	[ReoccuringRequestId] [varchar](20) NULL,
	[EmailId] [varchar](100) NULL,
	[BookingType] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[DCID] [int] NULL,
	[RouteId] [int] NULL,
	[RequestedDate] [datetime] NULL,
	[RequestedTime] [time](7) NULL,
	[Address] [varchar](500) NULL,
	[Mobile] [varchar](15) NULL,
	[RequestRemarks] [varchar](500) NULL,
	[IsEditableByRequester] [bit] NULL,
	[Approver] [varchar](100) NULL,
	[IsApprovedStatus] [int] NULL,
	[ApproverRemarks] [varchar](500) NULL,
	[IsTransportStatus] [bit] NULL,
	[TransportApprovedBy] [varchar](100) NULL,
	[TransportRemarks] [varchar](500) NULL,
	[CabId] [int] NULL,
	[CreatedBy] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[ModifiedOn] [datetime] NULL,
	[IsRejected] [bit] NULL,
 CONSTRAINT [PK_OnDemandRequests] PRIMARY KEY CLUSTERED 
(
	[OndemandRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
