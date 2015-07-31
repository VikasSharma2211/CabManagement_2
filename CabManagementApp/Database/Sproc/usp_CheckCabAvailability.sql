USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_CheckCabAvailability]    Script Date: 3/25/2015 11:41:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_CheckCabAvailability')
DROP PROCEDURE [dbo].[usp_CheckCabAvailability]
GO



CREATE PROCEDURE [dbo].[usp_CheckCabAvailability]	
	-- Add the parameters for the stored procedure here
	@CabNumber VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS
            (SELECT * FROM CabManagement 
             WHERE CONCAT(LTRIM(RTRIM(REPLACE(CabNumberFirst,' ',''))),LTRIM(REPLACE(CabNumberLast,' ',''))) = @CabNumber
            )
            SELECT 'true'
      ELSE
            SELECT 'false'

   
END

GO


