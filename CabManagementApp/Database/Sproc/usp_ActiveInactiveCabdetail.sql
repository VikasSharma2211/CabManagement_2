USE [CabTransport]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActiveInactiveCabdetail]    Script Date: 3/25/2015 6:34:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_ActiveInactiveCabdetail')
DROP PROCEDURE [dbo].[usp_ActiveInactiveCabdetail]
GO
	CREATE PROCEDURE [dbo].[usp_ActiveInactiveCabdetail]
	@CabId  varchar(100),
	@IsActive BIT,
	@IsActiveComment  VARCHAR(100),
	@ModifiedBy VARCHAR(50)
	AS
		BEGIN

			BEGIN TRY
				    BEGIN TRANSACTION
					-- SET NOCOUNT ON added to prevent extra result sets from
					-- interfering with SELECT statements.
						SET NOCOUNT ON;
						-- UPDATE CabManagement ActiveNonActive Status and Comment
						UPDATE CabManagement SET IsActive=@IsActive ,IsActiveComment=@IsActiveComment,ModifiedBy=@ModifiedBy,ModifiedDate=CONVERT(DATE,GETDATE())
						WHERE CabId in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@CabId));
						-- UPDATE CabVerification ActiveNonActive Status
						UPDATE CabVerification SET IsActive=@IsActive,ModifiedBy=@ModifiedBy,ModifiedDate=CONVERT(DATE,GETDATE())
						WHERE CabId in (select  outvalue from dbo.[UDF_SEPARATE_CSV] (@CabId));
				    COMMIT
			
			END TRY
			BEGIN CATCH
						ROLLBACK;
						THROW;
			END CATCH


	     END