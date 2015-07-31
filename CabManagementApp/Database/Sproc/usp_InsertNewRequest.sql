USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertNewRequest]    Script Date: 3/25/2015 11:32:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_InsertNewRequest')
DROP PROCEDURE [dbo].[usp_InsertNewRequest]
GO  

CREATE PROCEDURE [dbo].[usp_InsertNewRequest]   
 -- Add the parameters for the stored procedure here
 @RequestType VARCHAR(10),
 @ReoccuringRequestId VARCHAR(20),
 @ToDate DATETIME,  
 @EmailId VARCHAR(100),  
 @BookingType VARCHAR(50),  
 @Gender VARCHAR(50),  
 @DCID INT,  
 @RouteId INT,  
 @RequestedDate DATETIME,  
 @RequestedTime TIME(7),  
 @Address VARCHAR(20),  
 @Mobile VARCHAR(15),  
 @RequestRemarks VARCHAR(500),  
 @CreatedBy VARCHAR(100),
 @Approver  VARCHAR(50)
AS  
BEGIN  
DECLARE @Temp VARCHAR(20);  
  DECLARE  @calculateday VARCHAR(20);  
  -- SET NOCOUNT ON added to prevent extra result sets from  
  -- interfering with SELECT statements.
  
  SET NOCOUNT ON;  
    -- Insert statements for procedure here 
 --IF NOT EXISTS(SELECT ReoccuringRequestId FROM OnDemandRequests)
	--	SET @Temp='RR1'
	--		ELSE IF(@ReoccuringRequestId LIKE 'No')
	--	SET	@Temp=NULL
	--	ELSE IF (@ReoccuringRequestId LIKE 'Yes')
		
	--	IF EXISTS(SELECT ReoccuringRequestId FROM OnDemandRequests WHERE EmailId=@EmailId AND RequestedDate != @RequestedDate  )
	--	set @Temp=(SELECT max(isnull(ReoccuringRequestId,) as ReoccuringRequestId FROM OnDemandRequests WHERE EmailId=@EmailId AND RequestedDate = @RequestedDate )
	--		ELSE
	--	SELECT @Temp='RR'+CAST(CAST(SUBSTRING(MAX(ReoccuringRequestId),3,5) AS INT)+1 AS varchar) FROM OnDemandRequests
	
  IF NOT EXISTS(SELECT ReoccuringRequestId FROM OnDemandRequests)
		SET @Temp='RR1'
			ELSE IF(@ReoccuringRequestId LIKE 'No')
		SET	@Temp=NULL
		ELSE IF (@ReoccuringRequestId LIKE 'Yes')
		
		SELECT @Temp='RR'+CAST(CAST(SUBSTRING(MAX(ReoccuringRequestId),3,5) AS INT)+1 AS varchar) FROM OnDemandRequests
	   

		WHILE(@RequestedDate <= @ToDate)
		BEGIN
		--set @calculateday=(SELECT DATENAME(dw, @RequestedDate) DayofWeek)
		
		--if(@calculateday  in ('Sunday','Saturday'))
		--SET @RequestedDate=DATEADD(day,1,@RequestedDate)

		--ELSE
		INSERT INTO OnDemandRequests  
		(RequestType,ReoccuringRequestId,EmailId,BookingType,Gender,DCID,RouteId,RequestedDate,RequestedTime,Address,Mobile,RequestRemarks,IsEditableByRequester  
		,CreatedBy,CreatedOn,Approver,IsApprovedStatus)  
		VALUES (@RequestType,@Temp,@EmailId,@BookingType,@Gender,@DCID,@RouteId,@RequestedDate,convert(time,@RequestedTime),@Address,@Mobile,@RequestRemarks,1,@CreatedBy,GETDATE(),@Approver,0)  
				SET @RequestedDate=DATEADD(day,1,@RequestedDate)			
	
	
	END
	END
	
GO


