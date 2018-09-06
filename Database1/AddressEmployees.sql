CREATE TABLE [dbo].[AddressEmployees]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[EmplyoyeesId] INT NOT NULL REFERENCES Employees (Id),
	[Country] NVARCHAR (64) NOT NULL,
	[City] NVARCHAR (64) NOT NULL,
	[Street] NVARCHAR (64) NOT NULL,
	[Number] INT NOT NULL,
	[TimeStamp] DATETIME NOT NULL default GETDATE(),
	[IsDeleted] BIT NOT NULL DEFAULT 0
)
