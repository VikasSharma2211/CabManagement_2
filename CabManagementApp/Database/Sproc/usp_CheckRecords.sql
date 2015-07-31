USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_CheckRecords]    Script Date: 3/25/2015 11:42:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_CheckRecords')
DROP PROCEDURE [dbo].[usp_CheckRecords]
GO



	CREATE PROCEDURE [dbo].[usp_CheckRecords]
	@UserCode Varchar(50)=NULL,
	@RouteId INT,
	@RequestedDate DATETIME
	
	AS
	BEGIN
				DECLARE @Temp INT
				SET @Temp=0
				   BEGIN TRY

				    -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
			select COUNT(OndemandRequestId) as Record from OnDemandRequests where EmailId=@UserCode and RouteId=@RouteId and RequestedDate=@RequestedDate	  
			
  END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END

	
 
 --(select COUNT(OndemandRequestId) as Record from OnDemandRequests where EmailId='Narender_Kumar09@infosys.com'
 -- and RouteId=5 and RequestedDate='2015-02-14 00:00:00.000')
 


GO


