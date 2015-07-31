USE [CabTransport]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActiveInactiveProperty]    Script Date: 3/25/2015 7:22:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_ActiveInactiveProperty')
DROP PROCEDURE [dbo].[usp_ActiveInactiveProperty]
GO
CREATE PROCEDURE [dbo].[usp_ActiveInactiveProperty] 
	-- Add the parameters for the stored procedure here
	@PropertyIDs VARCHAR(50),
	@IsActive BIT,
	@ModifiedBy CHAR(20)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Update statements for procedure here
		UPDATE CabProperty SET IsActive = @IsActive,ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE()
		WHERE PropertyId in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@PropertyIDs));

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
