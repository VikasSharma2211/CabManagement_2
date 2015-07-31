USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertRosterDetail]    Script Date: 3/25/2015 11:33:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertRosterDetail')
DROP PROCEDURE [dbo].[usp_InsertRosterDetail]
GO  


	CREATE PROCEDURE [dbo].[usp_InsertRosterDetail]
			
			--@Client VARCHAR(50),
			--@ProjectCode VARCHAR(50) ,
			--@PickupDropDate DATE ,
			--@TotalEmployee VARCHAR (50) ,
			--@RouteName VARCHAR (50) ,
			--@LandmarkName VARCHAR (50) ,
			--@TypeOfPickupDrop VARCHAR(50) ,
			--@ShiftTimings DATETIME ,
			--@CabType VARCHAR(50) ,
			--@Vendor VARCHAR(50) ,
			--@EndUser VARCHAR(50) ,
			--@Guard VARCHAR(50) ,
			--@CabNo VARCHAR(20),

		    @TableVar UDT_RoasterDetails READONLY

	 AS
	  DECLARE @LastInsertedPreFix VARCHAR(20)
	 BEGIN
		   BEGIN TRY
					 SET NOCOUNT ON;
					
					 SET @LastInsertedPreFix=(SELECT TOP 1 RosterNo FROM RoasterNoCreation where PreFix in (select top 1 prefix from RoasterNoCreation order by prefix desc ) ORDER BY convert(int,RosterNo) DESC)

												INSERT INTO RoasterManagement(RosterNo,Client,ProjectCode,PickupDropDate,EmployeeNumber,EmployeeName,Gender,Address,Area,RouteNO,LandmarkName,Contact,Pickupdroporder,PickupDropTime,Workingdays,Typeofpickup,TypeofDrop,ShiftTimings,CabNo,CabType,Vendor,EndUser,Guard)
												SELECT @LastInsertedPreFix,Client,ProjectCode,PickupDropDate,EmployeeNumber,EmployeeName,Gender,Address,Area,RouteNO,LandmarkName,Contact,Pickupdroporder,PickupDropTime,Workingdays,Typeofpickup,TypeofDrop,ShiftTimings,CabNo,CabType,Vendor,EndUser,Guard from @TableVar	 		

	
		   END TRY
		   BEGIN CATCH
				 THROW;
		   END CATCH
	 END





GO


