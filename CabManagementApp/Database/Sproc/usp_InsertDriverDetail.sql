USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertDriverDetail]    Script Date: 3/25/2015 11:31:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertDriverDetail')
DROP PROCEDURE [dbo].[usp_InsertDriverDetail]
GO  


	CREATE PROCEDURE [dbo].[usp_InsertDriverDetail]
	@DriverName VARCHAR(50),
	@DriverCode VARCHAR(50),
	@DCID INT,
	@EmpanelDate VARCHAR(50),
	@CreatedBy VARCHAR(50),
	@IsActive VARCHAR(50)
	AS
	BEGIN
		BEGIN TRY
								-- SET NOCOUNT ON added to prevent extra result sets from
								-- interfering with SELECT statements.
					
							    IF EXISTS(SELECT DriverCode FROM DriverDetails WHERE DriverCode=@DriverCode)
									BEGIN
											return -1
									END
								ELSE
									BEGIN
											INSERT INTO DriverDetails 
											(DriverName,DriverCode,DCID,EmpanelDate,CreatedBy,IsActive)
											VALUES
											(@DriverName,@DriverCode,@DCID,@EmpanelDate,@CreatedBy,@IsActive)
											return 1
									END
					
				
				
		END TRY

		BEGIN CATCH
					
					THROW;
		END CATCH
	END
GO


