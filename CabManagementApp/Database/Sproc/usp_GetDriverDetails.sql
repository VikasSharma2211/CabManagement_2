USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetDriverDetails]    Script Date: 3/25/2015 11:25:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetDriverDetails')
DROP PROCEDURE [dbo].[usp_GetDriverDetails]
GO


	CREATE PROCEDURE [dbo].[usp_GetDriverDetails]
	@DriverCode Varchar(50)=NULL,
	@IsActive BIT = NULL
	AS
	BEGIN
				   BEGIN TRY
								 -- SET NOCOUNT ON added to prevent extra result sets from
								 -- interfering with SELECT statements.
								   SET NOCOUNT ON;
									-- Select statements for procedure 
								   SELECT DriverId,DriverCode,D.DCName,DriverName,EmpanelDate,DD.CreatedBy,ModifyDate,ModifyBy,DD.IsActive  FROM DriverDetails DD JOIN DC D ON DD.DCID=D.DCID
								   WHERE  (DriverCode =@DriverCode OR @DriverCode IS NULL) AND (DD.IsActive=@IsActive OR @IsActive IS NULL) 
				   END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END
	GO


