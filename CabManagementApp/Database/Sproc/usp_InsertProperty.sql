USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertProperty]    Script Date: 3/25/2015 6:19:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertProperty')
DROP PROCEDURE [dbo].[usp_InsertProperty]
GO  

CREATE PROCEDURE [dbo].[usp_InsertProperty] 
	-- Add the parameters for the stored procedure here
	@PropertyName VARCHAR(50),
	@IsCompulsory BIT,
	@CreatedBy VARCHAR(50)
	--@Result VARCHAR(100) OUT
AS
BEGIN
	
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		BEGIN TRY
			IF EXISTS(SELECT * FROM CabProperty where PropertyName = @PropertyName)
			BEGIN
				RETURN 0; --already exist
		END
		else 

		-- Insert statements for procedure here
			INSERT INTO CabProperty
			(PropertyName,IsCompulsory,IsActive,CreatedBy,CreatedDate)
			VALUES
			(@PropertyName,@IsCompulsory,1,@CreatedBy,GETDATE())
			RETURN 1;
		END TRY

	
	BEGIN CATCH
		THROW;
	END CATCH
END


GO


