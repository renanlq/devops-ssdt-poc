CREATE PROCEDURE [dbo].[RemoveService] 
@ServiceId INT 
AS 
DELETE FROM Service WHERE 
ServiceId=@ServiceId 
RETURN 0;