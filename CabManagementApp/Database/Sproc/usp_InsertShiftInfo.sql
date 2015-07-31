USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertShiftInfo]    Script Date: 3/25/2015 11:34:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertShiftInfo')
DROP PROCEDURE [dbo].[usp_InsertShiftInfo]
GO  

CREATE PROCEDURE [dbo].[usp_InsertShiftInfo]
	@ShiftType char(8),
	@ShiftCategory VARCHAR(50),
	@ShiftTime time(7),
	@DCID int,
	@CreatedBy char(20),
	@Result VARCHAR(50) OUT
	

	AS
if exists(select ShiftType,ShiftTime from ShiftManagement where ShiftType=@ShiftType and ShiftTime=@ShiftTime and DCID=@DCID)
BEGIN
SET @Result='Exists';
END
ELSE
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	INSERT  into ShiftManagement(ShiftType,ShiftCategory,ShiftTime,DCID,CreatedDate,CreatedBy) 
	values(@ShiftType,@ShiftCategory,@ShiftTime,@DCID,CONVERT(DATE,GETDATE()),@CreatedBy)
	
	
	
	

if @@error=0 
return 0
else
return -1

	
END
GO


