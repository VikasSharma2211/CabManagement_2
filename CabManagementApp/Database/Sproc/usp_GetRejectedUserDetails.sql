USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[USP_GetRejectedUserDetails]    Script Date: 3/25/2015 11:47:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_GetRejectedUserDetails')
DROP PROCEDURE [dbo].[USP_GetRejectedUserDetails]
GO



	CREATE PROCEDURE [dbo].[USP_GetRejectedUserDetails]
	@UserCode Varchar(50)=NULL
	AS
	BEGIN
				   BEGIN TRY
								 -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
								   SELECT * from OnDemandRequests where
								   IsRejected=1 and approver=@usercode order by CreatedOn desc
				   END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END


GO


