CREATE TABLE [dbo].[Company]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Name] nvarchar (64) NOT NULL,
	[TimeStamp] DATETIME NOT NULL default GETDATE(),
	[IsDeleted] BIT NOT NULL DEFAULT 0
)
