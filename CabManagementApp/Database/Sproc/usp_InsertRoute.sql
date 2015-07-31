USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertRoute]    Script Date: 3/25/2015 11:34:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Manish_Jhamb>
-- Create date: <Oct. 10,2014>
-- Description:	<Create a new Route>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertRoute')
DROP PROCEDURE [dbo].[usp_InsertRoute]
GO  

CREATE PROCEDURE [dbo].[usp_InsertRoute] 
	@RouteName VARCHAR(50),
	@DCID int,
	@CreatedBy VARCHAR(50)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		-- Insert statements for procedure here
		if exists(select TOP(1) RouteID from RouteNumber where RouteName = @RouteName AND DCID = @DCID)
		begin
		return -1 --already exist
		end
		else 
		begin
		INSERT INTO RouteNumber
		(RouteName,DCID,CreatedDate,CreatedBy)
		VALUES
		(@RouteName,@DCID,GETDATE(),@CreatedBy)
		return 1
		end
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END



GO


