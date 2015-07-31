USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_RePrintDataByDate]    Script Date: 3/25/2015 11:51:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_RePrintDataByDate')
DROP PROCEDURE [dbo].[usp_RePrintDataByDate]
GO 
CREATE PROCEDURE [dbo].[usp_RePrintDataByDate] 
	@GivenDate Date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from RoasterManagement where PickupDropDate = @GivenDate
END

GO


