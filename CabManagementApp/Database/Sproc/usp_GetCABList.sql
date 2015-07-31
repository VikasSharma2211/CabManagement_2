USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetCABList]    Script Date: 3/25/2015 11:22:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetCABList')
DROP PROCEDURE [dbo].[usp_GetCABList]
GO


CREATE PROCEDURE [dbo].[usp_GetCABList]
	-- Add the parameters for the stored procedure here
	@CabId INT = NULL,
	@IsActive BIT = NULL,
	@DCID INT = NULL,
	@VendorID INT = NULL

AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Select statements for procedure here
		SELECT CB.CabId,CB.CabNumberFirst,CB.CabNumberLast,CB.DocumentsVerified,CB.CabType,CB.CabCapacity,CB.DriverName,CB.EmpanelDate,CB.CreatedBy,CB.CreatedDate,
		VM.VendorID,VM.VendorName,DC.DCName,DC.DCID
		FROM CabManagement CB
		INNER JOIN
		VendorManagement VM
		ON CB.VendorID = VM.VendorID
		INNER JOIN
		DC
		on VM.DCID = DC.DCID
		WHERE (CB.VendorID = @VendorID OR @VendorID IS NULL) AND (VM.IsActive = @IsActive OR @IsActive IS NULL)
		AND (CB.CabId = @CabId OR @CabId IS NULL) AND (DC.DCID = @DCID OR @DCID IS NULL)

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


