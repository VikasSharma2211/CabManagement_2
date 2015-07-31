USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetLatestRecords]    Script Date: 3/25/2015 11:44:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetLatestRecords')
DROP PROCEDURE [dbo].[usp_GetLatestRecords]
GO

	CREATE PROCEDURE [dbo].[usp_GetLatestRecords]
	@UserCode Varchar(50)=NULL
	AS
	BEGIN
			BEGIN TRY


				   SELECT  TOP 1 *,rm.RouteName 
				   FROM OnDemandRequests odr
				   INNER JOIN RouteMaster rm
				   ON odr.RouteId = rm.RouteID 
				   WHERE EmailId=@UserCode
				   ORDER BY OndemandRequestId DESC
	  
			END TRY

		    BEGIN CATCH
			THROW;
			END CATCH

	END

	
 
 


GO


