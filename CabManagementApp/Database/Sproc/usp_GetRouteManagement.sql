USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetRouteManagement]    Script Date: 3/25/2015 11:28:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetRouteManagement')
DROP PROCEDURE [dbo].[usp_GetRouteManagement]
GO
Create Procedure [dbo].[usp_GetRouteManagement]
as
begin

select * from RouteManagement rm 
join ShiftManagement sm on sm.ShiftID=rm.ShiftId
join CabManagement cm on cm.CabId = rm.CabID

end
GO


