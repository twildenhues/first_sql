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
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departement] DROP CONSTRAINT [DF__Departeme__TimeS__49C3F6B7];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departement] DROP CONSTRAINT [DF__Departeme__IsDel__4AB81AF0];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__Employee__TimeSt__4BAC3F29];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__Employee__IsDele__4CA06362];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departement] DROP CONSTRAINT [FK__Departeme__Manag__4F7CD00D];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird gelöscht....';


GO
ALTER TABLE [dbo].[Departement] DROP CONSTRAINT [FK__Departeme__Compa__5629CD9C];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [FK__Employee__Depart__5070F446];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressEmployee] DROP CONSTRAINT [FK__AddressEm__Emply__4D94879B];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Departement]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Departement] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [CompanyId]       INT           NOT NULL,
    [ManagerId]       INT           NOT NULL,
    [DepartementName] NVARCHAR (64) NOT NULL,
    [TimeStamp]       DATETIME      DEFAULT GETDATE() NOT NULL,
    [IsDeleted]       BIT           DEFAULT 0 NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Departement])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Departement] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Departement] ([Id], [CompanyId], [ManagerId], [DepartementName], [TimeStamp], [IsDeleted])
        SELECT   [Id],
                 [CompanyId],
                 [ManagerId],
                 [DepartementName],
                 [TimeStamp],
                 [IsDeleted]
        FROM     [dbo].[Departement]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Departement] OFF;
    END

DROP TABLE [dbo].[Departement];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Departement]', N'Departement';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Employee]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Employee] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]     NVARCHAR (64) NOT NULL,
    [LastName]      NVARCHAR (64) NOT NULL,
    [Birthday]      DATE          NOT NULL,
    [DepartementId] INT           NOT NULL,
    [TimeStamp]     DATETIME      DEFAULT GETDATE() NOT NULL,
    [IsDeleted]     BIT           DEFAULT 0 NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Employee])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Employee] ([Id], [FirstName], [LastName], [Birthday], [DepartementId], [TimeStamp], [IsDeleted])
        SELECT   [Id],
                 [FirstName],
                 [LastName],
                 [Birthday],
                 [DepartementId],
                 [TimeStamp],
                 [IsDeleted]
        FROM     [dbo].[Employee]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] OFF;
    END

DROP TABLE [dbo].[Employee];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Employee]', N'Employee';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird erstellt....';


GO
ALTER TABLE [dbo].[Departement] WITH NOCHECK
    ADD FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird erstellt....';


GO
ALTER TABLE [dbo].[Departement] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
    ADD FOREIGN KEY ([DepartementId]) REFERENCES [dbo].[Departement] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([EmplyoyeesId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'[dbo].[viDepartement] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viDepartement]';


GO
PRINT N'[dbo].[viEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viEmployee]';


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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Departement'), OBJECT_ID(N'dbo.Employee'), OBJECT_ID(N'dbo.AddressEmployee'))
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
