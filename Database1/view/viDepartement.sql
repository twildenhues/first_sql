CREATE VIEW [dbo].[viDepartement]
	AS SELECT d.Id, d.CompanyId, d.ManagerId, d.DepartementName, d.TimeStamp FROM [Departements] d
WHERE d.IsDeleted = 0;
