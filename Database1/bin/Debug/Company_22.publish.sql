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
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@FirstName nvarchar(128),
	@LastName nvarchar(128),
	@DepartementId int,
	@Gender int,
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Employee(FirstName , LastName, Gender, DepartementId)
		VALUES (@FirstName, @LastName, @Gender, @DepartementId)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Employee
			SET [FirstName] = @FirstName
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
