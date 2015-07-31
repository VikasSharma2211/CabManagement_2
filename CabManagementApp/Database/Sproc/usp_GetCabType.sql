USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetCabType]    Script Date: 3/25/2015 11:22:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetCabType')
DROP PROCEDURE [dbo].[usp_GetCabType]
GO

 CREATE procedure   [dbo].[usp_GetCabType]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Select statements for procedure here
		SELECT CabName from CabType  [NoLock]
		WHERE IsActive = 1;

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO


