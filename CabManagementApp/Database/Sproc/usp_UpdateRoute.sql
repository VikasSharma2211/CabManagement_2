USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateRoute]    Script Date: 3/25/2015 11:38:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Manish_Jhamb>
-- Create date: <Oct. 10,2014>
-- Description:	<Create a new Route>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateRoute')
DROP PROCEDURE [dbo].[usp_UpdateRoute]
GO 
CREATE PROCEDURE [dbo].[usp_UpdateRoute] 
	-- Add the parameters for the stored procedure here
	@DPID int,
	@RouteName VARCHAR(50),
	@DropPoint VARCHAR(100),
	@SortOrder int,
	@DCID int,
	@CreatedBy CHAR(100)
AS
BEGIN
	
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		IF EXISTS(SELECT DropPoint from RouteMaster where DropPoint=@DropPoint and RouteName=@RouteName and SortOrder=@SortOrder)
		return -1
		else
		-- Update statements for procedure here
		UPDATE Routemaster
		SET RouteName = @RouteName,DropPoint = @DropPoint,SortOrder=@SortOrder,DCID = @DCID,CreatedBy = @CreatedBy,CreatedDate=GETDATE()
		WHERE DPID=@DPID
		
		return 1
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END



GO


