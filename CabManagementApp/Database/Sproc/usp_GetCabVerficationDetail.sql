USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetCabVerficationDetail]    Script Date: 3/25/2015 11:23:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetCabVerficationDetail')
DROP PROCEDURE [dbo].[usp_GetCabVerficationDetail]
GO


CREATE PROCEDURE [dbo].[usp_GetCabVerficationDetail]
@CabId VARCHAR(50)
AS

BEGIN

	 -- SET NOCOUNT ON added to prevent extra result sets from
     -- interfering with SELECT statements.
	 SET NOCOUNT ON;

	 BEGIN TRY
		 SELECT PropertyId,CONVERT(VARCHAR, ExpiryDate, 107) AS ExpiryDate FROM CabVerification
		 WHERE CabId=@CabId;

	 END TRY

	 BEGIN CATCH
	     THROW;
	 END CATCH

END
GO


