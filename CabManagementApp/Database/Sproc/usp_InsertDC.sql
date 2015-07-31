USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertDC]    Script Date: 3/25/2015 11:49:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertDC')
DROP PROCEDURE [dbo].[usp_InsertDC]
GO  

CREATE procedure [dbo].[usp_InsertDC]
@DCName varchar(40),
@IsActive BIT,
@CreatedBy varchar(100),
@Result VARCHAR(50) OUT


As
BEGIN
        SET NOCOUNT ON;
		BEGIN TRY
			IF EXISTS(SELECT * FROM DC where DCName = @DCName)
			BEGIN
				SET @Result='Exists'; --already exist
			END
			else 
			BEGIN
				INSERT INTO DC(DCName,IsActive, CreatedBy,CreatedDate)
				VALUES(@DCName,@IsActive,@CreatedBy,GETDATE());
			END
		END TRY
		
		BEGIN CATCH
		 THROW;
		END CATCH

END

GO


