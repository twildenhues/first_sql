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
PRINT N'[dbo].[AddressEmployee] wird erstellt....';


GO
CREATE TABLE [dbo].[AddressEmployee] (
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
PRINT N'[dbo].[Departement] wird erstellt....';


GO
CREATE TABLE [dbo].[Departement] (
    [Id]              INT           NOT NULL,
    [CompanyId]       INT           NOT NULL,
    [ManagerId]       INT           NOT NULL,
    [DepartementName] NVARCHAR (64) NOT NULL,
    [TimeStamp]       DATETIME      NOT NULL,
    [IsDeleted]       BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'[dbo].[Employee] wird erstellt....';


GO
CREATE TABLE [dbo].[Employee] (
    [Id]            INT           NOT NULL,
    [FirstName]     NVARCHAR (64) NOT NULL,
    [LastName]      NVARCHAR (64) NOT NULL,
    [Birthday]      DATE          NOT NULL,
    [DepartementId] INT           NOT NULL,
    [TimeStamp]     DATETIME      NOT NULL,
    [IsDeleted]     BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployee]
    ADD DEFAULT GETDATE() FOR [TimeStamp];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployee]
    ADD DEFAULT 0 FOR [IsDeleted];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird erstellt....';


GO
ALTER TABLE [dbo].[Departement]
    ADD DEFAULT GETDATE() FOR [TimeStamp];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird erstellt....';


GO
ALTER TABLE [dbo].[Departement]
    ADD DEFAULT 0 FOR [IsDeleted];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee]
    ADD DEFAULT GETDATE() FOR [TimeStamp];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee]
    ADD DEFAULT 0 FOR [IsDeleted];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([EmplyoyeesId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird erstellt....';


GO
ALTER TABLE [dbo].[Departement] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Departement] wird erstellt....';


GO
ALTER TABLE [dbo].[Departement] WITH NOCHECK
    ADD FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
    ADD FOREIGN KEY ([DepartementId]) REFERENCES [dbo].[Departement] ([Id]);


GO
PRINT N'[dbo].[viAddressEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viAddressEmployee]
	AS SELECT ae.Id, ae.EmplyoyeesId, ae.Country, ae.City, ae.Street, ae.Number, ae.TimeStamp FROM [AddressEmployee] ae
WHERE ae.IsDeleted = 0;
GO
PRINT N'[dbo].[viDepartement] wird geändert....';


GO
ALTER VIEW [dbo].[viDepartement]
	AS SELECT d.Id, d.CompanyId, d.ManagerId, d.DepartementName, d.TimeStamp FROM [Departement] d
WHERE d.IsDeleted = 0;
GO
PRINT N'[dbo].[viEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.TimeStamp  FROM [Employee] e 
	INNER JOIN AddressEmployee on e.Id = AddressEmployee.Id
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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressEmployee'), OBJECT_ID(N'dbo.Departement'), OBJECT_ID(N'dbo.Employee'))
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
