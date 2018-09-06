CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	[FirstName] nvarchar (128) NOT NULL,
	[LastName] nvarchar (128) NOT NULL,
	[Birthday] date NOT NULL,
	[DepartementId] INT NOT NULL REFERENCES Departement (Id),
	[Gender] nvarchar (128) NOT NULL,
	[CreatedTime] DATETIME NOT NULL default GETDATE(),
	[DeletedTime] DATETIME
);
