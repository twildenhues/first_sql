CREATE PROCEDURE [dbo].[spCreateOrUpdateAdress]
	@Country nvarchar(128) = NULL,
	@City nvarchar(128)= NULL,
	@Zip int = NULL,
	@Street int = NULL,
	@CompanyId int = NULL,
	@EmployeeId int = NULL,
	@Id int = -1
AS
BEGIN 
	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Address(
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
	end
	else
	begin

		UPDATE [dbo].Address
			SET [Country] = CASE WHEN @Country IS NULL THEN [Country] ELSE @Country END, 
				[City] = CASE WHEN @City IS NULL THEN [City] ELSE @City END, 
				[Zip] = CASE WHEN @Zip IS NULL THEN [Zip] ELSE @Zip END
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END