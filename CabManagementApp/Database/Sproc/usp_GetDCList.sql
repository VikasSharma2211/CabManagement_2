USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetDCList]    Script Date: 3/25/2015 11:24:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetDCList')
DROP PROCEDURE [dbo].[usp_GetDCList]
GO
CREATE PROCEDURE [dbo].[usp_GetDCList]	
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
		SELECT * from DC ORDER BY DCID;

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

GO


