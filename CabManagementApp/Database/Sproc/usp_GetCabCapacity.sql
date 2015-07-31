USE [CabTransport]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCabCapacity]    Script Date: 3/30/2015 2:07:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nitin_kumar31>
-- Create date: <Nov. 06,2014>
-- Description:	<Get CabCapcity from CabCapacity>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetCabCapacity')
DROP PROCEDURE [dbo].[usp_GetCabCapacity]
GO
CREATE procedure   [dbo].[usp_GetCabCapacity]
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
		SELECT CabCapacity from [09_CabCapacity]  [Nolock]; 
		

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END