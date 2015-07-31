USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetRoleType]    Script Date: 3/25/2015 11:28:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetRoleType')
DROP PROCEDURE [dbo].[usp_GetRoleType]
GO

Create procedure [dbo].[usp_GetRoleType]
AS
BEGIN
	  SELECT  RoleTypeId ,RoleType     
	  FROM RoleType;
END
GO


