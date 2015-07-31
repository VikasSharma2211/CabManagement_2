USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateVendor]    Script Date: 3/25/2015 11:39:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Manu_jaggi>
-- Create date: <Oct. 08,2014>
-- Description:	<Make Modification in vendor>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateVendor')
DROP PROCEDURE [dbo].[usp_UpdateVendor]
GO 
CREATE PROCEDURE [dbo].[usp_UpdateVendor] 
	-- Add the parameters for the stored procedure here
	@VendorID INT,
	@VendorName CHAR(50),
	@Address VARCHAR(50),
	@City VARCHAR(50),
	@EmpanelDate DATETIME,
	@DCID INT,
	@Comment VARCHAR(300),
	@ModifiedBy CHAR(20)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		--IF EXISTS(SELECT @VendorName from VendorManagement where VendorName=@VendorName and DCID=@DCID)
		--return -1
		---- Update statements for procedure here
		--ELSE
		UPDATE VendorManagement
		SET VendorName = @VendorName,Address = @Address,City = @City,EmpanelDate = @EmpanelDate,DCID = @DCID,Comment = @Comment,ModifiedBy = @ModifiedBy,ModifiedDate=GETDATE()
		WHERE VendorID = @VendorID
		return 1
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO


