USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[VerifyDOCExpiryDate]    Script Date: 3/25/2015 11:39:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'VerifyDOCExpiryDate')
DROP PROCEDURE [dbo].[VerifyDOCExpiryDate]
GO 

CREATE PROCEDURE [dbo].[VerifyDOCExpiryDate]
AS
BEGIN
	SELECT distinct(CV.CabId)
	INTO #temp
	FROM CabVerification CV
		 RIGHT JOIN 
		 CabProperty CP 
		 ON CV.PropertyId = CP.PropertyId
		 WHERE (CV.ExpiryDate IS NULL OR CV.ExpiryDate < CONVERT(DATE,GETDATE())) 
				AND CP.IsCompulsory = 1 
				AND CP.IsActive = 1

	

	UPDATE CabManagement SET DocumentsVerified = 0 WHERE CabId IN (SELECT CabId FROM #temp)

	DROP TABLE #temp

END
GO


