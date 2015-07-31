USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertVendor]    Script Date: 3/25/2015 11:35:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Manu_jaggi>
-- Create date: <Oct. 08,2014>
-- Description:	<Create a new vendor>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertVendor')
DROP PROCEDURE [dbo].[usp_InsertVendor]
GO  

CREATE PROCEDURE [dbo].[usp_InsertVendor] 
	-- Add the parameters for the stored procedure here
	@VendorName CHAR(50),
	@Address VARCHAR(50),
	@City VARCHAR(50),
	@EmpanelDate DATETIME,
	@DCID INT,
	@Comment VARCHAR(300),
	@CreatedBy CHAR(20)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		IF EXISTS(SELECT VendorName From VendorManagement Where VendorName=@VendorName and DCID=@DCID)
		return -1
		else
		-- Insert statements for procedure here
		INSERT INTO VendorManagement
		(VendorName,Address,City,EmpanelDate,DCID,Comment,CreatedBy,CreatedDate)
		VALUES
		(@VendorName,@Address,@City,@EmpanelDate,@DCID,@Comment,@CreatedBy,GETDATE())
		RETURN 1
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END



GO


GO



