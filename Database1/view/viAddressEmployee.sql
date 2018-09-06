CREATE VIEW [dbo].[viAddressEmployee]
	AS SELECT ae.Id, ae.EmplyoyeesId, ae.Country, ae.City, ae.Street, ae.Number, ae.CreatedTime FROM [AddressEmployee] ae
WHERE ae.DeletedTime = NULL;
