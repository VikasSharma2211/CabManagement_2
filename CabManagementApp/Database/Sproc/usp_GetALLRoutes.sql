USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetALLRoutes]    Script Date: 3/25/2015 11:21:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Manish_Jhamb>
-- Create date: <Oct. 10,2014>
-- Description:	<Create a new Route>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetALLRoutes')
DROP PROCEDURE [dbo].[usp_GetALLRoutes]
GO

CREATE PROCEDURE [dbo].[usp_GetALLRoutes]	
	@RouteID INT = NULL,
	@DCID INT = NULL,
	@IsActive BIT = NULL
AS
BEGIN
	SET NOCOUNT ON;

   BEGIN TRY 
		SET NOCOUNT ON;


		--select rm.RouteID,rm.RouteName,rm.DropPoint,rm.SortOrder,rm.IsActive,rm.CreatedBy,d.DCName,d.DCID from routemaster rm
		--join DC d on rm.DCID=d.DCID 
		--WHERE (rm.RouteID = @RouteID OR @RouteID IS NULL) AND (rm.IsActive = @IsActive OR @IsActive IS NULL) AND (rm.DCID = @DCID OR @DCID IS NULL)
		--ORDER BY rm.RouteID DESC

		--SELECT rn.RouteID,rn.RouteName,rm.DropPoint,rm.SortOrder,d.DCName,rm.IsActive,rm.CreatedBy,rm.DCID 
		--FROM RouteNumber rn left outer join RouteMaster rm on
		--	rn.RouteID=rm.RouteID join DC d on rm.DCID=d.DCID 
		--ORDER BY rm.RouteID DESC

		--SELECT rn.RouteID,rn.RouteName,rm.DropPoint,rm.SortOrder,rm.IsActive,rm.CreatedBy,rm.DCID FROM RouteNumber rn left outer join RouteMaster rm on
		--rn.RouteID=rm.RouteID 
		--ORDER BY rm.RouteID DESC

		SELECT	rm.DPID,
				rn.RouteID,
				rn.RouteName,
				rm.DropPoint,
				rm.SortOrder,
				dc.DCName,
				CASE WHEN rm.IsActive IS NULL THEN 0 ELSE rm.IsActive end as IsActive,
				rm.CreatedBy,
				rn.DCID 
		FROM	RouteNumber rn
		LEFT JOIN	RouteMaster rm on
					rn.RouteID = rm.RouteID
		LEFT JOIN	DC dc on
				rn.DCID = dc.DCID
		WHERE
			CASE WHEN rm.IsActive IS NULL THEN 0 ELSE rm.IsActive end = CASE WHEN @IsActive IS NULL THEN 0 ELSE @IsActive end 
		ORDER BY rm.DPID ASC


	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END



GO


