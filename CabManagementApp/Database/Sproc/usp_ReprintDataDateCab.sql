USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_RePrintDataDateCab]    Script Date: 3/25/2015 11:51:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_RePrintDataDateCab')
DROP PROCEDURE [dbo].[usp_RePrintDataDateCab]
GO 
CREATE PROCEDURE [dbo].[usp_RePrintDataDateCab]
	-- Add the parameters for the stored procedure here
	@CabNumber varchar(20),
	@GivenDate Date
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select * from RoasterManagement where REPLACE(CabNo,' ','') = @CabNumber and PickupDropDate = @GivenDate
  
END

GO


