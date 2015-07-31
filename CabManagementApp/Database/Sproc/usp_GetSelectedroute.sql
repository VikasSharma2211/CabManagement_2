USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetSelectedroute]    Script Date: 3/25/2015 11:29:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================

-- Author:		<Manish_Jhamb>

-- Create date: <Oct. 10,2014>

-- Description:	<Create a new Route>

-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetSelectedroute')
DROP PROCEDURE [dbo].[usp_GetSelectedroute]
GO
CREATE PROCEDURE [dbo].[usp_GetSelectedroute]

@DCID int	

AS

BEGIN

	SET NOCOUNT ON;



   BEGIN TRY 

		SET NOCOUNT ON;





		select distinct(RouteName) as RouteName,RouteID from RouteNumber Where IsActive=1 and DCID=@DCID;



	END TRY

	BEGIN CATCH

		THROW;

	END CATCH

END


GO


