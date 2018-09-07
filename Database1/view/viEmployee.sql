CREATE VIEW [dbo].[viEmployee]
	AS SELECT e.Id, e.FirstName, e.LastName, e.Birthday, e.DepartementId, e.CreatedTime, e.DeletedTime, a.Country, a.City, a.ZIP, a.Street FROM [Employee] e 
		INNER JOIN Address2Employee a2e
		ON a2e.Id = e.Id 
INNER JOIN Address a
		ON a2e.AddressId = a.Id
WHERE e.DeletedTime IS NULL;
