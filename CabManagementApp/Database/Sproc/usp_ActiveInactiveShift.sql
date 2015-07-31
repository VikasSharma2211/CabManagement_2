USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_ActiveInactiveShift]    Script Date: 3/25/2015 11:18:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_ActiveInactiveShift')
DROP PROCEDURE [dbo].[usp_ActiveInactiveShift]
GO

CREATE PROCEDURE [dbo].[usp_ActiveInactiveShift](@ShiftIds VARCHAR(50),@IsActive bit,@ModifiedBy char(20))
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE ShiftManagement SET IsActive=@IsActive,ModifiedBy=@ModifiedBy,ModifiedDate=getdate() WHERE ShiftId in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@ShiftIds));
if @@error=0 
return 0
else
return -1
END

GO


