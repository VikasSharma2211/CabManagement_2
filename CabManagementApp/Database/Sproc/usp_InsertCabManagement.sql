USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertCabManagement]    Script Date: 3/25/2015 11:31:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nitin_kumar31,Nitin>
-- Create date: <Nov 7,2014>
-- Description:	<FOR INSERT RECORD IN CABMANAGEMENt>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertCabManagement')
DROP PROCEDURE [dbo].[usp_InsertCabManagement]
GO  
CREATE PROCEDURE [dbo].[usp_InsertCabManagement]
	(
		@CabNumberFirst CHAR(10),
		@CabNumberLast CHAR(10),
		@DocumentsVerified BIT,
		@VendorID INT,
		@CabType CHAR(20),
		@CabCapacity SMALLINT,
		@DriverId VARCHAR(50),
		@EmpanelDate DATETIME,
		@CreatedBy CHAR(20),
		@TableVar UDT_CabPropertyy READONLY,
		@IsActive BIT,
		@Comment VARCHAR(300),
	    @CabId int OUT,
		@Result VARCHAR(50) OUT
	)
AS
BEGIN
	BEGIN TRY 
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
			BEGIN TRANSACTION
			            
						DECLARE @CabNumber as CHAR(20)
						DECLARE @dbCabNumber as CHAR(20)
						SET @CabNumber=RTRIM(@CabNumberFirst)+RTRIM(@CabNumberLast)
						SET @dbCabNumber=(SELECT (RTRIM(CabNumberFirst)+ RTRIM(CabNumberLast))
						 FROM CabManagement WHERE (RTRIM(CabNumberFirst)+ RTRIM(CabNumberLast))=@CabNumber )

			           IF @dbCabNumber IS NULL --@dbCabNumber<>@CabNumber
					   BEGIN
							DECLARE @CheckExpDateCount INT = 0; 
							SELECT @CheckExpDateCount = COUNT(PropertyId) FROM  @TableVar WHERE ExpiryDate<CONVERT(DATE,GETDATE()) AND IsCompulsory = 1

							if(@CheckExpDateCount>0)
							BEGIN
								SET @DocumentsVerified = 0
							END
							ELSE
							BEGIN
								SET @DocumentsVerified = 1
							END
						   -- Insert statements for procedure here
							INSERT INTO CabManagement
							(CabNumberFirst,CabNumberLast,DocumentsVerified,VendorID,CabType,CabCapacity,DriverId,EmpanelDate,IsActive,Comment,CreatedBy,CreatedDate)
							VALUES
							(@CabNumberFirst,@CabNumberLast,@DocumentsVerified,@VendorID,@CabType,@CabCapacity,@DriverId,@EmpanelDate,@IsActive,@Comment,@CreatedBy,CONVERT(DATE,GETDATE()))
	     
							 SET @CabId=SCOPE_IDENTITY()
							 DECLARE @INTIALVAL AS INT=1
							 DECLARE @MAXVAL AS INT
							 DECLARE @PROPERTYID AS INT
							 DECLARE @ExpiryDate AS DATE
							 DECLARE @propIsActive AS BIT
							 SET @MAXVAL =(SELECT COUNT(PropertyId) FROM @TableVar)
		
							 CREATE TABLE #PropertyDetails
							 (RowID INT IDENTITY,tmpPropertyID INT,tmpExpiryDate DATE, tmpIsCompulsory BIT)
		
							 INSERT INTO #PropertyDetails
							 (tmpPropertyID,tmpExpiryDate,tmpIsCompulsory)
							 (SELECT PropertyId,ExpiryDate,IsCompulsory FROM @TableVar )


							WHILE (@INTIALVAL<=@MAXVAL)
							BEGIN
									 SELECT  @PROPERTYID= tmpPropertyID ,@ExpiryDate=tmpExpiryDate FROM #PropertyDetails WHERE RowID=@INTIALVAL
				
									 IF(@ExpiryDate is null OR @ExpiryDate = '')
									 BEGIN
										SET @propIsActive=1
									 END
									 ELSE
									 BEGIN
										IF(@ExpiryDate>=CONVERT(DATE,GETDATE()))
									 BEGIN
										SET @propIsActive=1
									 END
									 ELSE
									 BEGIN
										SET @propIsActive=0
									 END
									 END
									 
									  IF(@ExpiryDate is null OR @ExpiryDate = '')
									 BEGIN
										INSERT INTO CabVerification
										(CabId,PropertyId,ExpiryDate,IsActive,CreatedDate,CreatedBy,ModifiedBy,ModifiedDate)
										VALUES(@CabId,@PROPERTYID,NULL,@propIsActive,CONVERT(DATE,GETDATE()),@CreatedBy,NULL,NULL)
									 END
									 ELSE
									 BEGIN
										INSERT INTO CabVerification
										(CabId,PropertyId,ExpiryDate,IsActive,CreatedDate,CreatedBy,ModifiedBy,ModifiedDate)
										VALUES(@CabId,@PROPERTYID,@ExpiryDate,@propIsActive,CONVERT(DATE,GETDATE()),@CreatedBy,NULL,NULL)
									 END

									 
									 SET @INTIALVAL=@INTIALVAL+1
							END
						END
		                ELSE
						BEGIN
							SET @Result='EXIST'
						END
						--DROP TABLE #PropertyDetails
			COMMIT

	END TRY

	BEGIN CATCH
		ROLLBACK;
		THROW;
	END CATCH
END

GO


