CREATE PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@FirstName nvarchar(128) = NULL,
	@LastName nvarchar(128)= NULL,
	@Birthday date = NULL,
	@DepartementId int = NULL,
	@Gender int = NULL,
	@Id int = -1
AS
BEGIN 
	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Employee	(
									FirstName , 
									LastName, 
									Gender, 
									DepartementId, 
									Birthday
									)
		VALUES (
				@FirstName, 
				@LastName, 
				@Gender, 
				@DepartementId, 
				@Birthday
				)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Employee
			SET [FirstName] = CASE WHEN @FirstName IS NULL THEN [FirstName] ELSE @FirstName END, 
				[LastName] = CASE WHEN @LastName IS NULL THEN [LastName] ELSE @LastName END, 
				[Gender] = CASE WHEN @Gender IS NULL THEN [Gender] ELSE @Gender END, 
				[DepartementId] = CASE WHEN @DepartementId IS NULL THEN [DepartementId] ELSE @DepartementId END, 
				[Birthday] = CASE WHEN @Birthday IS NULL THEN [Birthday] ELSE @Birthday END
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END