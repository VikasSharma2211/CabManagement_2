USE [CabTransport]
GO

/****** Object:  UserDefinedTableType [dbo].[UDT_CabPropertyy]    Script Date: 2/16/2015 9:40:05 PM ******/
CREATE TYPE [dbo].[UDT_CabPropertyy] AS TABLE(
	[PropertyId] [int] NOT NULL,
	[ExpiryDate] [date] NULL,
	[IsCompulsory] [bit] NULL
)
GO


