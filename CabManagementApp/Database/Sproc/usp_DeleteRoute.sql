USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_DeleteRoute]    Script Date: 3/25/2015 11:20:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Manish_Jhamb>
-- Create date: <Oct. 10,2014>
-- Description:	<Create a new Route>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_DeleteRoute')
DROP PROCEDURE [dbo].[usp_DeleteRoute]
GO
CREATE PROCEDURE [dbo].[usp_DeleteRoute] 
	-- Add the parameters for the stored procedure here
	@DPID VARCHAR(MAX),
	@IsActive BIT,
	@ModifiedBy CHAR(20)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Update statements for procedure here
		UPDATE RouteMaster
		SET IsActive = @IsActive,CreatedBy = @ModifiedBy,CreatedDate=GETDATE()
		WHERE DPID in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@DPID));
		
		RETURN 1

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


