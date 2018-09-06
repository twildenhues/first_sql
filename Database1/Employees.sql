CREATE TABLE [dbo].[Employees]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[FirstName] nvarchar (64) NOT NULL,
	[LastName] nvarchar (64) NOT NULL,
	[Birthday] date NOT NULL,
	[DepartementId] INT NOT NULL REFERENCES Departements (Id),
	[TimeStamp] DATETIME NOT NULL default GETDATE(),
	[IsDeleted] BIT NOT NULL default 0
);
