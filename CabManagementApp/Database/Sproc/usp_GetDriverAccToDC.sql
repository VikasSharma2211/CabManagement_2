GO
CREATE PROCEDURE [dbo].[usp_GetDriverDetailsAccToDC]
	
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
								   WHERE (DD.IsActive=@IsActive OR @IsActive IS NULL) AND (DD.DCID=@DCID OR DD.DCID IS NULL)
				   END TRY

	BEGIN CATCH
	THROW;
	END CATCH

	END