USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertNewRequest_OLD]    Script Date: 3/25/2015 11:49:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Manu_jaggi>
-- Create date: <Oct. 08,2014>
-- Description:	<Create a new vendor>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertNewRequest_OLD')
DROP PROCEDURE [dbo].[usp_InsertNewRequest_OLD]
GO  
CREATE PROCEDURE [dbo].[usp_InsertNewRequest_OLD] 
	-- Add the parameters for the stored procedure here
	@EmailId VARCHAR(100),
	@BookingType VARCHAR(50),
	@Gender VARCHAR(50),
	@DCID INT,
	@RouteId INT,
	@RequestedDate DATETIME,
	@RequestedTime TIME(7),
	@Address VARCHAR(20),
	@Mobile VARCHAR(15),
	@RequestRemarks VARCHAR(500),
	@CreatedBy VARCHAR(100)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Insert statements for procedure here
		INSERT INTO OnDemandRequests
		(EmailId,BookingType,Gender,DCID,RouteId,RequestedDate,RequestedTime,Address,Mobile,RequestRemarks,IsEditableByRequester
		,CreatedBy,CreatedOn)
		VALUES
		(@EmailId,@BookingType,@Gender,@DCID,@RouteId,@RequestedDate,@RequestedTime,@Address,@Mobile,@RequestRemarks,1
		,@CreatedBy,GETDATE())

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


