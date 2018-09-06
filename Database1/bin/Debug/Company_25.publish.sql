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
/*
Die Spalte "Gender" der Tabelle "[dbo].[Employee]" muss von NULL in NOT NULL geändert werden. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript u. U. nicht. Um dieses Problem zu vermeiden, müssen Sie dieser Spalte für alle Zeilen Werte hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[Employee])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'[dbo].[Employee] wird geändert....';


GO
ALTER TABLE [dbo].[Employee] ALTER COLUMN [Gender] NVARCHAR (128) NOT NULL;


GO
PRINT N'[dbo].[viEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viEmployee]';


GO
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@FirstName nvarchar(128),
	@LastName nvarchar(128),
	@Birthday date,
	@DepartementId int,
	@Gender int,
	@GenderAsString nvarchar (128),
	@Id int = -1
AS
BEGIN 
	if(@Gender = 1)
	begin
		Set @GenderAsString = 'Male'
	end
	else if(@Gender = 2)
	begin
		Set @GenderAsString = 'Female'
	end 
	else if(@Gender = 3)
	begin
		Set @GenderAsString = 'Something else'
	end
	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Employee(FirstName , LastName, Gender, DepartementId, Birthday)
		VALUES (@FirstName, @LastName, @GenderAsString, @DepartementId, @Birthday)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Employee
			SET [FirstName] = @FirstName, [LastName] = @LastName, [Gender] = @Gender, [DepartementId] = @DepartementId, [Birthday] = @Birthday
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
