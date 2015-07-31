USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertRouteManagemnet]    Script Date: 3/25/2015 11:34:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertRouteManagemnet')
DROP PROCEDURE [dbo].[usp_InsertRouteManagemnet]
GO  

CREATE Procedure [dbo].[usp_InsertRouteManagemnet]
(
@Date datetime,
@EmployeeID int,
@EmployeeName char(50),
@Address char(100),
@Route int,
@ShiftID int,
@CabID int,
@CreatedBy char(50)
)
as
insert into [RouteManagement](Date,EmployeeID,EmployeeName,Address,Route,ShiftID,CabID,CreatedDate
,CreatedBy) 
values 
(@Date,@EmployeeID,@EmployeeName,@Address,@Route,@ShiftID,@CabID,getdate(),@CreatedBy)
return scope_identity()
GO


