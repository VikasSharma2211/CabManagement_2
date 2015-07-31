USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetRosterDetail]    Script Date: 3/25/2015 11:48:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hina tyagi
-- Create date: 19-01-2015
-- Description:	<Description,,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_GetRosterDetail')
DROP PROCEDURE [dbo].[usp_GetRosterDetail]
GO

CREATE PROCEDURE [dbo].[usp_GetRosterDetail]
	-- Add the parameters for the stored procedure here
@Prefix int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select RoasterManagement.*
 from RoasterNoCreation
 inner join RoasterManagement
  on RoasterNoCreation.RosterNo=RoasterManagement.RosterNo
  where PreFix=@Prefix
END

GO


