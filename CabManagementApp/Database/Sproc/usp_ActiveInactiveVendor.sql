USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_ActiveInactiveVendor]    Script Date: 3/25/2015 11:19:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Manu_jaggi>
-- Create date: <Oct. 08,2014>
-- Description:	<Active or inactive vendor>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_ActiveInactiveVendor')
DROP PROCEDURE [dbo].[usp_ActiveInactiveVendor]
GO

CREATE PROCEDURE [dbo].[usp_ActiveInactiveVendor] 
	-- Add the parameters for the stored procedure here
	@VendorIDs VARCHAR(50),
	@IsActive BIT,
	@IsActiveComment VARCHAR(300),
	@ModifiedBy CHAR(20)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Update statements for procedure here
		UPDATE VendorManagement SET IsActive = @IsActive, IsActiveComment = @IsActiveComment, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE()
		WHERE VendorID in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@VendorIDs));

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


