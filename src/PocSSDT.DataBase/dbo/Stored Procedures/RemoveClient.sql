CREATE PROCEDURE [dbo].[RemoveClient] 
    @ClientId INT 
AS 
DELETE FROM dbo.Client WHERE ClientId=@ClientId 
RETURN 0;