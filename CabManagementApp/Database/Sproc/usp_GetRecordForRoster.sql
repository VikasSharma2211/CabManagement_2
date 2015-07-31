USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetRecordForRoster]    Script Date: 3/25/2015 11:26:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetRecordForRoster')
DROP PROCEDURE [dbo].[usp_GetRecordForRoster]
GO

  CREATE PROCEDURE [dbo].[usp_GetRecordForRoster]

  AS
  BEGIN

	  BEGIN TRY 
	              SET NOCOUNT ON;
				   
				  SELECT (RTRIM(LTRIM(CabNumberFirst))+ LTRIM(RTRIM(CabNumberLast)) ) AS CabNo from  cabmanagement --Combine Cab No
  
				  SELECT RouteName from RouteMaster --Route Name

				  SELECT CAST(CabCapacity as varchar(20)) as CabCapacity, (RTRIM(LTRIM(CabNumberFirst))+ LTRIM(RTRIM(CabNumberLast)) ) AS CabNo, DocumentsVerified  from CabManagement

				  SELECT EmployeeNumber,EmployeeName,Gender,Address,RouteNO,LandmarkName,Contact,PickupDropTime as pickuptime,CabNo FROM RoasterManagement

	  END TRY
  
	 BEGIN CATCH
				 THROW;
	 END CATCH
  
  
  END

GO


