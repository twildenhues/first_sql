CREATE VIEW [dbo].[viCompany]
	AS SELECT c.Id, c.Name, c.CreatedTime, c.DeletedTime, a.Country, a.City, a.ZIP, a.Street  FROM [Company] c
		LEFT OUTER JOIN Address2Company a2c
			ON a2c.CompanyId = c.Id 
		LEFT OUTER JOIN Address a
			ON a2c.AddressId = a.Id
WHERE c.DeletedTime IS NULL;
