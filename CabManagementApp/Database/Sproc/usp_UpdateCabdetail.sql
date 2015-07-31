USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_UpdateCabdetail]    Script Date: 3/25/2015 11:36:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Nitin_kumar31,Nitin>
-- Create date: <Nov 7,2014>
-- Description:	<FOR Update RECORD IN CABMANAGEMENT and CABVERIFICATION>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_UpdateCabdetail')
DROP PROCEDURE [dbo].[usp_UpdateCabdetail]
GO 

CREATE PROCEDURE [dbo].[usp_UpdateCabdetail]
@CabID VARCHAR(20),
@VendorId VARCHAR(20),
@CabNumberFirst VARCHAR(20),
@CabNumberLast VARCHAR(20),
@CabType VARCHAR(20),
@CabCapacity VARCHAR(20),
@Driverid int,
@DocumentVerified BIT,
@Empaneldate DATE,
@IsActive BIT,
@Comment VARCHAR(300),
@ModifiedBy VARCHAR(40) ,
@TableVar UDT_CabPropertyy READONLY
AS
BEGIN

		BEGIN TRY
				BEGIN TRANSACTION

			        	-- SET NOCOUNT ON added to prevent extra result sets from
		               -- interfering with SELECT statements.
					   SET NOCOUNT ON;

					   DECLARE @CheckExpDateCount INT = 0; 
							SELECT @CheckExpDateCount = COUNT(PropertyId) FROM  @TableVar WHERE ExpiryDate<CONVERT(DATE,GETDATE()) AND IsCompulsory = 1

							if(@CheckExpDateCount>0)
							BEGIN
								SET @DocumentVerified = 0
							END
							ELSE
							BEGIN
								SET @DocumentVerified = 1
							END

					   -- UPDATE Detail in CabManagement
					   UPDATE CabManagement 
					   SET VendorID=@VendorId,CabNumberFirst=@CabNumberFirst,CabNumberLast=@CabNumberLast,
					   CabType=@CabType,CabCapacity=@CabCapacity,DriverId=@Driverid,DocumentsVerified=@DocumentVerified,
					   EmpanelDate=@Empaneldate,
					   --IsActive=@IsActive,
					   Comment=@Comment,ModifiedDate=CONVERT(DATE,GETDATE()),ModifiedBy=@ModifiedBy
					   WHERE CabId=@CabID
					   
					   -- UPDATE Detail in CabVerification
					     DECLARE @INTIALVAL AS INT=1
						 DECLARE @MAXVAL AS INT
						 DECLARE @PROPERTYID AS INT
						 DECLARE @ExpiryDate AS DATE
						 DECLARE @propIsActive AS BIT
						 DECLARE @RowIdNo AS INT
						 SET @MAXVAL =(SELECT COUNT(PropertyId) FROM @TableVar)
		
						 CREATE TABLE #PropertyDetails
						 (RowID INT IDENTITY,tmpPropertyID INT,tmpExpiryDate DATE, tmpIsCompulsory BIT)
		
						 INSERT INTO #PropertyDetails
						 (tmpPropertyID,tmpExpiryDate,tmpIsCompulsory)
						 (SELECT PropertyId,ExpiryDate,IsCompulsory FROM @TableVar )

						WHILE (@INTIALVAL<=@MAXVAL)
				BEGIN
						SELECT  @PROPERTYID= tmpPropertyID ,@ExpiryDate=tmpExpiryDate,@RowIdNo=@INTIALVAL FROM #PropertyDetails WHERE RowID=@INTIALVAL
				
						 IF(@ExpiryDate is null OR @ExpiryDate = '')
							BEGIN
								SET @propIsActive=0
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
								IF EXISTS (SELECT TOP(1) CabVerificationId FROM CabVerification WHERE  CabId =@CabID and PropertyId=@PROPERTYID)
									BEGIN
										UPDATE CabVerification
										SET ExpiryDate=NULL,IsActive=@propIsActive,ModifiedBy=@ModifiedBy,ModifiedDate=CONVERT(DATE,GETDATE())
										WHERE CabId =@CabID and PropertyId=@PROPERTYID
									END
									ELSE
									BEGIN
										INSERT INTO CabVerification
										(CabId,PropertyId,ExpiryDate,IsActive,CreatedDate,CreatedBy,ModifiedBy,ModifiedDate)
										VALUES(@CabId,@PROPERTYID,NULL,@propIsActive,CONVERT(DATE,GETDATE()),@ModifiedBy,NULL,NULL)
									END
																
							END
							ELSE
							BEGIN
							IF EXISTS (SELECT TOP(1) CabVerificationId FROM CabVerification WHERE  CabId =@CabID and PropertyId=@PROPERTYID)
									BEGIN
										UPDATE CabVerification
										SET ExpiryDate=@ExpiryDate,IsActive=@propIsActive,ModifiedBy=@ModifiedBy,ModifiedDate=CONVERT(DATE,GETDATE())
										WHERE CabId =@CabID and PropertyId=@PROPERTYID		
									END
									ELSE
									BEGIN
										INSERT INTO CabVerification
										(CabId,PropertyId,ExpiryDate,IsActive,CreatedDate,CreatedBy,ModifiedBy,ModifiedDate)
										VALUES(@CabId,@PROPERTYID,@ExpiryDate,@propIsActive,CONVERT(DATE,GETDATE()),@ModifiedBy,NULL,NULL)
									END
														
							END


						SET @INTIALVAL=@INTIALVAL+1
				END
		
						DROP TABLE #PropertyDetails


			    COMMIT
		END TRY
		
		BEGIN CATCH
				ROLLBACK ;
				THROW;
		END CATCH

END
GO


