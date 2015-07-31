USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetActiveUserDetails]    Script Date: 3/25/2015 11:43:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetActiveUserDetails')
DROP PROCEDURE [dbo].[usp_GetActiveUserDetails]
GO
CREATE PROCEDURE [dbo].[usp_GetActiveUserDetails]
@UserCode VARCHAR(100)
As
BEGIN
       BEGIN TRY
				BEGIN TRANSACTION
						 BEGIN
									-- SET NOCOUNT ON added to prevent extra result sets from
									-- interfering with SELECT statements.
										SET NOCOUNT ON;
									
SELECT * FROM [dbo].[OnDemandRequests] where IsApprovedStatus=1 and EmailId=@UserCode order by CreatedOn desc;	

						 END
				 COMMIT;
	   END TRY
	   BEGIN CATCH
	             ROLLBACK;
				 THROW;
	   END CATCH
END

GO


