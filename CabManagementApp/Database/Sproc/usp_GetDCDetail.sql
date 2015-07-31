USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetDCDetail]    Script Date: 3/25/2015 11:43:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetDCDetail')
DROP PROCEDURE [dbo].[usp_GetDCDetail]
GO
CREATE procedure [dbo].[usp_GetDCDetail]
AS
BEGIN
	  SELECT  DCId, DCName,CONVERT(VARCHAR, CreatedDate, 107) AS CreatedDate, CreatedBy,
	  CONVERT(VARCHAR, ModifiedDate, 107) AS ModifiedDate ,ModifiedBy,IsActive   
	  FROM [dbo].[DC]
END
GO


