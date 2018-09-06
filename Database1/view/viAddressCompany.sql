CREATE VIEW [dbo].[viAddressCompany]
	AS SELECT ac.Id, ac.CompanysId, ac.Country, ac.City, ac.Street, ac.Number, ac.CreatedTime FROM [AddressCompany] ac
WHERE ac.DeletedTime = NULL;
