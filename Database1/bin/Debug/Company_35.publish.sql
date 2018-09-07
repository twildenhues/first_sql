/*
Bereitstellungsskript für Training-TW-Company

Dieser Code wurde von einem Tool generiert.
Änderungen an dieser Datei führen möglicherweise zu falschem Verhalten und gehen verloren, falls
der Code neu generiert wird.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Training-TW-Company"
:setvar DefaultFilePrefix "Training-TW-Company"
:setvar DefaultDataPath "D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Überprüfen Sie den SQLCMD-Modus, und deaktivieren Sie die Skriptausführung, wenn der SQLCMD-Modus nicht unterstützt wird.
Um das Skript nach dem Aktivieren des SQLCMD-Modus erneut zu aktivieren, führen Sie folgenden Befehl aus:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Der SQLCMD-Modus muss aktiviert sein, damit dieses Skript erfolgreich ausgeführt werden kann.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'[dbo].[spCreateOrUpdateAdress] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateAdress]
	@Country nvarchar(128) = NULL,
	@City nvarchar(128)= NULL,
	@Zip int = NULL,
	@Street nvarchar = NULL,
	@CompanyId int = NULL,
	@EmployeeId int = NULL,
	@Id int = -1
AS
BEGIN 
	declare @DBId int
	Set @DBId = (select Id from Address where Id = @Id)
	
	IF(@DBId is null)
	BEGIN 

		INSERT INTO [dbo].Address	(
									Country, 
									City, 
									Zip, 
									Street
									
									)
		VALUES (
				@Country, 
				@City, 
				@Zip, 
				@Street
				)

		Set @DBId = @@IDENTITY

		IF (@CompanyId IS NULL) 
			BEGIN
			INSERT INTO [dbo].Address2Employee	(
													AddressId,
													Id
												)
										VALUES	(
													@DBId,	
													@EmployeeId
		
										)
		END	
		IF (@EmployeeId IS NULL) BEGIN
			INSERT INTO [dbo].Address2Company	(
													AddressId,
													CompanyId
												)
										VALUES	(
													@DBId,	
													@CompanyId
												)
		END
	END
	ELSE
	BEGIN

		UPDATE [dbo].Address
			SET [Country] = CASE WHEN @Country IS NULL THEN [Country] ELSE @Country END, 
				[City] = CASE WHEN @City IS NULL THEN [City] ELSE @City END, 
				[Zip] = CASE WHEN @Zip IS NULL THEN [Zip] ELSE @Zip END
			WHERE Id = @Id
	END
	
	SELECT @DBId
	RETURN @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
