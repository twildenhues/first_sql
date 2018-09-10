CREATE VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.CreatedTime, a.Country, a.City, a.Zip, a.Street, d.DepartementName, d.ManagerId FROM [Company] c
		LEFT OUTER JOIN Address2Company a2c
			ON a2c.CompanyId = c.Id 
		LEFT OUTER JOIN Address a
			ON a2c.AddressId = a.Id
		LEFT OUTER JOIN Departement d
			ON d.CompanyId = c.Id
WHERE c.DeletedTime IS NULL;
