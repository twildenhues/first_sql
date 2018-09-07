CREATE VIEW [dbo].[viDepartement]
	AS SELECT d.Id, d.CompanyId, d.ManagerId, d.DepartementName, d.CreatedTime FROM [Departement] d
WHERE d.DeletedTime IS NULL;
