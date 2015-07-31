USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetVendorList]    Script Date: 3/25/2015 11:31:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Manu_jaggi>
-- Create date: <Oct. 08,2014>
-- Description:	<To get all vendors list by their status or we can get particular vendor detail by passing vendorid>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetVendorList')
DROP PROCEDURE [dbo].[usp_GetVendorList]
GO  

CREATE PROCEDURE [dbo].[usp_GetVendorList] 
	-- Add the parameters for the stored procedure here
	@VendorID INT = NULL,
	@IsActive BIT = NULL
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Select statements for procedure here
		SELECT VM.VendorID,VM.VendorName,VM.Address,VM.City,VM.EmpanelDate,VM.Comment,VM.CreatedBy,VM.CreatedDate,VM.IsActive,DC.DCName 
		FROM VendorManagement VM
		INNER JOIN
		DC
		on VM.DCID = DC.DCID
		WHERE (VM.VendorID = @VendorID OR @VendorID IS NULL) AND (VM.IsActive = @IsActive OR @IsActive IS NULL)
		ORDER BY VM.VendorID DESC
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


