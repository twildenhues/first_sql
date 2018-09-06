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
Die Spalte "[dbo].[Address].[EmplyoyeesId]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Address].[TimeStamp]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Address].[City]" in der Tabelle "[dbo].[Address]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[dbo].[Address].[ZIP]" in der Tabelle "[dbo].[Address]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[Address])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[AddressCompany].[IsDeleted]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[AddressCompany].[TimeStamp]" wird gelöscht, es könnte zu einem Datenverlust kommen.
*/

IF EXISTS (select top 1 1 from [dbo].[AddressCompany])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[AddressEmployee].[IsDeleted]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[AddressEmployee].[TimeStamp]" wird gelöscht, es könnte zu einem Datenverlust kommen.
*/

IF EXISTS (select top 1 1 from [dbo].[AddressEmployee])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[Company].[IsDeleted]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Company].[TimeStamp]" wird gelöscht, es könnte zu einem Datenverlust kommen.
*/

IF EXISTS (select top 1 1 from [dbo].[Company])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[Departement].[IsDeleted]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Departement].[TimeStamp]" wird gelöscht, es könnte zu einem Datenverlust kommen.
*/

IF EXISTS (select top 1 1 from [dbo].[Departement])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[Employee].[IsDeleted]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Employee].[TimeStamp]" wird gelöscht, es könnte zu einem Datenverlust kommen.
*/

IF EXISTS (select top 1 1 from [dbo].[Employee])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF__Address__TimeSta__182C9B23];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressCompany] DROP CONSTRAINT [DF__tmp_ms_xx__TimeS__239E4DCF];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressCompany] DROP CONSTRAINT [DF__tmp_ms_xx__IsDel__24927208];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressEmployee] DROP CONSTRAINT [DF__tmp_ms_xx__TimeS__6477ECF3];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressEmployee] DROP CONSTRAINT [DF__tmp_ms_xx__IsDel__656C112C];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Company] DROP CONSTRAINT [DF__tmp_ms_xx__TimeS__534D60F1];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Company] DROP CONSTRAINT [DF__tmp_ms_xx__IsDel__5441852A];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departement] DROP CONSTRAINT [DF__tmp_ms_xx__TimeS__59063A47];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departement] DROP CONSTRAINT [DF__tmp_ms_xx__IsDel__59FA5E80];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__tmp_ms_xx__TimeS__5CD6CB2B];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__tmp_ms_xx__IsDel__5DCAEF64];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressCompany] DROP CONSTRAINT [FK__AddressCo__Compa__5535A963];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Country]     NVARCHAR (128) NOT NULL,
    [City]        NVARCHAR (128) NOT NULL,
    [ZIP]         INT            NOT NULL,
    [Street]      NVARCHAR (128) NOT NULL,
    [Number]      INT            NOT NULL,
    [CreatedTime] DATETIME       DEFAULT GETDATE() NOT NULL,
    [DeletedTime] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Address])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Address] ([Id], [Country], [Street], [Number])
        SELECT   [Id],
                 [Country],
                 [Street],
                 [Number]
        FROM     [dbo].[Address]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] OFF;
    END

DROP TABLE [dbo].[Address];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Address]', N'Address';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[AddressCompany]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_AddressCompany] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [CompanysId]  INT            NOT NULL,
    [Country]     NVARCHAR (128) NOT NULL,
    [City]        NVARCHAR (128) NOT NULL,
    [Street]      NVARCHAR (128) NOT NULL,
    [Number]      INT            NOT NULL,
    [CreatedTime] DATETIME       DEFAULT GETDATE() NOT NULL,
    [DeletedTime] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[AddressCompany])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_AddressCompany] ON;
        INSERT INTO [dbo].[tmp_ms_xx_AddressCompany] ([Id], [CompanysId], [Country], [City], [Street], [Number])
        SELECT   [Id],
                 [CompanysId],
                 [Country],
                 [City],
                 [Street],
                 [Number]
        FROM     [dbo].[AddressCompany]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_AddressCompany] OFF;
    END

DROP TABLE [dbo].[AddressCompany];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_AddressCompany]', N'AddressCompany';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'[dbo].[AddressEmployee] wird geändert....';


GO
ALTER TABLE [dbo].[AddressEmployee] DROP COLUMN [IsDeleted], COLUMN [TimeStamp];


GO
ALTER TABLE [dbo].[AddressEmployee]
    ADD [CreatedTime] DATETIME DEFAULT GETDATE() NOT NULL,
        [DeletedTime] DATETIME NULL;


GO
PRINT N'[dbo].[Company] wird geändert....';


GO
ALTER TABLE [dbo].[Company] DROP COLUMN [IsDeleted], COLUMN [TimeStamp];


GO
ALTER TABLE [dbo].[Company] ALTER COLUMN [Name] NVARCHAR (128) NOT NULL;


GO
ALTER TABLE [dbo].[Company]
    ADD [CreatedTime] DATETIME DEFAULT GETDATE() NOT NULL,
        [DeletedTime] DATETIME NULL;


GO
PRINT N'[dbo].[Departement] wird geändert....';


GO
ALTER TABLE [dbo].[Departement] DROP COLUMN [IsDeleted], COLUMN [TimeStamp];


GO
ALTER TABLE [dbo].[Departement] ALTER COLUMN [DepartementName] NVARCHAR (128) NOT NULL;


GO
ALTER TABLE [dbo].[Departement]
    ADD [CreatedTime] DATETIME DEFAULT GETDATE() NOT NULL,
        [DeletedTime] DATETIME NULL;


GO
PRINT N'[dbo].[Employee] wird geändert....';


GO
ALTER TABLE [dbo].[Employee] DROP COLUMN [IsDeleted], COLUMN [TimeStamp];


GO
ALTER TABLE [dbo].[Employee] ALTER COLUMN [FirstName] NVARCHAR (128) NOT NULL;

ALTER TABLE [dbo].[Employee] ALTER COLUMN [LastName] NVARCHAR (128) NOT NULL;


GO
ALTER TABLE [dbo].[Employee]
    ADD [CreatedTime] DATETIME DEFAULT GETDATE() NOT NULL,
        [DeletedTime] DATETIME NULL;


GO
PRINT N'[dbo].[Address2Company] wird erstellt....';


GO
CREATE TABLE [dbo].[Address2Company] (
    [CreationTime] DATETIME NOT NULL,
    [AddressId]    INT      NOT NULL,
    [CompanyId]    INT      NOT NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [CompanyId] ASC)
);


GO
PRINT N'[dbo].[Address2Employee] wird erstellt....';


GO
CREATE TABLE [dbo].[Address2Employee] (
    [CreationTime] DATETIME NOT NULL,
    [AddressId]    INT      NOT NULL,
    [Id]           INT      NOT NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [Id] ASC)
);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company]
    ADD DEFAULT getDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee]
    ADD DEFAULT getDate() FOR [CreationTime];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressCompany] WITH NOCHECK
    ADD FOREIGN KEY ([CompanysId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Company] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Company] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address2Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Address2Employee] WITH NOCHECK
    ADD FOREIGN KEY ([Id]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'[dbo].[viAddressCompany] wird geändert....';


GO
ALTER VIEW [dbo].[viAddressCompany]
	AS SELECT ac.Id, ac.CompanysId, ac.Country, ac.City, ac.Street, ac.Number, ac.CreatedTime FROM [AddressCompany] ac
WHERE ac.DeletedTime = NULL;
GO
PRINT N'[dbo].[viAddressEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viAddressEmployee]
	AS SELECT ae.Id, ae.EmplyoyeesId, ae.Country, ae.City, ae.Street, ae.Number, ae.CreatedTime FROM [AddressEmployee] ae
WHERE ae.DeletedTime = NULL;
GO
PRINT N'[dbo].[viEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.CreatedTime  FROM [Employee] e 
	INNER JOIN AddressEmployee on e.Id = AddressEmployee.Id
WHERE e.DeletedTime = NULL;
GO
PRINT N'[dbo].[viCompany] wird geändert....';


GO
ALTER VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.CreatedTime FROM [Company] c
WHERE c.DeletedTime = NULL;
GO
PRINT N'[dbo].[viDepartement] wird geändert....';


GO
ALTER VIEW [dbo].[viDepartement]
	AS SELECT d.Id, d.CompanyId, d.ManagerId, d.DepartementName, d.CreatedTime FROM [Departement] d
WHERE d.DeletedTime = NULL;
GO
PRINT N'[dbo].[viAddress] wird erstellt....';


GO
CREATE VIEW [dbo].[viAddress]
	AS SELECT * FROM [Address]
GO
PRINT N'[dbo].[spCreateOrUpdateCompany] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Name nvarchar(128),
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Company where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Company (Name)
		VALUES (@Name)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Company
			SET [Name] = @Name
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END
GO
PRINT N'[dbo].[spCreateOrUpdateDepartement] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spCreateOrUpdateDepartement]
	@Name nvarchar(128),
	@Id int = -1,
	@CompanyId int 
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Departement where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Departement(DepartementName, CompanyId)
		VALUES (@Name, @CompanyId)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Departement
			SET [DepartementName] = @Name
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END
GO
PRINT N'[dbo].[spCreateOrUpdateEmployee] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@FirstName nvarchar(128),
	@LastName nvarchar(128),
	@Gender int,
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Employee(FirstName , LastName, Gender)
		VALUES (@FirstName, @LastName, @Gender)

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
PRINT N'Vorhandene Daten werden auf neu erstellte Einschränkungen hin überprüft.';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressCompany'), OBJECT_ID(N'dbo.Address2Company'), OBJECT_ID(N'dbo.Address2Employee'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Einschränkung wird überprüft: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Fehler beim Überprüfen der Einschränkung:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'Fehler beim Überprüfen von Einschränkungen', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update abgeschlossen.';


GO
