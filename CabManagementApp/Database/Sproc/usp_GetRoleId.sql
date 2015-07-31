USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetRoleId]    Script Date: 3/25/2015 11:27:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetRoleId')
DROP PROCEDURE [dbo].[usp_GetRoleId]
GO

CREATE PROCEDURE [dbo].[usp_GetRoleId]
@RoleName VARCHAR(100),
@RoleId VARCHAR(50) OUT
AS
BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
		SET  @RoleId=(SELECT RoleAccess FROM RolesManagement WHERE RoleName=@RoleName and IsActive='1');
		IF(@RoleId IS NULL)
		SET @RoleId = 6 --6 for normal userrole Deafault
		END TRY
		BEGIN CATCH
		THROW;
		END CATCH
END
GO


