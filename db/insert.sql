USE [ssdt_01]
GO

INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 01', 'company01@company.com', '08000010001', GETDATE(), 1)
INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 02', 'company02@company.com', '08000020002', GETDATE(), 1)
INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 03', 'company03@company.com', '08000030003', GETDATE(), 1)
INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 04', 'company04@company.com', '08000040004', GETDATE(), 1)
INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 05', 'company05@company.com', '08000050005', GETDATE(), 1)

INSERT INTO [dbo].[Service] ([ServiceId], [Name], [Detail], [Pricing]) VALUES (1, 'Service 01', 'Detail service 01', 100.00)
INSERT INTO [dbo].[Service] ([ServiceId], [Name], [Detail], [Pricing]) VALUES (2, 'Service 02', 'Detail service 02', 200.00)
INSERT INTO [dbo].[Service] ([ServiceId], [Name], [Detail], [Pricing]) VALUES (3, 'Service 03', 'Detail service 03', 300.00)

INSERT INTO [dbo].[ServiceOrder] ([ServiceOrderId], [ClientId], [ServiceId], [PurchaseDate], [AmountPaid], [Validity]) VALUES (
    1, (SELECT TOP 1 [ClientId] FROM [dbo].[Client] WHERE [Company] = 'Company 01'),
    (SELECT TOP 1 [ServiceId] FROM [dbo].[Service] WHERE [Name] = 'Service 01'),
    GETDATE(),
    1000.00,
    DATEADD(DAY, 1, GETDATE())
)

INSERT INTO [dbo].[ServiceOrder] ([ServiceOrderId], [ClientId], [ServiceId], [PurchaseDate], [AmountPaid], [Validity]) VALUES (
    2, (SELECT TOP 1 [ClientId] FROM [dbo].[Client] WHERE [Company] = 'Company 02'),
    (SELECT TOP 1 [ServiceId] FROM [dbo].[Service] WHERE [Name] = 'Service 02'),
    GETDATE(),
    2000.00,
    DATEADD(DAY, 1, GETDATE())
)

INSERT INTO [dbo].[ServiceOrder] ([ServiceOrderId], [ClientId], [ServiceId], [PurchaseDate], [AmountPaid], [Validity]) VALUES (
    3, (SELECT TOP 1 [ClientId] FROM [dbo].[Client] WHERE [Company] = 'Company 05'),
    (SELECT TOP 1 [ServiceId] FROM [dbo].[Service] WHERE [Name] = 'Service 03'),
    GETDATE(),
    5000.00,
    DATEADD(DAY, 1, GETDATE())
)

GO