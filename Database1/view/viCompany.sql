CREATE VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.CreatedTime, c.DeletedTime FROM [Company] c
WHERE c.DeletedTime IS NULL;
