USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateOndemandRequest]    Script Date: 3/25/2015 11:52:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:		<Mandeep_Singh26>

-- Create date: <Feb 11,2015>

-- Description:	<Make Modification in OnDemandRequest>

-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateOndemandRequest')
DROP PROCEDURE [dbo].[usp_UpdateOndemandRequest]
GO 
CREATE PROCEDURE [dbo].[usp_UpdateOndemandRequest] 

	-- Add the parameters for the stored procedure here

	@OnDemandID INT,

	@Approver varchar(50),

	@Address VARCHAR(50),

	@RequestedDate DATEtime,

	@RequestedTime time,

	@ApproverRemarks VARCHAR(300),

	@RequestType VARCHAR(30),

	@BookingType VARCHAR(50)

AS

BEGIN

	BEGIN TRY 

		-- SET NOCOUNT ON added to prevent extra result sets from

		-- interfering with SELECT statements.

		SET NOCOUNT ON;



		-- Update statements for procedure here

		UPDATE OnDemandRequests

		SET Approver = @Approver,Address = @Address,RequestedDate =  @RequestedDate,

		RequestedTime = @RequestedTime, RequestRemarks = @ApproverRemarks, ModifiedOn=GETDATE(), RequestType = @RequestType, BookingType = @BookingType

		WHERE OndemandRequestId = @OnDemandID



	END TRY

	BEGIN CATCH

		THROW;

	END CATCH

END

GO


