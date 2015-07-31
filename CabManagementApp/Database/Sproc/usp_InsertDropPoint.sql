USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertDropPoint]    Script Date: 3/25/2015 11:32:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Manish_Jhamb>
-- Create date: <Oct. 10,2014>
-- Description:	<Create a new Route>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertDropPoint')
DROP PROCEDURE [dbo].[usp_InsertDropPoint]
GO  

CREATE PROCEDURE [dbo].[usp_InsertDropPoint] 
	@RouteID int,
	@RouteName VARCHAR(50),
	@DropPoint VARCHAR(50),
	@SortOrder int,
	@DCID int,
	@CreatedBy VARCHAR(50)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		DECLARE @maxSortOrder INT;
		-- Insert statements for procedure here
		if exists(select TOP(1) RouteID from routemaster where RouteName=@RouteName and DropPoint is null AND DCID=@DCID)
			begin

				SELECT @maxSortOrder = MAX(SortOrder) FROM RouteMaster WHERE RouteName=@RouteName and DropPoint is null AND DCID=@DCID;
				IF(@maxSortOrder IS NULL)
					SET @maxSortOrder = 0;
				IF(@maxSortOrder<@SortOrder)
					BEGIN
						SET @SortOrder=@maxSortOrder+1;
						update routemaster set DropPoint=@DropPoint,SortOrder=@SortOrder,CreatedBy=@CreatedBy,CreatedDate=GETDATE() where RouteName=@RouteName AND DCID=@DCID and DropPoint is null
						return 2;
					END
				ELSE
					BEGIN
						UPDATE RouteMaster SET SortOrder = SortOrder+1 WHERE  RouteID=@RouteID AND DCID=@DCID AND SortOrder >= @SortOrder AND DropPoint is NOT null
						UPDATE RouteMaster SET SortOrder = @SortOrder WHERE   RouteID=@RouteID AND DCID=@DCID  AND DropPoint is null
					END

				
			end
		else 
			begin
				SELECT @maxSortOrder = MAX(SortOrder) FROM RouteMaster WHERE RouteName=@RouteName AND DCID=@DCID;
				IF NOT EXISTS(Select DropPoint from Routemaster where RouteID=@RouteID and DCID=@DCID and DropPoint=@DropPoint)
				IF(@maxSortOrder<@SortOrder)
					BEGIN
						SET @SortOrder=@maxSortOrder+1;
						INSERT INTO routemaster
						(RouteID,RouteName,DropPoint,SortOrder,DCID,CreatedDate,CreatedBy)
						VALUES
						(@RouteID,@RouteName,@DropPoint,@SortOrder,@DCID,GETDATE(),@CreatedBy)
						return 1;
					END
				ELSE
					BEGIN
						UPDATE RouteMaster SET SortOrder = SortOrder+1 WHERE  RouteID=@RouteID AND DCID=@DCID AND SortOrder >= @SortOrder 
						INSERT INTO routemaster
						(RouteID,RouteName,DropPoint,SortOrder,DCID,CreatedDate,CreatedBy)
						VALUES
						(@RouteID,@RouteName,@DropPoint,@SortOrder,@DCID,GETDATE(),@CreatedBy)
						return 1;
					END
				ELSE 
					BEGIN
					return -3;
					END
				
			end
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END





GO


