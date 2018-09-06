CREATE VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.TimeStamp  FROM [Employees] e 
WHERE e.IsDeleted = 0;
