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
   [NewCollum] NCHAR(10) NULL,
   [Add] NCHAR(10) NULL,
   [Add2POC] NCHAR(10) NULL,
   [AddCollum2] NCHAR(10) NULL, 
    CONSTRAINT [PK_Client] PRIMARY KEY ([ClientId]) 
);
GO

CREATE UNIQUE INDEX [IX_Client_Column] ON [dbo].[Client] ([ClientId])
