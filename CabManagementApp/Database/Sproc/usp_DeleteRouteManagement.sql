USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_DeleteRouteManagement]    Script Date: 3/25/2015 11:20:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_DeleteRouteManagement')
DROP PROCEDURE [dbo].[usp_DeleteRouteManagement]
GO
CREATE procedure [dbo].[usp_DeleteRouteManagement]
(
@ID int,
@IsActive BIT,
@ModifiedBy CHAR(20)
)
as
begin
update [RouteManagement] set IsActive=@IsActive, ModifiedBy=@ModifiedBy where ID=@ID
end


GO


