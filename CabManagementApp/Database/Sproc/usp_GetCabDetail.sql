USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetCabDetail]    Script Date: 3/25/2015 11:21:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Nitin_kumar31>
-- Create date: <Nov. 05,2014>
-- Description:	<Get CabDetail from CabManagement>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetCabDetail')
DROP PROCEDURE [dbo].[usp_GetCabDetail]
GO


	CREATE PROCEDURE [dbo].[usp_GetCabDetail]
	@CabId INT = NULL,
	@IsActive BIT = NULL
	AS
	BEGIN
		BEGIN TRY
		-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
					SET NOCOUNT ON;
					-- Select statements for procedure 
					SELECT 
						   d.DCName
						  ,Cm.CabNumberFirst
						  ,Cm.CabNumberLast
						  ,Cm.DocumentsVerified
						  ,Vm.VendorName
						  ,Cm.CabType
						  ,Cm.CabCapacity
						  ,DD.DriverName
						  ,Cm.EmpanelDate
						  ,Cm.Comment
						  ,Cm.IsActive--(CASE WHEN Cm.IsActive= '1' THEN 'True' Else 'False'  END) as [IsActive]
						  ,Cm.IsActiveComment
                          ,Cm.CabId
					  FROM CabManagement Cm
						  LEFT JOIN VendorManagement Vm
					  ON  Cm.VendorID=Vm.VendorID JOIN DC D on Vm.DCID=d.DCID JOIN DriverDetails DD ON Cm.DriverId=DD.DriverId
					  WHERE (Cm.CabId = @CabId OR @CabId IS NULL) AND (Cm.IsActive = @IsActive OR @IsActive IS NULL) 
			END TRY
	BEGIN CATCH
	THROW;
	END CATCH
	END
GO


