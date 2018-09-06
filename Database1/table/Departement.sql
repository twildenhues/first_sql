CREATE TABLE [dbo].[Departement]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[CompanyId] INT NOT NULL REFERENCES Company (Id),
	[ManagerId] INT REFERENCES Employee (Id),
	[DepartementName] NVARCHAR (128) NOT NULL,
	[CreatedTime] DATETIME NOT NULL default GETDATE(),
	[DeletedTime] DATETIME
);
