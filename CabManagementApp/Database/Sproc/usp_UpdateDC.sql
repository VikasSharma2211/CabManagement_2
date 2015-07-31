USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateDC]    Script Date: 3/25/2015 11:52:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateDC')
DROP PROCEDURE [dbo].[usp_UpdateDC]
GO 
CREATE procedure [dbo].[usp_UpdateDC]
@DCId INT,
@IsActive BIT,
@ModifyBy varchar(100),
@DCName varchar(100),
@Result VARCHAR(50) OUT


AS
BEGIN
		--IF EXISTS(SELECT * FROM DC where DCName = @DCName)
		--	BEGIN
		--		 SET @Result='Exists';
		--	END
		--ELSE
			BEGIN
				 
				 UPDATE DC SET DCName=@DCName, IsActive=@IsActive,ModifiedDate=GETDATE(),ModifiedBy=@ModifyBy WHERE DCId=@DCId    
				
			END
END
GO

