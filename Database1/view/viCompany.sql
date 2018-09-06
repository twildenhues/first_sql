CREATE VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.CreatedTime FROM [Company] c
WHERE c.DeletedTime = NULL;
