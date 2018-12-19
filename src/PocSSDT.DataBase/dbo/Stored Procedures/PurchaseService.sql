CREATE PROCEDURE [dbo].[PurchaseService] 
   @ClientId INT, 
   @ServiceId INT, 
   @PurchaseDate DATETIME2, 
   @AmountPaid DECIMAL (10,2), 
   @Validity DATETIME2 
AS 
INSERT INTO ServiceOrder 
(ClientId,ServiceId,PurchaseDate,AmountPaid,Validity) 
VALUES 
(@ClientId,@ServiceId,@PurchaseDate,@AmountPaid,@Validity) 
RETURN 0;