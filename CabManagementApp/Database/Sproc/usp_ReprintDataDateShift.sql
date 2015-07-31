USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_RePrintDataDateShift]    Script Date: 3/25/2015 11:52:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_RePrintDataDateShift')
DROP PROCEDURE [dbo].[usp_RePrintDataDateShift]
GO 
CREATE PROCEDURE [dbo].[usp_RePrintDataDateShift]
	-- Add the parameters for the stored procedure here
	@ShiftTime varchar(20),
	@GivenDate Date
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select * from RoasterManagement where PickupDropDate = @GivenDate and PickupDropTime = @ShiftTime
  
END

GO


