USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_RePrintDataDateShiftCab]    Script Date: 3/25/2015 11:52:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_RePrintDataDateShiftCab')
DROP PROCEDURE [dbo].[usp_RePrintDataDateShiftCab]
GO 
CREATE PROCEDURE [dbo].[usp_RePrintDataDateShiftCab]
	-- Add the parameters for the stored procedure here
	@ShiftTime varchar(20),
	@GivenDate Date,
	@CabNumber varchar(10)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select * from RoasterManagement where PickupDropDate = @GivenDate and PickupDropTime = @ShiftTime and REPLACE(CabNo,' ','') = @CabNumber
  
END

GO


