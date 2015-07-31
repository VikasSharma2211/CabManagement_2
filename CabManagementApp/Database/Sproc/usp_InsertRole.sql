USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertRole]    Script Date: 3/25/2015 7:39:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertRole')
DROP PROCEDURE [dbo].[usp_InsertRole]
GO  


CREATE procedure [dbo].[usp_InsertRole]
@RoleName varchar(40),
@RoleAccess varchar(40),
@IsActive BIT,
@CreatedBy varchar(100)

As
BEGIN
        SET NOCOUNT ON;
		BEGIN TRY
		IF EXISTS(Select RoleName from RolesManagement where RoleName=@RoleName)
		return -1
		else
		INSERT INTO RolesManagement(RoleName,RoleAccess,CreatedDate,CreatedBy,IsActive)
		VALUES(@RoleName,@RoleAccess,CONVERT(DATE,GETDATE()),@CreatedBy,@IsActive);
		RETURN 1
		
		END TRY
		BEGIN CATCH
		 THROW;
		END CATCH

END


GO


