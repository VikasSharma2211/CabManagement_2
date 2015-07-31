USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetPointsByRoute]    Script Date: 3/25/2015 11:26:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetPointsByRoute')
DROP PROCEDURE [dbo].[usp_GetPointsByRoute]
GO
CREATE PROCEDURE [dbo].[usp_GetPointsByRoute] 
@RouteName VARCHAR(100)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Select statements for procedure here
		SELECT DropPoint,RouteID
		FROM RouteMaster		
		WHERE IsActive=1 AND RouteName = @RouteName

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


