CREATE VIEW [dbo].[viAddress]
	AS SELECT a.Id, a.Country, a.City, a.ZIP, a.Street, a.Number, a.CreatedTime FROM [Address] a
		WHERE a.DeletedTime IS NULL;
