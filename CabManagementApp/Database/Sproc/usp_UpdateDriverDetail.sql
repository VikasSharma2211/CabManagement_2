USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateDriverDetail]    Script Date: 3/25/2015 11:37:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateDriverDetail')
DROP PROCEDURE [dbo].[usp_UpdateDriverDetail]
GO 
CREATE  PROCEDURE [dbo].[usp_UpdateDriverDetail]
@DriverId INT,
@DriverName VARCHAR(50),
@DriverCode VARCHAR(50),
@DCID INT,
@EmpanelDate DATE,
@ModifBy VARCHAR(50),
@IsActive BIT

AS
BEGIN
       BEGIN TRY
	             
	   							   -- SET NOCOUNT ON added to prevent extra result sets from
								   -- interfering with SELECT statements.
								   SET NOCOUNT ON;
								     IF EXISTS(SELECT DriverCode FROM DriverDetails WHERE DriverCode=@DriverCode AND DriverId != @DriverId)
										BEGIN
												return -1
										END
								  ELSE
										BEGIN
												UPDATE DriverDetails 
												SET DriverName=@DriverName,DriverCode=@DriverCode,DCID=@DCID,EmpanelDate=@EmpanelDate,
												ModifyBy=@ModifBy,ModifyDate=CONVERT(DATE,GETDATE()),IsActive=@IsActive
												WHERE DriverId=@DriverId
												return 1
									   END
						
					   

	   END TRY

	   BEGIN CATCH
				
				THROW;
       END CATCH
END
GO


