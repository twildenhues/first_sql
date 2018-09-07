CREATE PROCEDURE [dbo].[spCreateOrUpdateAdress]
	@Country nvarchar(128) = NULL,
	@City nvarchar(128)= NULL,
	@Zip int = NULL,
	@Street nvarchar (128) = NULL,
	@CompanyId int = NULL,
	@EmployeeId int = NULL,
	@Id int = -1
AS
BEGIN 
	declare @DBId int
	Set @DBId = (select Id from Address where Id = @Id)
	
	IF(@DBId is null)
	BEGIN 

		INSERT INTO [dbo].Address	(
									Country, 
									City, 
									Zip, 
									Street								
									)
		VALUES (
				@Country, 
				@City, 
				@Zip, 
				@Street
				)

		Set @DBId = @@IDENTITY

		IF (@CompanyId IS NULL) 
			BEGIN
			INSERT INTO [dbo].Address2Employee	(
													AddressId,
													Id
												)
										VALUES	(
													@DBId,	
													@EmployeeId
		
										)
		END	
		IF (@EmployeeId IS NULL) BEGIN
			INSERT INTO [dbo].Address2Company	(
													AddressId,
													CompanyId
												)
										VALUES	(
													@DBId,	
													@CompanyId
												)
		END
	END
	ELSE
	BEGIN

		UPDATE [dbo].Address
			SET [Country] = CASE WHEN @Country IS NULL THEN [Country] ELSE @Country END, 
				[City] = CASE WHEN @City IS NULL THEN [City] ELSE @City END, 
				[Zip] = CASE WHEN @Zip IS NULL THEN [Zip] ELSE @Zip END,
				[Street] = CASE WHEN @Street IS NULL THEN [Street] ELSE @Street END
			WHERE Id = @Id
	END
	
	SELECT @DBId
	RETURN @DBId
END