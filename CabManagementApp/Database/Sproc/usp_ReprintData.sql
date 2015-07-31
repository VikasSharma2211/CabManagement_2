USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_RePrintData]    Script Date: 3/25/2015 11:50:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_RePrintData')
DROP PROCEDURE [dbo].[usp_RePrintData]
GO 
CREATE PROCEDURE [dbo].[usp_RePrintData]
	-- Add the parameters for the stored procedure here
	@CabNumber varchar(20),
	@GivenDate Date,
	@GivenShiftTime Time
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @SQLQuery AS NVarchar(500)
	Set @SQLQuery = 'Select * From RoasterManagement where (1=1) ' 

	/* check for the condition and build the WHERE clause accordingly */
	If @CabNumber IS NUll
	Set @SQLQuery = @SQLQuery + ' And (PickupDropDate = @GivenDate)' + 'And (ShiftTimings = @GivenShiftTime)'

	If @GivenShiftTime IS NULL
	Set @SQLQuery = @SQLQuery + ' And (PickupDropDate = @GivenDate)' + 'And (CabNo = @CabNumber)'

	If (@CabNumber IS Not Null) AND (@GivenShiftTime IS Not Null)
	Set @SQLQuery = @SQLQuery + 'And (PickupDropDate = @GivenDate)' + 'And (CabNo = @CabNumber)' + 'And (ShiftTimings = @GivenShiftTime)'

	Execute sp_Executesql     @SQLQuery, @CabNumber, @GivenDate , @GivenShiftTime
  
END

GO


