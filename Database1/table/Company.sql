CREATE TABLE [dbo].[Company]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] nvarchar (128) NOT NULL,
	[CreatedTime] DATETIME NOT NULL default GETDATE(),
	[DeletedTime] DATETIME
)