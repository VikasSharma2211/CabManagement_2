USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateShiftInfo]    Script Date: 3/25/2015 11:38:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateShiftInfo')
DROP PROCEDURE [dbo].[usp_UpdateShiftInfo]
GO 

CREATE PROCEDURE [dbo].[usp_UpdateShiftInfo](@ShiftId int,@ShiftCategory VARCHAR(50),@ShiftType char(8),@ShiftTime time(7),@DCID int,@ModifiedBy char(20),@Result VARCHAR(50) OUT)
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if exists(select TOP(1) ShiftId from ShiftManagement where ShiftType=@ShiftType and ShiftTime=@ShiftTime and DCID=@DCID AND ShiftId !=@ShiftId)
	BEGIN
		SET @Result='Exists';
	END
ELSE
	BEGIN
		 -- Insert statements for procedure here
	UPDATE ShiftManagement SET ShiftCategory=@ShiftCategory,ShiftType=@ShiftType,ShiftTime=@ShiftTime,DCID=@DCID,ModifiedDate=getdate(),ModifiedBy=@ModifiedBy WHERE ShiftId=@ShiftId
	END
   
if @@error=0 
return 0
else
return -1
END

GO


