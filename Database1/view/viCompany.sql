CREATE VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.TimeStamp FROM [Company] c
WHERE c.IsDeleted = 0;
