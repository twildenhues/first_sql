CREATE VIEW [dbo].[viAddressEmployee]
	AS SELECT ae.Id, ae.EmplyoyeesId, ae.Country, ae.City, ae.Street, ae.Number, ae.TimeStamp FROM [AddressEmployees] ae
WHERE ae.IsDeleted = 0;
