CREATE PROCEDURE [dbo].[AddService] 
   @Name VARCHAR(40), 
   @Detail VARCHAR(1000), 
   @Pricing DECIMAL(10,2) 
AS 
INSERT INTO Service 
(Name,Detail,Pricing) 
VALUES 
(@Name,@Detail,@Pricing) 
RETURN 0;