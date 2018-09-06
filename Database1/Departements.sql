CREATE TABLE [dbo].[Departements]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[CompanyId] INT NOT NULL REFERENCES Company (Id),
	[ManagerId] INT NOT NULL REFERENCES Employees (Id),
	[DepartementName] NVARCHAR (64) NOT NULL,
	[TimeStamp] DATETIME NOT NULL default GETDATE(),
	[IsDeleted] BIT NOT NULL DEFAULT 0
);
