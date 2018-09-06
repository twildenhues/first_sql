CREATE TABLE [dbo].[AddressEmployee]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[EmplyoyeesId] INT NOT NULL REFERENCES Employee (Id),
	[Country] NVARCHAR (64) NOT NULL,
	[City] NVARCHAR (64) NOT NULL,
	[Street] NVARCHAR (64) NOT NULL,
	[Number] INT NOT NULL,
	[CreatedTime] DATETIME NOT NULL default GETDATE(),
	[DeletedTime] DATETIME
)
