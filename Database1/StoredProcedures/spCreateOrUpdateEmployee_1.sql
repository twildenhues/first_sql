CREATE PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@FirstName nvarchar(128),
	@LastName nvarchar(128),
	@Birthday date,
	@DepartementId int,
	@Gender int,
	@GenderAsString nvarchar (128),
	@Id int = -1
AS
BEGIN 
	if(@Gender = 1)
	begin
		Set @GenderAsString = 'Male'
	end
	else if(@Gender = 2)
	begin
		Set @GenderAsString = 'Female'
	end 
	else if(@Gender = 3)
	begin
		Set @GenderAsString = 'Something else'
	end
	declare @DBId int
	Set @DBId = (select Id from Employee where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Employee(FirstName , LastName, Gender, DepartementId, Birthday)
		VALUES (@FirstName, @LastName, @GenderAsString, @DepartementId, @Birthday)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Employee
			SET [FirstName] = @FirstName, [LastName] = @LastName, [Gender] = @Gender, [DepartementId] = @DepartementId, [Birthday] = @Birthday
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END