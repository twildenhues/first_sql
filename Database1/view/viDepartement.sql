CREATE VIEW [dbo].[viDepartement]
	AS SELECT d.Id, d.CompanyId, d.ManagerId, d.DepartementName, d.CreatedTime, e.FirstName, e.LastName, e.Gender FROM [Departement] d
		LEFT OUTER JOIN Employee e
			ON e.DepartementId = d.Id 
WHERE d.DeletedTime IS NULL;
