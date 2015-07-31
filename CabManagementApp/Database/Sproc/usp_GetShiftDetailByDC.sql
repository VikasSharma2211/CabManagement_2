USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetShiftDetailByDC]    Script Date: 3/25/2015 11:30:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
  
-- Author:  <piyush_rana>  
  
-- Create date: <jan 15,2014>  
  
-- Description: <Create a new Route>  
  
-- =============================================  
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetShiftDetailByDC')
DROP PROCEDURE [dbo].[usp_GetShiftDetailByDC]
GO  
CREATE PROCEDURE [dbo].[usp_GetShiftDetailByDC]  
  
@DCID int ,  
@ShiftType CHAR(8) = NULL , 
  @RequestType char(8)=null
  
AS  
  
BEGIN  
  
 SET NOCOUNT ON;   
  
  
  
   BEGIN TRY   
  
  
  select ShiftId,ShiftType,ShiftTime,ShiftCategory from ShiftManagement Where IsActive=1 and DCID=@DCID  
  AND (ShiftType = @ShiftType OR @ShiftType IS NULL)   AND (ShiftCategory = @RequestType OR @RequestType IS NULL) 
  
  
  
 END TRY  
  
 BEGIN CATCH  
  
  THROW;  
  
 END CATCH  
  
END  
GO


