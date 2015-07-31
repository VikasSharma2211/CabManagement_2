USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_ActiveInactiveUser]    Script Date: 3/25/2015 11:53:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_ActiveInactiveUser')
DROP PROCEDURE [dbo].[usp_ActiveInactiveUser]
GO

CREATE PROCEDURE [dbo].[usp_ActiveInactiveUser]
@OndemandRequestID VARCHAR(100),
@IsActive bit,
@ModifiedBy VARCHAR(50)
As
BEGIN
       BEGIN TRY
				BEGIN TRANSACTION
						 BEGIN
									-- SET NOCOUNT ON added to prevent extra result sets from
									-- interfering with SELECT statements.
										SET NOCOUNT ON;
										UPDATE OnDemandRequests 
										set  isApprovedstatus=@IsActive,ModifiedBy=@ModifiedBy
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


