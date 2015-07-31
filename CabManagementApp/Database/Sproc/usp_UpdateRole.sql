USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateRole]    Script Date: 3/25/2015 11:38:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateRole')
DROP PROCEDURE [dbo].[usp_UpdateRole]
GO 
CREATE procedure [dbo].[usp_UpdateRole]
@RoleId INT,
@IsActive BIT,
@ModifyBy varchar(100),
@RoleName varchar(100),
@RoleAccess char(30)


AS
BEGIN
	  UPDATE RolesManagement SET RoleName=@RoleName, RoleAccess=@RoleAccess, IsActive=@IsActive,ModifiedDate=CONVERT(DATE,GETDATE()),ModifiedBy=@ModifyBy WHERE RoleId=@RoleId    
	   
END
GO


