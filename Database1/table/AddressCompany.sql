CREATE TABLE [dbo].[AddressCompany]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	[CompanysId] INT NOT NULL REFERENCES Company (Id),
	[Country] NVARCHAR (128) NOT NULL,
	[City] NVARCHAR (128) NOT NULL,
	[Street] NVARCHAR (128) NOT NULL,
	[Number] INT NOT NULL,
	[CreatedTime] DATETIME NOT NULL default GETDATE(),
	[DeletedTime] DATETIME
)