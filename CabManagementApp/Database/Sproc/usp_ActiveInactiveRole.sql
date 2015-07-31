USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_ActiveInactiveRole]    Script Date: 3/25/2015 11:17:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_ActiveInactiveRole')
DROP PROCEDURE [dbo].[usp_ActiveInactiveRole]
GO
CREATE procedure [dbo].[usp_ActiveInactiveRole]
@RoleId varchar(2000),
@IsActive BIT,
@ModifyBy varchar(100)

AS
BEGIN
     SET NOCOUNT ON;
	  UPDATE RolesManagement SET  IsActive=@IsActive,ModifiedDate=CONVERT(DATE,GETDATE()),ModifiedBy=@ModifyBy 
	   WHERE RoleId in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@RoleId));
	   
END
GO


