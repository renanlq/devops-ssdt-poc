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