CREATE VIEW [dbo].[viAddressCompany]
	AS SELECT ac.Id, ac.CompanysId, ac.Country, ac.City, ac.Street, ac.Number, ac.TimeStamp FROM [AddressCompany] ac
WHERE ac.IsDeleted = 0;
