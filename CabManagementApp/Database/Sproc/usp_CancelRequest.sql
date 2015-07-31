USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[USP_CancelRequest]    Script Date: 3/25/2015 11:41:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_CancelRequest')
DROP PROCEDURE [dbo].[USP_CancelRequest]
GO



	CREATE PROCEDURE [dbo].[USP_CancelRequest]
	@OnDemandID Varchar(50)=NULL,
	@ModifiedBy Varchar(100)=NULL,
	@ModifiedDate datetime=NULL
	AS
	BEGIN
				   BEGIN TRY
								 -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
					UPDATE OnDemandRequests
		SET IsApprovedStatus = 3, ModifiedBy = @ModifiedBy, @ModifiedDate = GETDATE()
		WHERE OndemandRequestId = @OnDemandID;
		return 1
				   END TRY
				   BEGIN CATCH
					THROW;
				   END CATCH

	END




GO


