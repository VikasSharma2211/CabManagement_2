USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateProperty]    Script Date: 3/25/2015 11:37:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateProperty')
DROP PROCEDURE [dbo].[usp_UpdateProperty]
GO 
Create PROCEDURE [dbo].[usp_UpdateProperty] 
	-- Add the parameters for the stored procedure here
	@PropertyID INT,
	@PropertyName VARCHAR(50),
	@IsCompulsory BIT,
	@ModifiedBy VARCHAR(20)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Update statements for procedure here
		UPDATE CabProperty
		SET PropertyName = @PropertyName,IsCompulsory=@IsCompulsory,ModifiedBy = @ModifiedBy,ModifiedDate=GETDATE()
		WHERE PropertyId = @PropertyID

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


