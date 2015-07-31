USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetUserDetails]    Script Date: 3/25/2015 11:49:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetUserDetails')
DROP PROCEDURE [dbo].[usp_GetUserDetails]
GO  


	CREATE PROCEDURE [dbo].[usp_GetUserDetails]
	@UserCode Varchar(50)=NULL,
	@IsActive BIT = NULL
	AS
	BEGIN
				   BEGIN TRY
								 -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
								   SELECT ondemandrequestid,emailid,bookingtype,gender,routeid,CONVERT(varchar,Requesteddate,103) as Requesteddate,Requestedtime,Address,RequestRemarks,IsApprovedStatus  FROM ondemandRequests
								   WHERE  (Approver =@UserCode OR @UserCode IS NULL) AND (IsApprovedStatus=@IsActive OR @IsActive IS NULL) 
								   and (IsRejected=0 OR IsRejected IS NULL) order by CreatedOn desc
				   END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END


GO


