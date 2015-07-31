USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetSelectedrouteAccordingToDC]    Script Date: 3/25/2015 11:29:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:		<Manish_Jhamb>

-- Create date: <Oct. 10,2014>

-- Description:	<Create a new Route>

-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetSelectedrouteAccordingToDC')
DROP PROCEDURE [dbo].[usp_GetSelectedrouteAccordingToDC]
GO
Create PROCEDURE [dbo].[usp_GetDriverDetailsAccToDC]
	
	@DCID INT,
	@IsActive BIT
	AS
	BEGIN
				   BEGIN TRY
								 -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
								   SELECT DriverId,DriverCode,D.DCName,DriverName,DD.IsActive
								   FROM DriverDetails DD JOIN DC D ON DD.DCID=D.DCID
								   WHERE (DD.IsActive=@IsActive OR @IsActive IS NULL) AND (DD.DCID=@DCID OR DD.DCID IS NULL) AND DriverId NOT IN (SELECT DriverId from CabManagement)
				   END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END

GO


