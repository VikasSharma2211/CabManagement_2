USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_DeleteDC]    Script Date: 3/25/2015 11:42:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_DeleteDC')
DROP PROCEDURE [dbo].[usp_DeleteDC]
GO


CREATE procedure [dbo].[usp_DeleteDC]
@DCId INT,
@IsActive BIT,
@ModifyBy varchar(100),
@DCName varchar(100)
AS
BEGIN
     SET NOCOUNT ON;
	  UPDATE DC SET  IsActive=@IsActive,ModifiedDate=CONVERT(DATE,GETDATE()),ModifiedBy=@ModifyBy,DCName=@DCName 
	   WHERE DCId in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@DCId));
	   
END




select * from dc
GO


