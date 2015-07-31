USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetMyRequest]    Script Date: 3/25/2015 11:45:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetMyRequest')
DROP PROCEDURE [dbo].[usp_GetMyRequest]
GO


	CREATE PROCEDURE [dbo].[usp_GetMyRequest]
	@UserCode Varchar(50)=NULL
	AS
	BEGIN
				   BEGIN TRY
								 -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
								   SELECT ondemandrequestid, Approver as emailid, bookingtype, gender, odr.RouteId, rm.RouteName, CONVERT(varchar,Requesteddate,103) as Requesteddate, Requestedtime, RequestType, Address, RequestRemarks, IsApprovedStatus, IsRejected  FROM ondemandRequests odr
								   INNER JOIN RouteMaster rm ON odr.RouteId = rm.RouteID
								   WHERE  (emailid =@UserCode OR @UserCode IS NULL) order by CreatedOn desc
				   END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END




GO


