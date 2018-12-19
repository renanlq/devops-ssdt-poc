/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
USE [ssdt_01]
GO
BEGIN TRY
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    BEGIN TRANSACTION

	/* CLIENTS */
	IF NOT EXISTS((SELECT [ClientId] FROM [dbo].[Client] WHERE [dbo].[Client].[Company] = 'Company 01'))
		INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 01', 'company01@company.com', '08000010001', GETDATE(), 1);

	IF NOT EXISTS((SELECT [ClientId] FROM [dbo].[Client] WHERE [dbo].[Client].[Company] = 'Company 02'))
		INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 02', 'company02@company.com', '08000020002', GETDATE(), 1);

	IF NOT EXISTS((SELECT [ClientId] FROM [dbo].[Client] WHERE [dbo].[Client].[Company] = 'Company 03'))
		INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 03', 'company03@company.com', '08000030003', GETDATE(), 1);

	IF NOT EXISTS((SELECT [ClientId] FROM [dbo].[Client] WHERE [dbo].[Client].[Company] = 'Company 04'))
		INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 04', 'company04@company.com', '08000040004', GETDATE(), 1);

	IF NOT EXISTS((SELECT [ClientId] FROM [dbo].[Client] WHERE [dbo].[Client].[Company] = 'Company 05'))
		INSERT INTO [dbo].[Client] ([Company], [Email], [Phone], [RegistrationDate], [Status]) VALUES ('Company 05', 'company05@company.com', '08000050005', GETDATE(), 1);

	/* SERVICES */
	IF NOT EXISTS((SELECT [ServiceId] FROM [dbo].[Service] WHERE [dbo].[Service].[Name] = 'Service 01'))
		INSERT INTO [dbo].[Service] ([ServiceId], [Name], [Detail], [Pricing]) VALUES (1, 'Service 01', 'Detail service 01', 100.00);

	IF NOT EXISTS((SELECT [ServiceId] FROM [dbo].[Service] WHERE [dbo].[Service].[Name] = 'Service 02'))
		INSERT INTO [dbo].[Service] ([ServiceId], [Name], [Detail], [Pricing]) VALUES (2, 'Service 02', 'Detail service 02', 200.00);

	IF NOT EXISTS((SELECT [ServiceId] FROM [dbo].[Service] WHERE [dbo].[Service].[Name] = 'Service 03'))
		INSERT INTO [dbo].[Service] ([ServiceId], [Name], [Detail], [Pricing]) VALUES (3, 'Service 03', 'Detail service 03', 300.00);

	/* SERVICE ORDERS */
	IF NOT EXISTS((SELECT [ServiceOrderId] FROM [dbo].[ServiceOrder] WHERE [dbo].[ServiceOrder].[ClientId] = 1 AND [dbo].[ServiceOrder].[ServiceId] = 1))
	BEGIN
		INSERT INTO [dbo].[ServiceOrder] ([ServiceOrderId], [ClientId], [ServiceId], [PurchaseDate], [AmountPaid], [Validity]) VALUES (
			1, (SELECT TOP 1 [ClientId] FROM [dbo].[Client] WHERE [Company] = 'Company 01'),
			(SELECT TOP 1 [ServiceId] FROM [dbo].[Service] WHERE [Name] = 'Service 01'),
			GETDATE(),
			1000.00,
			DATEADD(DAY, 1, GETDATE())
		);
	END
	IF NOT EXISTS((SELECT [ServiceOrderId] FROM [dbo].[ServiceOrder] WHERE [dbo].[ServiceOrder].[ClientId] = 2 AND [dbo].[ServiceOrder].[ServiceId] = 2))
	BEGIN
		INSERT INTO [dbo].[ServiceOrder] ([ServiceOrderId], [ClientId], [ServiceId], [PurchaseDate], [AmountPaid], [Validity]) VALUES (
			2, (SELECT TOP 1 [ClientId] FROM [dbo].[Client] WHERE [Company] = 'Company 02'),
			(SELECT TOP 1 [ServiceId] FROM [dbo].[Service] WHERE [Name] = 'Service 02'),
			GETDATE(),
			2000.00,
			DATEADD(DAY, 1, GETDATE())
		);
	END
	IF NOT EXISTS((SELECT [ServiceOrderId] FROM [dbo].[ServiceOrder] WHERE [dbo].[ServiceOrder].[ClientId] = 5 AND [dbo].[ServiceOrder].[ServiceId] = 3))
	BEGIN
		INSERT INTO [dbo].[ServiceOrder] ([ServiceOrderId], [ClientId], [ServiceId], [PurchaseDate], [AmountPaid], [Validity]) VALUES (
			3, (SELECT TOP 1 [ClientId] FROM [dbo].[Client] WHERE [Company] = 'Company 05'),
			(SELECT TOP 1 [ServiceId] FROM [dbo].[Service] WHERE [Name] = 'Service 03'),
			GETDATE(),
			5000.00,
			DATEADD(DAY, 1, GETDATE())
		);
	END

	COMMIT TRAN -- Transaction Success!
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN;

	SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO