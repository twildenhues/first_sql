CREATE TABLE [dbo].[Address2Company]
(
	[CreationTime] DATETIME NOT NULL DEFAULT getDate(),
	[AddressId] INT NOT NULL REFERENCES Address(Id),
	[CompanyId] INT NOT NULL REFERENCES Company(Id),
	PRIMARY KEY ([AddressId], [CompanyId] )
)
