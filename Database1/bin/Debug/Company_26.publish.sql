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
PRINT N'[dbo].[Employee] wird geändert....';


GO
ALTER TABLE [dbo].[Employee] ALTER COLUMN [Gender] NVARCHAR (128) NULL;


GO
PRINT N'[dbo].[viEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.CreatedTime, e.DeletedTime
  FROM [Employee] e 
		LEFT OUTER JOIN Address a
		ON a.Id = e.Id 
WHERE e.DeletedTime IS NULL;
GO
PRINT N'[dbo].[viCompany] wird geändert....';


GO
ALTER VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.CreatedTime, c.DeletedTime FROM [Company] c
		LEFT OUTER JOIN Address a
		ON a.Id = c.Id 
WHERE c.DeletedTime IS NULL;
GO
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@FirstName nvarchar(128) = NULL,
	@LastName nvarchar(128)= NULL,
	@Birthday date = NULL,
	@DepartementId int = NULL,
	@Gender int = NULL,
	@Id int = -1
AS
BEGIN 
	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Employee	(
									FirstName , 
									LastName, 
									Gender, 
									DepartementId, 
									Birthday
									)
		VALUES (
				@FirstName, 
				@LastName, 
				@Gender, 
				@DepartementId, 
				@Birthday
				)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Employee
			SET [FirstName] = CASE WHEN @FirstName IS NULL THEN [FirstName] ELSE @FirstName END, 
				[LastName] = CASE WHEN @LastName IS NULL THEN [LastName] ELSE @LastName END, 
				[Gender] = CASE WHEN @Gender IS NULL THEN [Gender] ELSE @Gender END, 
				[DepartementId] = CASE WHEN @DepartementId IS NULL THEN [DepartementId] ELSE @DepartementId END, 
				[Birthday] = CASE WHEN @Birthday IS NULL THEN [Birthday] ELSE @Birthday END
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END
GO
PRINT N'[dbo].[spCreateOrUpdateCompany] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Name nvarchar(128) = NULL,
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Company where Id = @Id)
	
	if(@DBId is null)
	BEGIN 

		INSERT INTO [dbo].Company	(
									Name, 
									CreatedTime
									)
		VALUES (@Name, GETDATE())

		Set @DBId = @@IDENTITY
	END
	ELSE
	BEGIN

		UPDATE [dbo].Company
			SET [Name] = CASE WHEN @Name IS NULL THEN [Name] ELSE @Name END
			WHERE Id = @Id
	END
	
	Select @DBId
	return @DBId
END
GO
PRINT N'[dbo].[spCreateOrUpdateDepartement] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateDepartement]
	@Name nvarchar(128) = NULL,
	@Id int = -1 ,
	@CompanyId int = NULL 
AS
BEGIN 

	DECLARE @DBId int
	SET @DBId = (select Id from Departement where Id = @Id)
	
	if(@DBId is null)
	BEGIN 

		INSERT INTO [dbo].Departement(
									DepartementName, 
									CompanyId, 
									CreatedTime
									)
		VALUES (
				@Name, 
				@CompanyId, 
				GETDATE()
				)

		SET @DBId = @@IDENTITY
	END
	ELSE
	BEGIN

		UPDATE [dbo].Departement
			SET [DepartementName] = CASE WHEN @Name IS NULL THEN [DepartementName] ELSE @Name END, 
				[CompanyId] =  CASE WHEN @CompanyId IS NULL THEN [CompanyId] ELSE @CompanyId END
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
