USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetCabProperty]    Script Date: 3/25/2015 11:22:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nitin_kumar31>
-- Create date: <Nov. 06,2014>
-- Description:	<Get CabCabProperty from CabProperty>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetCabProperty')
DROP PROCEDURE [dbo].[usp_GetCabProperty]
GO

CREATE PROCEDURE [dbo].[usp_GetCabProperty]
(
@PropertyId INT = NULL,
@IsActive BIT = NULL
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT PropertyId,PropertyName,IsCompulsory,IsActive,CreatedBy FROM CabProperty
	WHERE  (PropertyId = @PropertyId OR  @PropertyId IS NULL) AND  (IsActive = @IsActive OR @IsActive IS NULL);
END

GO


