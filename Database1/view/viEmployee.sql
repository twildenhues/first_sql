CREATE VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.CreatedTime  FROM [Employee] e 
	INNER JOIN AddressEmployee on e.Id = AddressEmployee.Id
WHERE e.DeletedTime = NULL;
