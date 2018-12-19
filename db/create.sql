-- DigitalServices Database Setup Script 
-- Haroon Ashraf (09-Feb-2018) 
-- This script can be imported into a SQL Database Project to create the database objects for DigitalServices sample database 
-- Please Note: The script is provided "AS-IS" and should be used at your own discretion 
  
-- USE DigitalServices 
  
  
-- Creating Client Table 
CREATE TABLE [dbo].[Client] 
( 
   [ClientId] INT NOT NULL IDENTITY(1,1) , 
   [Company] VARCHAR(40) NOT NULL, 
   [Email] VARCHAR(320) NOT NULL, 
   [Phone] VARCHAR(50) NULL, 
   [RegistrationDate] DATETIME2, 
   [Status] bit, 
   CONSTRAINT [PK_Client] PRIMARY KEY ([ClientId]) 
); 
GO 
  
CREATE PROCEDURE [dbo].[AddClient] 
   @Company VARCHAR(40) , 
   @Email VARCHAR(320) , 
   @Phone VARCHAR(50) , 
   @RegistrationDate DATETIME2, 
   @Status bit -- 1 active, 0 closed 
AS 
SET NOCOUNT ON 
INSERT INTO dbo.Client 
(Company,Email,Phone,RegistrationDate,Status) 
VALUES 
(@Company,@Email,@Phone,@RegistrationDate,@Status) 
RETURN 0; 
GO 
    
CREATE PROCEDURE [dbo].[RemoveClient] 
    @ClientId INT 
AS 
DELETE FROM dbo.Client WHERE ClientId=@ClientId 
RETURN 0; 
GO 
  
CREATE TABLE [dbo].[Service] 
( 
   [ServiceId] INT NOT NULL, 
   [Name] VARCHAR(40), 
   [Detail] VARCHAR(1000), 
   [Pricing] DECIMAL(10,2), 
   CONSTRAINT [PK_Service] PRIMARY KEY ([ServiceId]) 
); 
GO 
  
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
GO 
  
CREATE PROCEDURE [dbo].[RemoveService] 
@ServiceId INT 
AS 
DELETE FROM Service WHERE 
ServiceId=@ServiceId 
RETURN 0; 
GO 
  
CREATE TABLE [dbo].[ServiceOrder] 
( 
   [ServiceOrderId] INT NOT NULL , 
   [ClientId] INT, 
   [ServiceId] INT, 
   [PurchaseDate] DATETIME2, 
   [AmountPaid] DECIMAL (10,2), 
   [Validity] DATETIME2, 
   CONSTRAINT [PK_ServiceOrder] PRIMARY KEY ([ServiceOrderId]), 
   CONSTRAINT [FK_ServiceOrder_Client] FOREIGN KEY ([ClientId]) REFERENCES [Client]([ClientId]), 
   CONSTRAINT [FK_ServiceOrder_ToTable] FOREIGN KEY ([ServiceId]) REFERENCES [Service]([ServiceId]) 
); 
GO 
  
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
GO 