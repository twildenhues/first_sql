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
Die Spalte "[dbo].[AddressCompany].[City]" in der Tabelle "[dbo].[AddressCompany]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[AddressCompany])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[Employees].[first_name]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Employees].[last_name]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Employees].[FirstName]" in der Tabelle "[dbo].[Employees]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.

Die Spalte "[dbo].[Employees].[LastName]" in der Tabelle "[dbo].[Employees]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[Employees])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressCompany] DROP CONSTRAINT [DF__AddressCo__TimeS__1920BF5C];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employees] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT [DF__Employees__TimeS__1BFD2C07];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressCompany] DROP CONSTRAINT [FK__AddressCo__Compa__1DE57479];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK__Address__Emplyoy__1CF15040];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departements] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departements] DROP CONSTRAINT [FK__Departeme__Manag__1FCDBCEB];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employees] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT [FK__Employees__depar__20C1E124];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[AddressCompany]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_AddressCompany] (
    [Id]         INT           NOT NULL,
    [CompanysId] INT           NOT NULL,
    [Country]    NVARCHAR (64) NOT NULL,
    [City]       NVARCHAR (64) NOT NULL,
    [Street]     NVARCHAR (64) NOT NULL,
    [Number]     INT           NOT NULL,
    [TimeStamp]  DATETIME      DEFAULT GETDATE() NOT NULL,
    [IsDeleted]  BIT           DEFAULT 0 NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[AddressCompany])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_AddressCompany] ([Id], [CompanysId], [Country], [Street], [Number], [TimeStamp])
        SELECT   [Id],
                 [CompanysId],
                 [Country],
                 [Street],
                 [Number],
                 [TimeStamp]
        FROM     [dbo].[AddressCompany]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[AddressCompany];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_AddressCompany]', N'AddressCompany';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'[dbo].[Company] wird geändert....';


GO
ALTER TABLE [dbo].[Company]
    ADD [IsDeleted] BIT DEFAULT 0 NOT NULL;


GO
PRINT N'[dbo].[Departements] wird geändert....';


GO
ALTER TABLE [dbo].[Departements]
    ADD [IsDeleted] BIT DEFAULT 0 NOT NULL;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Employees]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Employees] (
    [Id]            INT           NOT NULL,
    [FirstName]     NVARCHAR (64) NOT NULL,
    [LastName]      NVARCHAR (64) NOT NULL,
    [Birthday]      DATE          NOT NULL,
    [DepartementId] INT           NOT NULL,
    [TimeStamp]     DATETIME      DEFAULT GETDATE() NOT NULL,
    [IsDeleted]     BIT           DEFAULT 0 NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Employees])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Employees] ([Id], [birthday], [departementId], [TimeStamp])
        SELECT   [Id],
                 [birthday],
                 [departementId],
                 [TimeStamp]
        FROM     [dbo].[Employees]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[Employees];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Employees]', N'Employees';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'[dbo].[AddressEmployees] wird erstellt....';


GO
CREATE TABLE [dbo].[AddressEmployees] (
    [Id]           INT           NOT NULL,
    [EmplyoyeesId] INT           NOT NULL,
    [Country]      NVARCHAR (64) NOT NULL,
    [City]         NVARCHAR (64) NOT NULL,
    [Street]       NVARCHAR (64) NOT NULL,
    [Number]       INT           NOT NULL,
    [TimeStamp]    DATETIME      NOT NULL,
    [IsDeleted]    BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployees] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployees]
    ADD DEFAULT GETDATE() FOR [TimeStamp];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployees] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployees]
    ADD DEFAULT 0 FOR [IsDeleted];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressCompany] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressCompany] WITH NOCHECK
    ADD FOREIGN KEY ([CompanysId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departements] wird erstellt....';


GO
ALTER TABLE [dbo].[Departements] WITH NOCHECK
    ADD FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employees] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employees] wird erstellt....';


GO
ALTER TABLE [dbo].[Employees] WITH NOCHECK
    ADD FOREIGN KEY ([DepartementId]) REFERENCES [dbo].[Departements] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployees] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployees] WITH NOCHECK
    ADD FOREIGN KEY ([EmplyoyeesId]) REFERENCES [dbo].[Employees] ([Id]);


GO
PRINT N'[dbo].[viAddressCompany] wird erstellt....';


GO
CREATE VIEW [dbo].[viAddressCompany]
	AS SELECT ac.Id, ac.CompanysId, ac.Country, ac.City, ac.Street, ac.Number, ac.TimeStamp FROM [AddressCompany] ac
WHERE ac.IsDeleted = 0;
GO
PRINT N'[dbo].[viAddressEmployee] wird erstellt....';


GO
CREATE VIEW [dbo].[viAddressEmployee]
	AS SELECT ae.Id, ae.EmplyoyeesId, ae.Country, ae.City, ae.Street, ae.Number, ae.TimeStamp FROM [AddressEmployees] ae
WHERE ae.IsDeleted = 0;
GO
PRINT N'[dbo].[viCompany] wird erstellt....';


GO
CREATE VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.TimeStamp FROM [Company] c
WHERE c.IsDeleted = 0;
GO
PRINT N'[dbo].[viDepartement] wird erstellt....';


GO
CREATE VIEW [dbo].[viDepartement]
	AS SELECT d.Id, d.CompanyId, d.ManagerId, d.DepartementName, d.TimeStamp FROM [Departements] d
WHERE d.IsDeleted = 0;
GO
PRINT N'[dbo].[viEmployee] wird erstellt....';


GO
CREATE VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.TimeStamp  FROM [Employees] e 
WHERE e.IsDeleted = 0;
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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressCompany'), OBJECT_ID(N'dbo.Departements'), OBJECT_ID(N'dbo.Employees'), OBJECT_ID(N'dbo.AddressEmployees'))
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
