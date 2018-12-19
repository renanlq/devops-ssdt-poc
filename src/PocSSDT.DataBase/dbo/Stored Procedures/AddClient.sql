CREATE PROCEDURE [dbo].[AddClient] 
   @Company VARCHAR(40) , 
   @Email VARCHAR(320) , 
   @Phone VARCHAR(50) , 
   @RegistrationDate DATETIME2, 
   @Status bit -- 1 active, 0 closed 
AS 
SET NOCOUNT ON 
	INSERT INTO dbo.Client (Company,Email,Phone,RegistrationDate,Status) 
	VALUES (@Company,@Email,@Phone,@RegistrationDate,@Status) 
RETURN 0;