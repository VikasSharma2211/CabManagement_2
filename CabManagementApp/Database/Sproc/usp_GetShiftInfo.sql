USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetShiftInfo]    Script Date: 3/25/2015 11:30:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetShiftInfo')
DROP PROCEDURE [dbo].[usp_GetShiftInfo]
GO  
CREATE PROCEDURE [dbo].[usp_GetShiftInfo]
	@ShiftId INT = NULL,
	@ShiftType VARCHAR(10) = NULL,
	@ShiftCategory VARCHAR(50) = NULL,
	@IsActive BIT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT sm.ShiftId,sm.ShiftType,sm.ShiftCategory,sm.ShiftTime,dc.DCName,sm.IsActive
	 FROM ShiftManagement sm
	 INNER JOIN DC dc
	 ON sm.DCID=dc.DCID
	 WHERE (sm.ShiftId = @ShiftId OR @ShiftId IS NULL) AND (sm.IsActive = @IsActive OR @IsActive IS NULL)
	 AND (sm.ShiftType = @ShiftType OR @ShiftType IS NULL) AND (sm.ShiftCategory = @ShiftCategory OR @ShiftCategory IS NULL)
	 ORDER BY sm.ShiftId DESC

if @@error=0 
return 0
else
return -1
END

GO


