CREATE VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.CreatedTime, e.DeletedTime
  FROM [Employee] e 
WHERE e.DeletedTime IS NULL;
