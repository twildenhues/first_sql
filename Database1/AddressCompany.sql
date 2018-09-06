CREATE TABLE [dbo].[AddressCompany]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[CompanysId] INT NOT NULL REFERENCES Company (Id),
	[Country] NVARCHAR (64) NOT NULL,
	[City] NVARCHAR (64) NOT NULL,
	[Street] NVARCHAR (64) NOT NULL,
	[Number] INT NOT NULL,
	[TimeStamp] DATETIME NOT NULL default GETDATE(),
	[IsDeleted] BIT NOT NULL DEFAULT 0
)