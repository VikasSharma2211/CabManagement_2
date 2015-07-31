USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateRouteManagemnet]    Script Date: 3/25/2015 11:38:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateRouteManagemnet')
DROP PROCEDURE [dbo].[usp_UpdateRouteManagemnet]
GO 

CREATE Procedure [dbo].[usp_UpdateRouteManagemnet]

(
@ID int,

@Date datetime,

@EmployeeID int,

@EmployeeName char(50),

@Address char(100),

@Route int,

@ShiftID int,

@CabID int,

@ModifiedBy char(50)

)

as



begin



update [RouteManagement] set Date=@Date,EmployeeID=@EmployeeID,EmployeeName=@EmployeeName,
Address=@Address,Route=@Route,ShiftID=@ShiftID,CabID=@CabID,
ModifiedDate=getdate(),ModifiedBy=@ModifiedBy

end


GO


