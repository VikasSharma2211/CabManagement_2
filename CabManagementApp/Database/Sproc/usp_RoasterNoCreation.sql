USE [CabTransport]
GO

/****** Object:  StoredProcedure [dbo].[usp_RoasterNoCreation]    Script Date: 3/25/2015 11:36:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_RoasterNoCreation')
DROP PROCEDURE [dbo].[usp_RoasterNoCreation]
GO 

CREATE PROCEDURE [dbo].[usp_RoasterNoCreation]
@Prefix VARCHAR(40),
@RoosterNumber NVARCHAR(40) out
AS 
  DECLARE @LastInsertedPreFix VARCHAR(20)

   DECLARE @LastId int

BEGIN
      BEGIN TRY
	   SET NOCOUNT ON;
					
					 SET @LastInsertedPreFix=(SELECT TOP 1 PreFix FROM RoasterNoCreation ORDER BY PreFix DESC)
					  IF (@LastInsertedPreFix='' OR @LastInsertedPreFix IS NULL )
							 BEGIN
												 insert into RoasterNoCreation (PreFix) values(@Prefix)
												 select @RoosterNumber=(SELECT TOP 1 RosterNo FROM RoasterNoCreation where PreFix=@Prefix  ORDER BY convert(int,RosterNo) DESC)
							 END
					  ELSE
					         BEGIN 

							      IF(@LastInsertedPreFix =Convert(VARCHAR(10),GETDATE(),12))
										 BEGIN

			
												 insert into RoasterNoCreation (PreFix) values(@Prefix)
											
												 select @RoosterNumber=(SELECT TOP 1 RosterNo FROM RoasterNoCreation where PreFix=@Prefix  ORDER BY convert(int,RosterNo) DESC)
											
												
										 END
								  ELSE
										 BEGIN
												 DBCC CHECKIDENT(RoasterNoCreation , RESEED, 0); -- RESET THE SEED
												insert into RoasterNoCreation (PreFix) values(@Prefix)
											 select @RoosterNumber=(SELECT TOP 1 RosterNo FROM RoasterNoCreation where PreFix=@Prefix  ORDER BY convert(int,RosterNo) DESC)
											
												
										 END
							 END
	 
	  END TRY

	  BEGIN CATCH
	    THROW;
	  END CATCH
END



-- DBCC CHECKIDENT(RoasterNoCreation , RESEED, 0); -- RESET THE SEED
--insert into RoasterNoCreation (PreFix) values(150213)
--select * from RoasterNoCreation

-- insert into RoasterNoCreation (PreFix) values(150213)
											
-- select @RoosterNumber=(SELECT TOP 1 RosterNo FROM RoasterNoCreation where PreFix=150213  ORDER BY convert(int,RosterNo) DESC)
											
GO


