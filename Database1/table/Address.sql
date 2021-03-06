﻿CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	[Country] NVARCHAR (128) NOT NULL,
	[City] NVARCHAR (128) NOT NULL,
	[Zip] INT NOT NULL,
	[Street] NVARCHAR (128) NOT NULL,
	[Number] INT ,
	[CreatedTime] DATETIME NOT NULL default GETDATE(),
	[DeletedTime] DATETIME
)
