USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[USP_REJECTUSERREQUEST]    Script Date: 3/25/2015 11:50:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_REJECTUSERREQUEST')
DROP PROCEDURE [dbo].[USP_REJECTUSERREQUEST]
GO  
CREATE PROCEDURE [dbo].[USP_REJECTUSERREQUEST]
@OndemandRequestID VARCHAR(100),
@ModifiedBy VARCHAR(100),
@Comment VARCHAR(50)
As
BEGIN
       BEGIN TRY
				BEGIN TRANSACTION
						 BEGIN
									-- SET NOCOUNT ON added to prevent extra result sets from
									-- interfering with SELECT statements.
										SET NOCOUNT ON;
										UPDATE OnDemandRequests 
										set  IsRejected=1,IsApprovedStatus=2,ModifiedBy=@ModifiedBy,ApproverRemarks=@Comment
										WHERE OndemandRequestID in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@OndemandRequestID));


						 END
				 COMMIT;
	   END TRY
	   BEGIN CATCH
	             ROLLBACK;
				 THROW;
	   END CATCH
END

GO


