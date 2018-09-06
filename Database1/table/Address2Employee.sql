CREATE TABLE [dbo].[Address2Employee]
(
	[CreationTime] DATETIME NOT NULL DEFAULT getDate(),
	[AddressId] INT NOT NULL REFERENCES Address(Id),
	[Id] INT NOT NULL REFERENCES Employee(Id),
	PRIMARY KEY ([AddressId], [Id] )
)