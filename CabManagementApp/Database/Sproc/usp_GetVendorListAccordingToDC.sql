USE [CabTransport]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetVendorListAccordingToDC]    Script Date: 4/16/2015 2:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manu_jaggi>
-- Create date: <Oct. 08,2014>
-- Description:	<To get all vendors list by their status or we can get particular vendor detail by passing vendorid>
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetVendorListAccordingToDC] 
	-- Add the parameters for the stored procedure here
	@VendorID INT = NULL,
	@IsActive BIT = NULL,
	@DCID int
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Select statements for procedure here
		SELECT VM.VendorID,VM.VendorName,VM.IsActive 
		FROM VendorManagement VM
		INNER JOIN
		DC
		on VM.DCID = DC.DCID
		WHERE (VM.VendorID = @VendorID OR @VendorID IS NULL) AND (VM.IsActive = @IsActive OR @IsActive IS NULL) AND DCName in(Select DCName from DC where DCID =@DCID)
		ORDER BY VM.VendorID DESC
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
