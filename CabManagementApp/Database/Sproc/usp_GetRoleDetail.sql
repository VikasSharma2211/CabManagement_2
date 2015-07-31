USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetRoleDetail]    Script Date: 3/25/2015 11:27:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetRoleDetail')
DROP PROCEDURE [dbo].[usp_GetRoleDetail]
GO


CREATE procedure [dbo].[usp_GetRoleDetail]
AS
BEGIN
	  SELECT  rm.RoleId,rm.RoleName,rt.RoleType as [RoleAccess],CONVERT(VARCHAR, rm.CreatedDate, 107) AS CreatedDate,rm.CreatedBy,
	  CONVERT(VARCHAR, ModifiedDate, 107) AS ModifiedDate ,ModifiedBy,IsActive   
	  FROM RolesManagement rm
	  INNER JOIN RoleType rt
	  on rm.RoleAccess=rt.RoletypeId where rm.IsActive='1'
END
GO


